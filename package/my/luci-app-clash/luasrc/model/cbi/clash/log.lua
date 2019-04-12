local fs = require "nixio.fs"
local conffile = "/tmp/clash.log"

f = SimpleForm("logview")

t = f:field(TextValue, "conf")
t.rmempty = true
t.rows = 20
function t.cfgvalue()
  luci.sys.exec("[ -f /tmp/clash.log ] && sed '1!G;h;$!d' /tmp/clash.log > /tmp/clash.log")
	return fs.readfile(conffile) or ""
end
t.readonly="readonly"

return f