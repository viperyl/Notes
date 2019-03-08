import os
import pandas as pd
import re

def parse_Hour(line):
    pattern = re.compile('2019.*?\s(\d+):')
    items = re.findall(pattern, line)
    items = float(items[0])
    return items
def parse_Minute(line):
    pattern = re.compile('2019.*?:(\d+):')
    items = re.findall(pattern, line)
    items = float(items[0])
    return items
def parse_Second(line):
    pattern = re.compile('2019.*?:.*?:(.*?),')
    items = re.findall(pattern, line)
    items = float(items[0])
    return items    
def parse_A(line):
    pattern = re.compile('2019.*?:.*?:.*?,(.*?)(\d+)(.*?)(\d+)')
    items = re.findall(pattern, line)
    if items[0][1] == '-':
        items = float(items[0][0] + items[0][1] + items[0][2] + items[0][3])
    else :
        items = float('+' + items[0][1] + items[0][2] + items[0][3])
    return items


name_1 = 'Acceler_sensor_log_ipx_'
name_2 = 'Acceler_sensor_log_ipxs_'

for i in range(1,13):
    os.chdir(r'D:\New folder\Data')
    ipx = name_1  + str(i)
    ipxs = name_1 + str(i)
    os.chdir(ipx)
    save_name = 'exp_' + str(i) + '.xlsx'
    data = pd.DataFrame(columns = ['Hour','minute','second','a'])
    writer = pd.ExcelWriter('D:\exp'+save_name)
    for i in ['x','y','z']:
        file = i + '.txt'
        with open(file) as f:
            for line in f:
                Hour = parse_Hour(line)
                Minute = parse_Minute(line)
                Second = parse_Second(line)
                A = parse_A(line)
                data = data.append(pd.DataFrame({'Hour':[Hour],'minute':[Minute],'second':[Second],'a':[A]}),\
                                   ignore_index = True)
                data.to_excel(writer,'ipx_'+i)
    os.chdir(r'D:\New folder\Data')
    os.chdir(ipxs)
    for i in ['x','y','z']:
        file = i + '.txt'
        with open(file) as f:
            for line in f:
                Hour = parse_Hour(line)
                Minute = parse_Minute(line)
                Second = parse_Second(line)
                A = parse_A(line)
                data = data.append(pd.DataFrame({'Hour':[Hour],'minute':[Minute],'second':[Second],'a':[A]}),\
                                   ignore_index = True)
                data.to_excel(writer,'ipxs_'+i)
    writer.save()
    writer.close



