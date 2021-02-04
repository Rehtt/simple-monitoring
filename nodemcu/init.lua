dofile('ssd1306.lua')
dofile('wifi.lua')

wifiConState={}

-- wifi连接后执行
wifi.eventmon.register(wifi.eventmon.STA_GOT_IP, function(T)
    wifiConState.WIFI="Connected"
    dispStr(wifiConState)
    dofile('mqtt.lua')
end)

wifi.eventmon.register(wifi.eventmon.STA_CONNECTED, function(T)
    wifiConState.WIFI="Connecting..."
    dispStr(wifiConState)
end)

wifi.eventmon.register(wifi.eventmon.STA_DISCONNECTED, function(T)
    wifiConState.WIFI="Disconnect"
    dispStr(wifiConState)
end)
