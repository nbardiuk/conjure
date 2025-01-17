local _2afile_2a = "fnl/conjure/net.fnl"
local _0_0
do
  local name_0_ = "conjure.net"
  local module_0_
  do
    local x_0_ = package.loaded[name_0_]
    if ("table" == type(x_0_)) then
      module_0_ = x_0_
    else
      module_0_ = {}
    end
  end
  module_0_["aniseed/module"] = name_0_
  module_0_["aniseed/locals"] = ((module_0_)["aniseed/locals"] or {})
  module_0_["aniseed/local-fns"] = ((module_0_)["aniseed/local-fns"] or {})
  package.loaded[name_0_] = module_0_
  _0_0 = module_0_
end
local autoload = (require("conjure.aniseed.autoload")).autoload
local function _1_(...)
  local ok_3f_0_, val_0_ = nil, nil
  local function _1_()
    return {autoload("conjure.aniseed.core"), autoload("conjure.bridge"), autoload("conjure.aniseed.nvim")}
  end
  ok_3f_0_, val_0_ = pcall(_1_)
  if ok_3f_0_ then
    _0_0["aniseed/local-fns"] = {["require-macros"] = {["conjure.macros"] = true}, autoload = {a = "conjure.aniseed.core", bridge = "conjure.bridge", nvim = "conjure.aniseed.nvim"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _1_(...)
local a = _local_0_[1]
local bridge = _local_0_[2]
local nvim = _local_0_[3]
local _2amodule_2a = _0_0
local _2amodule_name_2a = "conjure.net"
do local _ = ({nil, _0_0, nil, {{nil}, nil, nil, nil}})[2] end
local resolve
do
  local v_0_
  do
    local v_0_0
    local function resolve0(host)
      if (host == "::") then
        return host
      else
        local function _2_(_241)
          return ("inet" == a.get(_241, "family"))
        end
        return a.get(a.first(a.filter(_2_, vim.loop.getaddrinfo(host))), "addr")
      end
    end
    v_0_0 = resolve0
    _0_0["resolve"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["resolve"] = v_0_
  resolve = v_0_
end
local state
do
  local v_0_ = (((_0_0)["aniseed/locals"]).state or {["sock-drawer"] = {}})
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["state"] = v_0_
  state = v_0_
end
local destroy_sock
do
  local v_0_
  local function destroy_sock0(sock)
    if not sock:is_closing() then
      sock:read_stop()
      sock:shutdown()
      sock:close()
    end
    local function _3_(_241)
      return (sock ~= _241)
    end
    state["sock-drawer"] = a.filter(_3_, state["sock-drawer"])
    return nil
  end
  v_0_ = destroy_sock0
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["destroy-sock"] = v_0_
  destroy_sock = v_0_
end
local connect
do
  local v_0_
  do
    local v_0_0
    local function connect0(_2_0)
      local _arg_0_ = _2_0
      local cb = _arg_0_["cb"]
      local host = _arg_0_["host"]
      local port = _arg_0_["port"]
      local sock = vim.loop.new_tcp()
      local resolved_host = resolve(host)
      sock:connect(resolved_host, port, cb)
      table.insert(state["sock-drawer"], sock)
      local function _3_()
        return destroy_sock(sock)
      end
      return {["resolved-host"] = resolved_host, destroy = _3_, host = host, port = port, sock = sock}
    end
    v_0_0 = connect0
    _0_0["connect"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["connect"] = v_0_
  connect = v_0_
end
local destroy_all_socks
do
  local v_0_
  do
    local v_0_0
    local function destroy_all_socks0()
      return a["run!"](destroy_sock, state["sock-drawer"])
    end
    v_0_0 = destroy_all_socks0
    _0_0["destroy-all-socks"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["destroy-all-socks"] = v_0_
  destroy_all_socks = v_0_
end
nvim.ex.augroup("conjure-net-sock-cleanup")
nvim.ex.autocmd_()
nvim.ex.autocmd("VimLeavePre", "*", ("lua require('" .. _2amodule_name_2a .. "')['" .. "destroy-all-socks" .. "']()"))
return nvim.ex.augroup("END")