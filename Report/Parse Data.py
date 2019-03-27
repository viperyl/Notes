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
    if items[0][0] == '-':
        items = float(items[0][0] + items[0][1] + items[0][2] + items[0][3])
    else :
        items = float('+' + items[0][1] + items[0][2] + items[0][3])
    return items


name_1 = 'Acceler_sensor_log_ipx_'
name_2 = 'Acceler_sensor_log_ipxs_'

for ii in range(1,13):
    os.chdir(r'I:\Xu\5008\Parsed Data\Data')
    ipx = name_1  + str(ii)
    ipxs = name_2 + str(ii)
    os.chdir(ipx)
    save_name = 'exp_' + str(ii) + '.xlsx'
    writer = pd.ExcelWriter(save_name, engine='xlsxwriter')
    for i in ['x','y','z']:
        print('1')
        file = i + '.txt'
        with open(file) as f:
            data = pd.DataFrame(columns = ['Hour','minute','second','a'])
            for line in f:
                Hour = parse_Hour(line)
                Minute = parse_Minute(line)
                Second = parse_Second(line)
                A = parse_A(line)
                data = data.append(pd.DataFrame({'Hour':[Hour],'minute':[Minute],'second':[Second],'a':[A]}),\
                                   ignore_index = True)
        data.to_excel(writer,sheet_name = 'ipx_' + i,encoding='utf8')
        print('2')
    os.chdir(r'I:\Xu\5008\Parsed Data\Data')
    os.chdir(ipxs)
    for i in ['x','y','z']:
        file = i + '.txt'
        with open(file) as f:
            data = pd.DataFrame(columns = ['Hour','minute','second','a'])
            for line in f:
                Hour = parse_Hour(line)
                Minute = parse_Minute(line)
                Second = parse_Second(line)
                A = parse_A(line)
                data = data.append(pd.DataFrame({'Hour':[Hour],'minute':[Minute],'second':[Second],'a':[A]}),\
                                   ignore_index = True)
        data.to_excel(writer,sheet_name = 'ipxs_' + i,encoding='utf8')
        print('3')
    os.chdir(r'I:\Xu\5008\Parsed Data')
    writer.save()
    writer.close()



