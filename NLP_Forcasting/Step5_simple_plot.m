% This just plot the result with two channels in matlab
% By Frank Hu, 2025-09

clear
result_example=load('./Example_data/example_results_forcast/brain_score_results.mat');

%% set two ROI for the plotting
ifg_roi = 3;
stg_roi = 17;

%%
figure
%
score = squeeze(mean(result_example.brain_score, 1))';  
std = squeeze(std(result_example.brain_score, 0, 1)/sqrt(size(result_example.brain_score,1)))'; % Compute standard error

roi1_mean = score(:,ifg_roi)-score(1,ifg_roi);
roi1_std = std(:,ifg_roi);
roi2_mean = score(:,stg_roi)-score(1,stg_roi);
roi2_std = std(:,stg_roi);

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
ylim([-0.05 0.05])

