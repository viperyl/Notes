function [data,vp] = clearn_data(data_x)
len = size(data_x,1);
vp = 0;
for ii =1:10
    for i=1:1:len-10
        
        % Type 1
        if data_x(i,5) < data_x(i+1,5) && data_x(i+1,5) > data_x(i+2,5) && data_x(i+2,5) < data_x(i+3,5)
            data_x(i+1,5) = (data_x(i,5)+data_x(i+2,5))/2;
            vp = vp +1;
        end
        
        % Type 2
        if data_x(i,5)>data_x(i+1,5) && data_x(i+1,5)<data_x(i+2,5) && data_x(i+2,5)>data_x(i+3,5)
            data_x(i+2,5) = (data_x(i+1,5)+data_x(i+3,5))/2;
            vp = vp +1;
        end
        
        % Type 3
        if data_x(i,5) > data_x(i+1,5) && data_x(i+1,5) == data_x(i+2,5) && data_x(i+2,5) > data_x(i+3,5)
            data_x(i+2,5) = (data_x(i+1,5)+data_x(i+3,5))/2;
            vp = vp +1;
        end
        
        % Type 4
        if data_x(i,5) < data_x(i+1,5) && data_x(i+1,5) == data_x(i+2,5) && data_x(i+2,5) < data_x(i+3,5)
            data_x(i+1,5) = (data_x(i,5)+data_x(i+2,5))/2;
            vp = vp +1;
        end
        
        % Type 5
        if data_x(i+1,5) == data_x(i+2,5)
            data_x(i+1,5) = (data_x(i,5)+data_x(i+2,5))/2;
            vp = vp +1;
        end
        
        % Type 6
        if data_x(i,5)< data_x(i+1,5) && data_x(i+1,5) == data_x(i+2,5)
            data_x(i+1,5) = (data_x(i,5)+data_x(i+2,5))/2;
        end
        
        % Type 7
        if data_x(i,5)> data_x(i+1,5) && data_x(i+1,5) == data_x(i+2,5)
            data_x(i+1,5) = (data_x(i,5)+data_x(i+2,5))/2;
        end
        
        % Type 8
        if data_x(i,5)== data_x(i+1,5) && data_x(i+1,5) < data_x(i+2,5)
            data_x(i+1,5) = (data_x(i,5)+data_x(i+2,5))/2;
        end
        
        % Type 9
        if data_x(i,5)== data_x(i+1,5) && data_x(i+1,5) > data_x(i+2,5)
            data_x(i+1,5) = (data_x(i,5)+data_x(i+2,5))/2;
        end
        
        % Type 10
        if data_x(i,5)< data_x(i+1,5) && data_x(i+1,5) > data_x(i+2,5) && data_x(i+2,5) > data_x(i+3,5)&& data_x(i+3,5) < data_x(i+4,5)
            if data_x(i,5)< data_x(i+4,5)
                zzz = linspace(data_x(i,5),data_x(i+4,5),3);
                data_x(i+1:i+3,5) = zzz;
            end
        end
        
        % Type 11
        if data_x(i,5)> data_x(i+1,5) && data_x(i+1,5) < data_x(i+2,5) && data_x(i+2,5) < data_x(i+3,5)&& data_x(i+3,5) > data_x(i+4,5)
            if data_x(i,5)> data_x(i+4,5)
                zzz = linspace(data_x(i,5),data_x(i+4,5),3);
                data_x(i+1:i+3,5) = zzz;
            end
        end
    end
end
data = data_x;
end
