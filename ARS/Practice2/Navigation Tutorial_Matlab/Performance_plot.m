%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PLOTTING - Performance
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t=1:timesteps;

for obs_land_num= [2:3,7:8,15,20:21,28:29]
    est_pos_error = pos_hat_land1_history(2*(obs_land_num-1)+1:2*(obs_land_num),:)-real_landmarks(:,obs_land_num);
    char_func = ['figure(',num2str(obs_land_num),')'];
    eval(char_func);
    x=P_data_stack(2*(obs_land_num-1)+1,:);
    y=P_data_stack(2*(obs_land_num),:);
    subplot(311)
    hold on;
    plot(t,x,t,y)
    legend('X','Y')
    grid on;
    title(['Error Coveriance - Landmark',num2str(obs_land_num)])
    subplot(312)
    plot(t,est_pos_error(1,:))
    grid on;title(['Position error:- Landmark', num2str(obs_land_num)])
    hold on;
    plot(t,est_pos_error(2,:))
    ylabel('[m]')
    grid on;
    ylim([-5 5])
    xlim([0 timesteps])
    subplot(313)
    plot(t,stack_detect_flag(:,obs_land_num))
    title('Detection flag')
    grid on
    plotbrowser
end
