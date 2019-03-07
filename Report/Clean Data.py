import numpy as np
import matplotlib.pyplot as plt
import os
import pandas as pd
import re

def parse_one_line(line):
    pattern = re.compile('2019.*?\s+(\d+):(\d+):(\d+),(\d+)')
os.chdir(r'D:\ev\Data')
folder_1 = 'Acceler_sensor_log_ipx_'
folder_2 = 'Acceler_sensor_log_ipxs_'
df = pd.DataFrame({columns = ['hour','minute','second','acceleration']})
for i in rang(1,13):
    folder_ipx = folder_1 + str(i)
    with open('x.txt','r') as f:
        for line in f:
            
    
    folder_ipx = folder_2 + str(i)
    with open('x.txt','r') as f:
        for line in f:       



