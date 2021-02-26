function open()
    mac = '448a5b9b4c6e'    -- 要进行唤醒主机的MAC地址
    bip = '255.255.255.255' -- 路由器广播地址
    
    head = 'FFFFFFFFFFFF'
    head = to(head)
    mac = to(mac)
    for i = 1, 16 do
        head = head .. mac
    end
    u = net.createUDPSocket()
    u:send(1234, bip, head)    -- 9号端口
    u:close()
end
-- 将两个一组字符串表示的十六进制转为十六进制的字符串
-- 'ff'(66 66) -> 0xff -> '.'(255)
function to(str)
    ret = ''
    for i = 1, string.len(str), 2 do
        byte = ('0x' .. string.sub(str, 0 + i, 1 + i))
        a = tonumber(byte)
        ret = ret .. string.char(a)
    end
    return ret
end
