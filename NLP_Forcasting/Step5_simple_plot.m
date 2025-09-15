wd=load('./result_nlp/v3.1_td_v_wd_tddr_1Hz_v25/brain_score_result_v3.1_full_WD_w25.mat');
td=load('./result_nlp/v3.1_td_v_wd_tddr_1Hz_v25/brain_score_result_v3.1_full_TD_w25_w4020.mat');

td.brain_score([24 78 96],:,:)=[];
wd.brain_score([15 42 43],:,:)=[];
% [td, loc_td] = uigetfile();
% [wd, loc_wd] = uigetfile();

% td=load(fullfile(loc_td,td)); wd=load(fullfile(loc_wd,wd));
%% left a
ifg_roi = 2;
stg_roi = 9;

%%
figure
%
td_score = squeeze(mean(td.brain_score, 1))';  
td_std = squeeze(std(td.brain_score, 0, 1)/sqrt(size(td.brain_score,1)))'; % Compute standard error

subplot(1,2,1)
roi1_mean = td_score(:,ifg_roi)-td_score(1,ifg_roi);
roi1_std = td_std(:,ifg_roi);
roi2_mean = td_score(:,stg_roi)-td_score(1,stg_roi);
roi2_std = td_std(:,stg_roi);

title('IFG-vs-STG')
hold on
fill([1:length(roi2_mean), fliplr(1:length(roi2_mean))], ...
     [(roi2_mean - roi2_std)', flipud(roi2_mean + roi2_std)'], ...
     'b', 'FaceAlpha', 0.2, 'EdgeColor', 'none') % Shaded area for STD
plot(roi2_mean, 'b', 'LineWidth', 1.5)

fill([1:length(roi1_mean), fliplr(1:length(roi1_mean))], ...
     [roi1_mean - roi1_std; flipud(roi1_mean + roi1_std)], ...
     'r', 'FaceAlpha', 0.2, 'EdgeColor', 'none') % Shaded area for STD
plot(roi1_mean, 'r', 'LineWidth', 1.5)

legend('STG STD','STG','IFG STD','IFG')
grid on
ylim([-0.03 0.03])

%
wd_score = squeeze(mean(wd.brain_score, 1))';  
wd_std = squeeze(std(wd.brain_score, 0, 1)/sqrt(size(wd.brain_score,1)))'; % Compute standard error

subplot(1,2,2)
roi1_mean = wd_score(:,ifg_roi)-wd_score(1,ifg_roi);
roi1_std = wd_std(:,ifg_roi);
roi2_mean = wd_score(:,stg_roi)-wd_score(1,stg_roi);
roi2_std = wd_std(:,stg_roi);

title('IFG-vs-STG')
hold on
fill([1:length(roi2_mean), fliplr(1:length(roi2_mean))], ...
     [roi2_mean - roi2_std; flipud(roi2_mean + roi2_std)], ...
     'b', 'FaceAlpha', 0.2, 'EdgeColor', 'none') % Shaded area for STD
plot(roi2_mean, 'b', 'LineWidth', 1.5)

fill([1:length(roi1_mean), fliplr(1:length(roi1_mean))], ...
     [roi1_mean - roi1_std; flipud(roi1_mean + roi1_std)], ...
     'r', 'FaceAlpha', 0.2, 'EdgeColor', 'none') % Shaded area for STD
plot(roi1_mean, 'r', 'LineWidth', 1.5)

legend('STG STD','STG','IFG STD','IFG')
grid on
ylim([-0.03 0.03])

% %% right
% figure
% %
% td_score = squeeze(mean(td.brain_score, 1))';  
% td_std = squeeze(.5*std(td.brain_score, 0, 1)/sqrt(size(td.brain_score,1)))'; % Compute standard error
% 
% subplot(1,2,1)
% roi1_mean = td_score(:,19)-td_score(1,19);
% roi1_std = td_std(:,2);
% roi2_mean = mean(td_score(:,[28 29])-td_score(1,[28 29]),2);
% roi2_std = mean(td_std(:,[28 29]),2);
% 
% title('IFG-vs-STG')
% hold on
% fill([1:length(roi2_mean), fliplr(1:length(roi2_mean))], ...
%      [(roi2_mean - roi2_std)', flipud(roi2_mean + roi2_std)'], ...
%      'b', 'FaceAlpha', 0.2, 'EdgeColor', 'none') % Shaded area for STD
% plot(roi2_mean, 'b', 'LineWidth', 1.5)
% 
% fill([1:length(roi1_mean), fliplr(1:length(roi1_mean))], ...
%      [roi1_mean - roi1_std; flipud(roi1_mean + roi1_std)], ...
%      'r', 'FaceAlpha', 0.2, 'EdgeColor', 'none') % Shaded area for STD
% plot(roi1_mean, 'r', 'LineWidth', 1.5)
% 
% legend('STG STD','STG','IFG STD','IFG')
% grid on
% ylim([-0.02 0.02])
% 
% %
% wd_score = squeeze(mean(wd.brain_score, 1))';  
% wd_std = squeeze(.5*std(wd.brain_score, 0, 1)/sqrt(size(wd.brain_score,1)))'; % Compute standard error
% 
% subplot(1,2,2)
% roi1_mean = wd_score(:,19)-wd_score(1,19);
% roi1_std = wd_std(:,2);
% roi2_mean = mean(wd_score(:,[28 29])-wd_score(1,[28 29]),2);
% roi2_std = mean(wd_std(:,[28 29]),2);
% 
% title('IFG-vs-STG')
% hold on
% fill([1:length(roi2_mean), fliplr(1:length(roi2_mean))], ...
%      [roi2_mean - roi2_std; flipud(roi2_mean + roi2_std)], ...
%      'b', 'FaceAlpha', 0.2, 'EdgeColor', 'none') % Shaded area for STD
% plot(roi2_mean, 'b', 'LineWidth', 1.5)
% 
% fill([1:length(roi1_mean), fliplr(1:length(roi1_mean))], ...
%      [roi1_mean - roi1_std; flipud(roi1_mean + roi1_std)], ...
%      'r', 'FaceAlpha', 0.2, 'EdgeColor', 'none') % Shaded area for STD
% plot(roi1_mean, 'r', 'LineWidth', 1.5)
% 
% legend('STG STD','STG','IFG STD','IFG')
% grid on
% ylim([-0.02 0.02])
% 
% %% Do a simple stats for the peak
% 
% load('./result_nlp/v3_td_v_wd_tddr_1Hz_v25/brain_score_result_v3.1_full_TD_w25.mat');
% brain_score_ref = brain_score - brain_score(:,:,1);
% % brain_score_ref = brain_score;
% td_ifg=squeeze(brain_score_ref(:,2,:));
% td_stg=squeeze(brain_score_ref(:,9,:));
% 
% [~,td_ifg_p]=ttest(td_ifg(:,19));
% [~,td_stg_p_1]=ttest(td_stg(:,12));
% % [~,td_stg_p_2]=ttest(td_stg(:,11));
% 
% load('./result_nlp/v3_td_v_wd_tddr_1Hz_v25/brain_score_result_v3.1_full_WD_w25.mat');
% brain_score_ref = brain_score - brain_score(:,:,1);
% wd_ifg=squeeze(brain_score_ref(:,2,:));
% % wd_stg=squeeze((brain_score_ref(:,10,:)+ brain_score_ref(:,11,:))/2);
% 
% % [~,wd_ifg_p_1]=ttest(wd_ifg(:,12));
% [~,wd_ifg_p_2]=ttest(wd_ifg(:,13));
% 
% % [~,wd_stg_p_1]=ttest(wd_stg(:,13));
% 
% %% ROI = CH7
% 
% figure
% %
% td_score = squeeze(mean(td.brain_score, 1))';  
% td_std = squeeze(.5*std(td.brain_score, 0, 1)/sqrt(size(td.brain_score,1)))'; % Compute standard error
% wd_score = squeeze(mean(wd.brain_score, 1))';  
% wd_std = squeeze(.5*std(wd.brain_score, 0, 1)/sqrt(size(wd.brain_score,1)))'; % Compute standard error
% 
% subplot(1,2,1)
% roi3_mean = td_score(:,7)-td_score(1,7);
% plot(roi3_mean, 'b', 'LineWidth', 1.5)
% grid on
% ylim([-0.01 0.01])
% title('TD')
% 
% subplot(1,2,2)
% roi3_mean = wd_score(:,7)-wd_score(1,7);
% plot(roi3_mean, 'b', 'LineWidth', 1.5)
% grid on
% ylim([-0.01 0.01])
% title('WD')
% 
% %% ROI = CH8
% 
% figure
% %
% td_score = squeeze(mean(td.brain_score, 1))';  
% td_std = squeeze(.5*std(td.brain_score, 0, 1)/sqrt(size(td.brain_score,1)))'; % Compute standard error
% wd_score = squeeze(mean(wd.brain_score, 1))';  
% wd_std = squeeze(.5*std(wd.brain_score, 0, 1)/sqrt(size(wd.brain_score,1)))'; % Compute standard error
% 
% subplot(1,2,1)
% roi3_mean = wd_score(:,8)-wd_score(1,8);
% plot(roi3_mean, 'b', 'LineWidth', 1.5)
% grid on
% ylim([-0.01 0.02])
% title('TD')
% 
% subplot(1,2,2)
% roi3_mean = td_score(:,8)-td_score(1,8);
% plot(roi3_mean, 'b', 'LineWidth', 1.5)
% grid on
% ylim([-0.01 0.02])
% title('WD')
