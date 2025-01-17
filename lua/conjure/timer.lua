local _2afile_2a = "fnl/conjure/timer.fnl"
local _0_0
do
  local name_0_ = "conjure.timer"
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
    return {autoload("conjure.aniseed.core"), autoload("conjure.aniseed.nvim")}
  end
  ok_3f_0_, val_0_ = pcall(_1_)
  if ok_3f_0_ then
    _0_0["aniseed/local-fns"] = {autoload = {a = "conjure.aniseed.core", nvim = "conjure.aniseed.nvim"}}
    return val_0_
  else
    return print(val_0_)
  end
end
local _local_0_ = _1_(...)
local a = _local_0_[1]
local nvim = _local_0_[2]
local _2amodule_2a = _0_0
local _2amodule_name_2a = "conjure.timer"
do local _ = ({nil, _0_0, nil, {{}, nil, nil, nil}})[2] end
local defer
do
  local v_0_
  do
    local v_0_0
    local function defer0(f, ms)
      local t = vim.loop.new_timer()
      t:start(ms, 0, vim.schedule_wrap(f))
      return t
    end
    v_0_0 = defer0
    _0_0["defer"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["defer"] = v_0_
  defer = v_0_
end
local destroy
do
  local v_0_
  do
    local v_0_0
    local function destroy0(t)
      if t then
        t:stop()
        t:close()
      end
      return nil
    end
    v_0_0 = destroy0
    _0_0["destroy"] = v_0_0
    v_0_ = v_0_0
  end
  local t_0_ = (_0_0)["aniseed/locals"]
  t_0_["destroy"] = v_0_
  destroy = v_0_
end
return nil