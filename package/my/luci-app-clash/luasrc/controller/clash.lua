#-- Copyright (C) 2018 dz <dingzhong110@gmail.com>

module("luci.controller.clash", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/clash") then
		return
	end

	local page

	entry({"admin", "services", "clash"},alias("admin", "services", "clash", "setting"),_("CLASH"), 10).dependent = true
	entry({"admin", "services", "clash", "setting"},arcombine(cbi("clash/setting"), form("clash/setting-config")),_("CLASH Setting"), 10).leaf = true

	entry({"admin", "services", "clash", "client"},form("clash/client"),_("CLASH Client"), 20).leaf = true
	entry({"admin", "services", "clash", "log"},form("clash/log"),_("Log"), 30).leaf = true
end
