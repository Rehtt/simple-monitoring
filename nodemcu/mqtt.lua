mq=mqtt.Client("PC",300)
mq:connect("192.168.199.242",1883,false,function(client)
    wifiConState.MQTT="Connected"
    dispStr(wifiConState)
    client:subscribe("/PC",0)
    end
)
mq:on("connfail", function(client, reason) 
    wifiConState.MQTT="Connection failed"
    dispStr(wifiConState) end)
mq:on("offline", function(client)
    wifiConState.MQTT="Offline"
    dispStr(wifiConState)
    node.restart()
    end)

mq:on("message",function(client,topic,data)
        pcall(function(i)
            local da=sjson.decode(i)
            if da['Offline'] ~= nil then
                local a
                dispStr(da)
            else
                disps(da)
            end
            end,data)
        
end)
