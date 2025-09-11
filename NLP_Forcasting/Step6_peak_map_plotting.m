%%
load './result_nlp/v3.1_td_v_wd_tddr_1Hz_v25/brain_score_result_v3.1_full_TD_w25_w4020.mat'
brain_score([24 78 96],:,:)=[];

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
plot3Dbrain_Ver2021(global_peak_idx,onlypositive,p_fake,coordfile,'mx',20,'mn',0)


%% WD

load './result_nlp/v3.1_td_v_wd_tddr_1Hz_v25/brain_score_result_v3.1_full_WD_w25.mat'
brain_score([15 42 43],:,:)=[];

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
plot3Dbrain_Ver2021(global_peak_idx,onlypositive,p_fake,coordfile,'mx',20,'mn',0)
