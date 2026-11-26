-- Bot levels and prestige emblems on the scoreboard (Bot Skins, Loadouts & Ranks mod).
-- Changes bots only. Log lines: "botlevel" in poi_reg.log.
(function()
if rawget(_G, "__botLevelsLoaded") then return end
rawset(_G, "__botLevelsLoaded", true)

local DV_SET, DV_GET, LOG_DVAR = "1e3cb005036e0c0f", "254084d7ca2317bb", "67730584afc6ee3d"
local PRESTIGE_DVAR = "b165e21dd25238ee"
local function uleb(n) local t = {} repeat local b = n % 128; n = math.floor(n / 128); if n > 0 then b = b + 128 end; t[#t+1] = string.char(b) until n == 0; return table.concat(t) end
local HC = {}
local function H(hex, kind)
  kind = kind or 0
  local ck = hex .. ":" .. kind
  if HC[ck] then return HC[ck] end
  local h = hex:gsub("^0*", ""); h = string.rep("0", 16 - #h) .. h
  local b8 = {}
  for i = 8, 1, -1 do b8[#b8+1] = string.char(tonumber(h:sub(i*2-1, i*2), 16)) end
  local kgc = string.char(4, kind) .. table.concat(b8)
  local bc = string.char(0x28, 0, 0, 0) .. string.char(0x4d, 0, 2, 0)
  local body = string.char(0, 0, 2, 0) .. uleb(1) .. uleb(0) .. uleb(2) .. bc .. kgc
  local chunk = string.char(27) .. "LJ" .. string.char(0x84) .. uleb(0x1a) .. uleb(#body) .. body .. string.char(0)
  HC[ck] = assert(load(chunk))()
  return HC[ck]
end
local function getDvar(hx)
  local ok, v = pcall(function() return Dvar[H(DV_GET)](H(hx, 1)) end)
  return ok and tostring(v) or ("err " .. tostring(v))
end
local function L(s)
  pcall(function()
    local cur = getDvar(LOG_DVAR)
    if cur:sub(1, 4) == "err " then cur = "" end
    local seq = (tonumber(cur:match("^(%d+)\t") or "") or 0) + 1
    local lines = { seq .. "\t" .. tostring(s):gsub("[\t\n\r]", " "):sub(1, 180) }
    for line in cur:gmatch("[^\n]+") do
      if #lines < 10 and line:match("^%d+\t") then lines[#lines + 1] = line end
    end
    Dvar[H(DV_SET)](H(LOG_DVAR, 1), table.concat(lines, "\n"))
  end)
end

local unpack = unpack or table.unpack
local BL = { byXuid = {}, byClient = {}, prest = {}, prestRaw = nil, stack = {}, wrapped = setmetatable({}, { __mode = "k" }),
  q = {}, logs = 0, n = 0, hit = 0, miss = 0, noctx = 0, pct = 0, icon = 0, stats = 0 }
BL.KX, BL.KC = H("eb5c735486fc7ccb"), H("bb5757687f3ca121")
BL.KCS = tostring(BL.KC)
BL.fmt = function(v)
  local t = type(v)
  if t == "number" or t == "boolean" or t == "nil" then return tostring(v) end
  if t == "string" then return '"' .. v:sub(1, 36) .. '"' end
  local hx = tostring(v):match("#x(%x+)")
  if hx then return "#" .. hx end
  return t
end
BL.log = function(s)
  if BL.logs < 40 then BL.logs = BL.logs + 1; BL.q[#BL.q + 1] = "botlevel " .. s:sub(1, 170) end
end
BL.tick = function()
  BL.n = BL.n + 1
  if #BL.q > 0 and BL.n % 60 == 0 then L(table.remove(BL.q, 1)) end
  if BL.n % 20000 == 0 and BL.stats < 3 then
    BL.stats = BL.stats + 1
    local known, np = 0, 0
    for _, b in pairs(BL.byClient) do if b.isBot then known = known + 1 end end
    for _ in pairs(BL.prest) do np = np + 1 end
    BL.log("stats bots " .. known .. " prestiges " .. np .. " level " .. BL.hit .. " miss " .. BL.miss .. " icon " .. BL.icon .. " title " .. BL.pct .. " agg " .. tostring(BL.agg or 0))
  end
end
BL.pack = function(...) return { n = select("#", ...), ... } end
BL.get = function(ds)
  if type(ds) == "table" and type(ds.GetValue) == "function" then
    local ok, v = pcall(ds.GetValue, ds, 0)
    if ok then return v end
  end
end

BL.readPrestige = function()
  local s = getDvar(PRESTIGE_DVAR)
  if s == BL.prestRaw or s:sub(1, 4) == "err " then return end
  BL.prestRaw = s
  BL.prest = {}
  local n = 0
  for name, p in s:gmatch("([^|;]+)|(%-?%d+);") do BL.prest[name] = tonumber(p); n = n + 1 end
  BL.log("prestiges from the bot script: " .. n)
end
BL.prestigeImage = function(p)
  local PR = rawget(_G, "PRESTIGE")
  local f = type(PR) == "table" and PR[H("a875e1668a34631f")]
  if type(f) ~= "function" then return end
  local img = f(p)
  local C = rawget(_G, "CoD")
  if img == nil or img == "" or (type(C) == "table" and (img == C.PLACEHOLDER_TEXTURE_STR or img == C.ERROR_TEXTURE)) then return end
  return img
end
BL.seen = {}
BL.noteIcon = function(b, r, p, img, how)
  local key = tostring(b.name)
  local val = r .. "," .. p .. "," .. BL.fmt(img)
  if BL.seen[key] == val then return end
  BL.seen[key] = val
  BL.log("emblem " .. key .. " rank " .. r .. " prestige " .. p .. " -> " .. BL.fmt(img) .. " via " .. tostring(how))
end
BL.prestigeOf = function(b)
  if b.name and BL.prest[b.name] then return BL.prest[b.name] end
  if b.nameWithHash and BL.prest[b.nameWithHash] then return BL.prest[b.nameWithHash] end
end

BL.learnData = function(data)
  if type(data) ~= "table" then return end
  local cn, r = tonumber(rawget(data, "clientNum")), tonumber(rawget(data, "rank"))
  if not cn or not r then return end
  local b = BL.byClient[cn]
  if not b or b.name ~= rawget(data, "name") then
    b = {}
    BL.byClient[cn] = b
    if rawget(data, "isBot") == true then BL.log("bot " .. cn .. " " .. tostring(rawget(data, "name")) .. " rank " .. r) end
  end
  b.rank, b.para, b.isBot = r, tonumber(rawget(data, "prestige")) or 0, rawget(data, "isBot") == true
  b.name, b.nameWithHash = rawget(data, "name"), rawget(data, "nameWithHash")
  return b
end
BL.learnXuid = function(rowDS, b)
  if type(rowDS) ~= "table" or not b then return end
  local x = BL.get(rawget(rowDS, BL.KX))
  if x == nil or x == "" then return end
  x = tostring(x)
  if b.isBot then BL.byXuid[x] = b else BL.byXuid[x] = nil end
end
BL.bot = function(b) if b and b.isBot then return b end end
BL.findBot = function(ctx)
  for _, src in ipairs(ctx) do
    local t, depth = src, 0
    while type(t) == "table" and depth < 6 do
      local v = BL.get(t)
      if tostring(rawget(t, "_parentKey")) == BL.KCS and tonumber(v) then
        local b = BL.bot(BL.byClient[tonumber(v)])
        if b then return b, "client" .. depth end
      end
      local b = v ~= nil and BL.bot(BL.byXuid[tostring(v)])
      if b then return b, "xuid" .. depth end
      local pk = rawget(t, "_parentKey")
      b = pk ~= nil and BL.bot(BL.byXuid[tostring(pk)])
      if b then return b, "pkey" .. depth end
      local okc, c = pcall(BL.get, rawget(t, BL.KC))
      b = okc and tonumber(c) and BL.bot(BL.byClient[tonumber(c)])
      if b then return b, "row" .. depth end
      t = rawget(t, "_parent"); depth = depth + 1
    end
  end
end
BL.current = function(xuid)
  local b = xuid ~= nil and BL.bot(BL.byXuid[tostring(xuid)])
  if b then return b, "xuid" end
  if BL.row then return BL.bot(BL.row), "row" end
  local ctx = BL.stack[#BL.stack]
  if ctx then
    local okb, bb, how = pcall(BL.findBot, ctx)
    if okb and bb then return bb, how end
  end
end

BL.wrapAggregates = function()
  local A = rawget(_G, "LUI") and LUI.AggregateDataSource
  if type(A) ~= "table" or type(A.new) ~= "function" or BL.wrapped[A] then return end
  BL.wrapped[A] = true
  local orig = A.new
  A.new = function(root, sources, path, fn, ...)
    if type(fn) == "function" and type(sources) == "table" then
      local f0 = fn
      fn = function(...)
        pcall(BL.tick)
        BL.stack[#BL.stack + 1] = sources
        local res = BL.pack(pcall(f0, ...))
        BL.stack[#BL.stack] = nil
        if not res[1] then error(res[2], 0) end
        local v = res[2]
        if type(v) == "string" and v:find("icon_rank", 1, true) then
          local okr, img = pcall(BL.aggIcon, sources, v, path)
          if okr and img then res[2] = img end
        elseif v ~= nil and type(v) ~= "string" and type(v) ~= "number" and type(v) ~= "boolean" and type(v) ~= "table"
          and BL.levelHash(v) then
          local okr, img = pcall(BL.aggIconHash, sources, v, path)
          if okr and img then res[2] = img end
        end
        return unpack(res, 2, res.n)
      end
    end
    return orig(root, sources, path, fn, ...)
  end
  BL.log("aggregates tracked")
end
BL.LVH = { ["513a9a7127cb9dc0"]=1, ["513a9d7127cba2d9"]=2, ["513a9c7127cba126"]=3, ["513a9f7127cba63f"]=4, ["513a9e7127cba48c"]=5, ["513aa17127cba9a5"]=6, ["513aa07127cba7f2"]=7, ["513aa37127cbad0b"]=8, ["513aa27127cbab58"]=9, ["5137357127c8bc4a"]=10, ["5137367127c8bdfd"]=11, ["5137337127c8b8e4"]=12, ["5137347127c8ba97"]=13, ["5137317127c8b57e"]=14, ["5137327127c8b731"]=15, ["51372f7127c8b218"]=16, ["5137307127c8b3cb"]=17, ["51372d7127c8aeb2"]=18, ["51372e7127c8b065"]=19, ["51342f7127c67c41"]=20, ["51342e7127c67a8e"]=21, ["51342d7127c678db"]=22, ["51342c7127c67728"]=23, ["5134337127c6830d"]=24, ["5134327127c6815a"]=25, ["5134317127c67fa7"]=26, ["5134307127c67df4"]=27, ["5134277127c66ea9"]=28, ["5134267127c66cf6"]=29, ["5130a97127c362b8"]=30, ["5130aa7127c3646b"]=31, ["5130ab7127c3661e"]=32, ["5130ac7127c367d1"]=33, ["5130ad7127c36984"]=34, ["5130ae7127c36b37"]=35, ["5130af7127c36cea"]=36, ["5130b07127c36e9d"]=37, ["5130a17127c35520"]=38, ["5130a27127c356d3"]=39, ["5148337127d72c17"]=40, ["5148327127d72a64"]=41, ["5148357127d72f7d"]=42, ["5148347127d72dca"]=43, ["51482f7127d7254b"]=44, ["51482e7127d72398"]=45, ["5148317127d728b1"]=46, ["5148307127d726fe"]=47, ["51482b7127d71e7f"]=48, ["51482a7127d71ccc"]=49, ["51452d7127d4ec0e"]=50, ["51452e7127d4edc1"]=51, ["51452b7127d4e8a8"]=52, ["51452c7127d4ea5b"]=53, ["5145317127d4f2da"]=54, ["5145327127d4f48d"]=55 }
BL.PRH = { "07e9095e7b832154", "07e90c5e7b83266d", "07e90b5e7b8324ba", "07e9065e7b831c3b", "07e9055e7b831a88", "07e9085e7b831fa1", "07e9075e7b831dee", "07e9025e7b83156f", "07e9015e7b8313bc", "07e5845e7b80097e" }
BL.hashHex = function(v)
  local hx = tostring(v):match("#x(%x+)")
  if not hx or #hx < 2 then return end
  hx = hx:sub(2)
  return string.rep("0", 16 - #hx) .. hx
end
BL.levelHash = function(v)
  local ok, hx = pcall(BL.hashHex, v)
  return ok and hx and BL.LVH[hx]
end
BL.prestigeHash = function(v, p)
  local hx = BL.hashHex(v)
  if not BL.hkind then
    for k = 0, 7 do
      local ok, h = pcall(H, hx, k)
      if ok and tostring(h) == tostring(v) then BL.hkind = k; break end
    end
    BL.log("emblem hash kind " .. tostring(BL.hkind) .. " (" .. tostring(v) .. ")")
  end
  if BL.hkind then return H(BL.PRH[p], BL.hkind) end
end
BL.aggIconHash = function(sources, v, path)
  local okb, b, how = pcall(BL.findBot, sources)
  if not (okb and b) then return end
  pcall(BL.readPrestige)
  local real = BL.prestigeOf(b)
  local new
  if b.rank < 55 and real and real >= 1 and real <= 10 then new = BL.prestigeHash(v, real) end
  BL.agg = (BL.agg or 0) + (new and 1 or 0)
  local key, val = tostring(b.name), BL.fmt(v) .. ">" .. BL.fmt(new)
  if BL.aggSeen[key] ~= val then
    BL.aggSeen[key] = val
    BL.log("aggicon " .. key .. " rank " .. b.rank .. " prestige " .. tostring(real) .. ": level" .. tostring(BL.levelHash(v))
      .. " " .. BL.fmt(v) .. (new and (" -> prestige " .. real .. " " .. BL.fmt(new)) or " kept") .. " via " .. tostring(how))
  end
  return new
end
BL.aggSeen = {}
BL.aggIcon = function(sources, img, path)
  local okb, b, how = pcall(BL.findBot, sources)
  if not (okb and b) then return end
  pcall(BL.readPrestige)
  local real = BL.prestigeOf(b)
  local new
  if b.rank < 55 and real and real >= 1 and real <= 10 then new = BL.prestigeImage(real) end
  BL.agg = (BL.agg or 0) + (new and 1 or 0)
  local key, val = tostring(b.name), BL.fmt(img) .. ">" .. BL.fmt(new)
  if BL.aggSeen[key] ~= val then
    BL.aggSeen[key] = val
    BL.log("aggicon " .. key .. " rank " .. b.rank .. " prestige " .. tostring(real) .. ": " .. BL.fmt(img)
      .. (new and (" -> " .. BL.fmt(new)) or " kept") .. " via " .. tostring(how))
  end
  return new
end
BL.rowCall = function(f, rowDS, data, ...)
  local okd, b = pcall(BL.learnData, data)
  local prev = BL.row
  BL.row = okd and b or nil
  local res = BL.pack(pcall(f, ...))
  BL.row = prev
  if okd and b then pcall(BL.learnXuid, rowDS, b) end
  if not res[1] then error(res[2], 0) end
  return unpack(res, 2, res.n)
end
BL.wrapScoreboard = function()
  local S = rawget(_G, "SCOREBOARD")
  if type(S) ~= "table" or BL.wrapped[S] then return end
  local kRow, kRow2, kList = H("895e4aff6e5f0d61"), H("80ded9d1a01f2bed"), H("9bdffab9e93729a")
  if type(S[kRow]) ~= "function" and type(S[kRow2]) ~= "function" then return end
  BL.wrapped[S] = true
  if type(S[kRow]) == "function" then
    local f = S[kRow]
    S[kRow] = function(rowDS, data, ...) return BL.rowCall(f, rowDS, data, rowDS, data, ...) end
  end
  if type(S[kRow2]) == "function" then
    local f = S[kRow2]
    S[kRow2] = function(el, rowDS, idx, data, ...) return BL.rowCall(f, rowDS, data, el, rowDS, idx, data, ...) end
  end
  if type(S[kList]) == "function" then
    local f = S[kList]
    S[kList] = function(...)
      local res = BL.pack(f(...))
      pcall(function()
        if type(res[1]) == "table" then
          for _, d in ipairs(res[1]) do BL.learnData(d) end
        end
      end)
      return unpack(res, 1, res.n)
    end
  end
  BL.log("scoreboard rows tracked")
end
BL.wrapProgression = function()
  local P = rawget(_G, "PROGRESSION")
  local k, kIcon = H("acffddd36aecf805"), H("d9c6922557618920")
  if type(P) ~= "table" or BL.wrapped[P] or type(P[k]) ~= "function" then return end
  BL.wrapped[P] = true
  local orig = P[k]
  BL.levelOf = orig
  P[k] = function(rank, ...)
    pcall(BL.tick)
    if (tonumber(rank) or 0) == 0 then
      local ctx = BL.stack[#BL.stack]
      if ctx then
        local okb, b, how = pcall(BL.findBot, ctx)
        if okb and b and b.rank > 0 then
          BL.hit = BL.hit + 1
          if BL.hit <= 3 then BL.log("level: rank 0 -> " .. b.rank .. " for " .. tostring(b.name) .. " via " .. tostring(how)) end
          return orig(b.rank, ...)
        end
        BL.miss = BL.miss + 1
      else
        BL.noctx = BL.noctx + 1
      end
    end
    return orig(rank, ...)
  end
  if type(P[kIcon]) == "function" then
    local icon = P[kIcon]
    P[kIcon] = function(rank, prestige, a3, a4, ...)
      local okb, b, how = pcall(BL.current, a4)
      if okb and b then
        pcall(BL.readPrestige)
        local r = tonumber(rank) or 0
        if r == 0 then r = b.rank end
        local p = tonumber(prestige) or 0
        local real = BL.prestigeOf(b)
        if r < 55 and real and real >= 1 and real <= 10 then
          local okp, img = pcall(BL.prestigeImage, real)
          if okp and img then
            BL.icon = BL.icon + 1
            BL.noteIcon(b, r, real, img, how)
            return img
          end
          p = real
        elseif r >= 55 and p == 0 then p = b.para end
        if r ~= (tonumber(rank) or 0) or p ~= (tonumber(prestige) or 0) then
          BL.icon = BL.icon + 1
          local res = BL.pack(icon(r, p, a3, a4, ...))
          BL.noteIcon(b, r, p, res[1], how)
          return unpack(res, 1, res.n)
        end
      end
      return icon(rank, prestige, a3, a4, ...)
    end
  end
  BL.log("level and emblem hooked")
end
BL.wrapTitle = function()
  local T = rawget(_G, "PRESTIGE_COLOR_AND_TITLE")
  local k = H("ccfad87cc05e84d6")
  if type(T) ~= "table" or BL.wrapped[T] or type(T[k]) ~= "function" then return end
  BL.wrapped[T] = true
  local orig = T[k]
  T[k] = function(c, level, flag, xuid, ...)
    local b = xuid ~= nil and BL.bot(BL.byXuid[tostring(xuid)])
    if b and (tonumber(level) or 1) <= 1 and b.rank > 0 and BL.levelOf then
      local ok, lv = pcall(BL.levelOf, b.rank)
      if ok and tonumber(lv) then
        BL.pct = BL.pct + 1
        level = lv
      end
    end
    return orig(c, level, flag, xuid, ...)
  end
end
local function install()
  pcall(BL.wrapAggregates)
  pcall(BL.wrapScoreboard)
  pcall(BL.wrapProgression)
  pcall(BL.wrapTitle)
  if #BL.q > 0 then L(table.remove(BL.q, 1)) end
end

install()
for _, name in ipairs({ "requirexhash", "require", "requireUnlessHotload" }) do
  pcall(function()
    local orig = rawget(_G, name)
    if type(orig) ~= "function" then return end
    rawset(_G, name, function(...)
      local res = BL.pack(orig(...))
      install()
      return unpack(res, 1, res.n)
    end)
  end)
end
L("botlevel: loaded")
end)()
