-- Operator sides for bot skins (Bot Skins, Loadouts & Ranks mod).
-- Reads each operator's side (JSOC/Guild) for scripts\mp_bot_bundles.gsc. Log lines: "botsides" in poi_reg.log.
(function()
if rawget(_G, "__botFactionsLoaded") then return end
rawset(_G, "__botFactionsLoaded", true)

local DV_SET, DV_GET, LOG_DVAR = "1e3cb005036e0c0f", "254084d7ca2317bb", "67730584afc6ee3d"
local OUT = "690985de4560c249"
local FIND, FACTION = "72145c734039267f", "7a91a03aa067d844"
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

local OPS = {
  { "sat_usa_pl_jack_base", "6f7f4a53c363fde9" },
  { "sat_usa_pl_jill_base", "24052897969a2b3b" },
  { "sat_usa_pl_orange", "1e1c542ab76a5862" },
  { "sat_usa_pl_black", "0bf38caa571eaabb" },
  { "sat_zaf_pl_peach", "590f97685a853eab" },
  { "sat_ind_pl_azure", "48ca858d0aa29829" },
  { "sat_ger_pl_purple", "50384cf6a53f03df" },
  { "sat_rus_pl_magenta", "6eb958c258f756f0" },
  { "sat_usa_pl_amber", "181d2fe7b630c9f7" },
  { "sat_jpn_pl_scarlet", "26c1654b06174963" },
  { "sat_usa_pl_maroon", "0be01ccb1e2036f0" },
  { "sat_usa_pl_red", "1d9c078283251ebf" },
  { "sat_mex_pl_green", "2606f7061e5eedc0" },
  { "sat_nzl_pl_rose", "008390ccf5224378" },
  { "sat_usa_pl_white", "2898002338a58f15" },
  { "sat_usa_pl_gray", "75e87071dd763607" },
  { "sat_chn_pl_gold", "068435940b6838e2" },
  { "sat_usa_pl_silver", "13f7388bf571c7d9" },
  { "sat_usa_pl_cyan", "76ea545311e414ff" },
  { "sat_ger_pl_blue", "2e45ea2fd712e1cd" },
  { "sat_mex_pl_indigo", "01c51435a820d287" },
  { "sat_ind_pl_violet", "72fa12b03340ac29" },
  { "sat_usa_pl_voss", "0ec1c4e761910335" },
  { "sat_usa_pl_cdl_male_away", "638ada1717dd0ed2" },
  { "sat_usa_pl_cdl_male_home", "72aa01ca2f014a3f" },
  { "sat_usa_pl_cdl_female_away", "74fd8440086f47ad" },
  { "sat_usa_pl_cdl_female_home", "7c8a5c8d8f8e4390" },
  { "sat_phl_pl_maya", "033f6929efd7cd4f" },
  { "sat_rus_pl_weaver", "3963d47ed41cba35" },
  { "sat_gbr_pl_grey", "6b2603a879c5e3cd" },
  { "sat_usa_pl_carver", "04f7e059d808f6b7" },
  { "sat_usa_pl_tulip", "2ccaa755ae3060a4" },
  { "sat_usa_pl_peony", "1b84a253433901c1" },
  { "sat_usa_pl_iris", "6865a1ff86fc12d7" },
  { "sat_usa_pl_sunflower", "5ff063276c4e2085" },
  { "sat_usa_pl_breaker", "4fc3c156e1d2aa2c" },
  { "sat_usa_pl_director", "4cd9742ecac6c280" },
  { "sat_usa_pl_overlord", "39d46ca4efed4499" },
  { "sat_usa_pl_freelance", "2b31ee5c50702111" },
  { "sat_usa_pl_raven", "4eb7d49a3d8e0bc6" },
  { "sat_usa_pl_valkyrie", "333c00531acfdc35" },
  { "sat_usa_pl_mozzarella", "469f5ca5c7052ddd" },
  { "sat_usa_pl_swiss", "09a14937f28ba7df" },
  { "sat_usa_pl_brie", "345806481b9e29e6" },
  { "sat_usa_pl_anvil", "0a4e49dd25fb704e" },
  { "sat_kor_pl_hunterkiller", "082af75dbf598e72" },
  { "sat_usa_pl_vector", "79e35103448c2e17" },
  { "sat_usa_pl_sourdough", "3d499881af59a6c4" },
  { "sat_usa_pl_spectre", "62efa28a3641b2d0" },
  { "sat_usa_pl_cipher", "238eba92935751c7" },
  { "sat_usa_pl_peanut", "7a1c8c698f4505c5" },
  { "sat_usa_pl_prism", "4b39cbb37b1e67ed" },
  { "sat_sgp_pl_blackjack", "0aeb6d7d8479e713" },
  { "sat_usa_pl_warden", "0ee882f0178b2051" },
  { "ghost_western", "2144b231ee61b7bc" },
  { "nicki_eastern", "57ce19d8501b12bb" },
  { "dune_eastern", "7c6754028bc31103" },
  { "jup_mp_beta", "64160da0791cbf36" },
  { "snoop_western", "1fad9559d907446e" },
  { "homelander_eastern", "4ddb12f471a98764" },
  { "jup_mp_spring", "029daf10efcddd21" },
  { "jup_mp_summer", "57c1cb281374c5f9" },
  { "gus_western", "5b76a143c2511e46" },
  { "jup_mp_hotel", "2bb41893adbd2966" },
  { "jup_mp_void", "7eba0705b56228d6" },
  { "jup_mp_bravo", "046e22ee73e7dc50" },
  { "jup_mp_mike", "20bd95b7fd5b0516" },
}
local F = { done = false, tries = 0, sets = 0, setFail = false }
local function short(op)
  local s = op:gsub("^sat_", "")
  s = s:gsub("_pl_", "_")
  return s
end
local function lookup()
  if F.done then return end
  local O = rawget(_G, "Operator")
  if O == nil then return end
  local okF, find = pcall(function() return O[H(FIND)] end)
  if not okF or type(find) ~= "function" then return end
  F.tries = F.tries + 1
  local letters, raw, got, counts, order, codes, codeIx = {}, {}, 0, {}, {}, {}, {}
  for i, op in ipairs(OPS) do
    local ok, b = pcall(find, H(op[2], 3))
    local v
    if ok and type(b) == "table" then
      v = b[H(FACTION)]
      if v == nil then v = rawget(b, "factionRef") end
    end
    if v ~= nil then got = got + 1 end
    local vs = v == nil and "-" or tostring(v):sub(1, 24)
    letters[i] = "-"
    if v ~= nil then
      local code = tostring(v):gsub("[,|]", "_")
      if not codeIx[code] then codes[#codes + 1] = code; codeIx[code] = #codes - 1 end
      letters[i] = tostring(codeIx[code])
    end
    raw[i] = short(op[1]) .. "=" .. vs
    if not counts[vs] then counts[vs] = 0; order[#order + 1] = vs end
    counts[vs] = counts[vs] + 1
  end
  if got == 0 or (got < #OPS and F.tries < 300) then return end
  F.done = true
  F.value = table.concat(codes, ",") .. "|" .. table.concat(letters, ",")
  local summary = {}
  for _, vs in ipairs(order) do summary[#summary + 1] = vs .. " x" .. counts[vs] end
  if getDvar(OUT) == F.value then
    L("botsides: same as before (" .. table.concat(summary, ", ") .. ")")
    return
  end
  L("botsides: " .. got .. "/" .. #OPS .. " operators have a factionRef: " .. table.concat(summary, ", "))
  local line = ""
  for _, r in ipairs(raw) do
    if #line + #r + 1 > 165 then L("botsides " .. line); line = "" end
    line = line .. (line == "" and "" or " ") .. r
  end
  if line ~= "" then L("botsides " .. line) end
end
local function send()
  if not F.value or getDvar(OUT) == F.value then return end
  F.sets = F.sets + 1
  pcall(function() Dvar[H(DV_SET)](H(OUT, 1), F.value) end)
  if F.sets == 50 and getDvar(OUT) ~= F.value and not F.setFail then
    F.setFail = true
    L("botsides: couldn't set kronos_botbb_opteam (" .. getDvar(OUT):sub(1, 40) .. ")")
  end
end
local function tick()
  pcall(lookup)
  pcall(send)
end

local unpack = unpack or table.unpack
local function pack(...) return { n = select("#", ...), ... } end
tick()
for _, name in ipairs({ "requirexhash", "require", "requireUnlessHotload" }) do
  pcall(function()
    local orig = rawget(_G, name)
    if type(orig) ~= "function" then return end
    rawset(_G, name, function(...)
      local res = pack(orig(...))
      tick()
      return unpack(res, 1, res.n)
    end)
  end)
end
end)()
