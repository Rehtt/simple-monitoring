wifi.setmode(wifi.STATION)
local wifi_cfg={}
wifi_cfg.ssid="wifi ssid"
wifi_cfg.pwd="wifi password"
wifi_cfg.save=false
wifi.sta.config(wifi_cfg)
