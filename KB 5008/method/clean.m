clc,clear 
close all
data_x = xlsread('expexp_1.xlsx','ipx_x');
len = size(data_x,1);
trend = zeros(len-1,1);
num = 1:len;
for i = 1:len-1
    if data_x(i,5) < data_x(i+1,5)
        trend(i) = 1;
    else
        trend(i) = 0;
    end
end

vp = 0;
trend_time = [];
tick = 0;
mat = ones(len,1);
for i = 3:len-1
    if vp == trend(i)
        tick = tick + 1;
    end
    
    if vp ~= trend(i)
        tick = tick + 1;
        trend_time = [trend_time tick*0.1];
        tick = 0;
        vp =trend(i);
    end
    if 
end








