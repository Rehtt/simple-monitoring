function init_oled()
        -- 设置IIC通信的引脚
    local sda = 6 -- GPIO14
    local scl = 5 -- GPIO12
    local sla = 0x3c
    
    i2c.setup(0, sda, scl, i2c.FAST)
    disp = u8g2.ssd1306_i2c_128x64_noname(0, sla)
        
    disp:setFontRefHeightExtendedText()
    disp:setDrawColor(1)
    disp:setFontPosTop()
    disp:setFontDirection(0)
    disp:setFlipMode(1)
    
end

--local x=3
--local i=3
--local f=true
--tmr.create():alarm(60000,tmr.ALARM_AUTO,function() 
--    if f then
--        if x>55 then
--            f=false
--            i=-3
--            end
--     else
--        if x<0 then
--            f=true
--            i=3
--            end
--     end
--     x=x+i
--end)
function dispStr(data)
    local y=20
    local x=20
    disp:setFont(u8g2.font_6x10_tf)
    disp:clearBuffer()
    disp:drawFrame(0, 0, 128, 64)
    for k,v in pairs(data) do
        disp:drawStr(x,y,k..":"..v)
        y=y+10
    end
    disp:sendBuffer()
end

function disps(data)
    disp:clearBuffer()
    disp:drawFrame(0, 0, 128, 64)
    disp:setFont(u8g2.font_courR18_tn)
    disp:drawStr(13,6,data['time'])
    
    disp:setFont(u8g2.font_6x10_tf)
    disp:drawStr(15,30,'CPU:'..data['CPU'])
    disp:drawStr(72,30,'M:'..data['M'])
    disp:drawStr(45,40,'U:'..data['U'])
    disp:drawStr(45,50,'D:'..data['D'])
    disp:drawStr(15,40,data['temp'])
    disp:drawStr(15,50,data['fen'])
    disp:sendBuffer()
end
init_oled()
