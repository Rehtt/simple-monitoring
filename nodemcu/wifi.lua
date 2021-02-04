wifi.setmode(wifi.STATION)
local wifi_cfg={}
wifi_cfg.ssid="R_Furry"
wifi_cfg.pwd="rehtt643123"
wifi_cfg.save=false
wifi.sta.config(wifi_cfg)