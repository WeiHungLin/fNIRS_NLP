%% This one plots the map of the peak for each channel
% By Frank Hu, 2025-09

load './Example_data/example_results_forcast/brain_score_results.mat'

% Assume your data is stored in a variable called "data"
% data has size [97, 32, 25]

figure
% Step 1: Average over the 1st dimension (dim = 97)
avg_data = mean(brain_score, 1);  % Resulting size: [1, 32, 25]

% Step 2: Get max value across dim 3 in the range [10, 20]
% Extract the subrange in dim 3
subrange = avg_data(:, :, 10:25);  % Size: [1, 32, 11]

% Step 3: Find the index of the max value within that range
[~, local_peak_idx] = max(subrange, [], 3);  % Result: [1, 32]

% Step 4: Convert local index to global time index (10-based offset)
global_peak_idx = squeeze(local_peak_idx)' + 9;  % Size: [32, 1]

p_fake=0.01*ones(32,1);
onlypositive=0;
coordfile='Orig_32.mat';
plot3Dbrain_Ver2021(global_peak_idx,onlypositive,p_fake,coordfile,'mx',30,'mn',0)
