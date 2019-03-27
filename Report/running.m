clc,clear
close all
file_name = 'exp_';
new_file_name = 'expp_';
phone1 = 'ipx_';
phone2 = 'ipxs_';
vvp =zeros(2,3,12);
for i = 1:12
    new_newfilename = strcat(new_file_name,int2str(i));
    dimen = ['x' 'y' 'z'];
    sp_file = strcat(file_name,int2str(i));
    for ii =1:3
        phone11 = strcat(phone1,dimen(ii));
        phone22 = strcat(phone2,dimen(ii));
        data_1 = xlsread(sp_file,phone11);
        data_2 = xlsread(sp_file,phone22);
        [data,vp] = clearn_data(data_1);
        vvp(1,ii,i) = vp;
        %writematrix(data,strcat(new_newfilename,'.xlsx'),'Sheet',phone11)
        %writematrix(new_newfilename,data,phone11);
        xlswrite(strcat(new_newfilename,'.xlsx'),data,phone11);
        [data,vp] = clearn_data(data_2);
        vvp(2,ii,i) = vp;
        %writematrix(new_newfilename,data,phone22);
        %writematrix(data,strcat(new_newfilename,'.xlsx'),'Sheet',phone22)
        xlswrite(strcat(new_newfilename,'.xlsx'),data,phone22);
    end
end
