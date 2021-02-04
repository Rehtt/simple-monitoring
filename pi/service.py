import paho.mqtt.client as mqtt

import time
import json
import psutil


def get() -> int:
    ll = psutil.net_io_counters(pernic=True)['eth0']
    up = ll.bytes_sent
    down = ll.bytes_recv
    return up, down


def dw(num) -> str:
    d = "KB/s"
    if num >= 0x3e8:
        if num >= 0xf4240:
            num /= 0xf4240
            d = "MB/s"
        else:
            num /= 0x3e8
    else:
        num = 0
    return "%.1f%s" % (num, d)

#使用mqtt协议通讯
client = mqtt.Client()
client.will_set('/PC', '{"Offline":"PI"}', 0)
client.connect('127.0.0.1', 1883, 120)
upl = 0
downl = 0
while(1):
    up, down = get()
    if upl != 0 and downl != 0:
        u = dw((up-upl)/5)
        d = dw((down-downl)/5)
        upl = up
        downl = down
    else:
        upl = up
        downl = down
        u = d = dw(0)

    cpu = "%.0f%%" % psutil.cpu_percent(1)
    memory = "%.1f%%" % psutil.virtual_memory().percent
    temp = "%.0fC" % psutil.sensors_temperatures()['cpu_thermal'][0].current
    t=time.strftime(" %H:%M",time.localtime())
    #cpu风扇状态
    with open("/etc/fen_s.txt",'r') as fen:
        if fen.read() == 'low\n':
            fen='off'
        else:
            fen='on'

    res = json.dumps({"U": u, "D": d, "CPU": cpu, "M": memory, "time": t, "temp": temp, "fen":fen})
    client.publish('/PC', res, 0)
    time.sleep(5)
