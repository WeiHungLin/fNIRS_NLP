%% Create the stim base with only the current word
% This code will be after the code of Step1a to get the activations

% load the gpt2 generated embeddings
load('./design_matrix/activation_gpt2/norm_activation_baseline_8.mat')

% load the time for each word
design = readtable('./csv_xls_files/HH_time_matrix_round-v2.csv'); 
% stim_time = design.Start_time_adjusted_round;

% Find the maximum time (assuming time starts at 0)
% max_time = max(stim_time);
max_time = 827;
% +1 because the time starts on 0
t = 1:max_time+1;

%% Create the lagged stim

% Assuming `activation` is a matrix of size Nx768 (e.g., 1957x768)
% Shifting words by lag 1, shifted 25 words
for i = 1:25
    % Create the shifted matrix and pad with zeros
    % shifted_matrix = [activations(i:end, :); zeros(i-1, 768)];
    shifted_matrix = activations(i:end, :);
    % Assign the result to a dynamic field in the struct
    activation_set{i} = shifted_matrix;
    
    % This method is not proper
    % shifted_stim_time = [stim_time(i:end);zeros(i-1,1)]; 
    % stim_time_set{i} = shifted_stim_time;
    eval(strcat('stim_time_set{i}=design.Time_shift_',num2str(i-1),'(i:end);'));
    % fit the time into 1 sec bins
    stim_time_set{i}=floor(stim_time_set{i});
end

%% Getting the summed design matrix according to the gpt2 activation

for j = 1:25
% Initialize aggregated matrix (max_time+1 x 768) 
% +1 because we include time 0
    aggregated_matrix = zeros(max_time +1, size(activation_set{j}, 2));

    % Aggregate rows for each existing time step
    for i = 0:max_time
        % Find rows corresponding to current time step
        rows_to_sum = stim_time_set{j} == i;

        % If any rows match this time step, sum them
        if any(rows_to_sum)
            aggregated_matrix(i+1, :) = sum(activation_set{j}(rows_to_sum, :), 1);
        end
        % If no rows match this time step, the matrix already has zeros
    end
    aggregated_matrix_set{j}=aggregated_matrix;
end

%% Create design matrix for both
for i = 1:25
    design_mat{i} = convlution_canonical(aggregated_matrix_set{i}, t);
end

%% Concatenate
% d<=7
design_mat_1 = design_mat{1};

design_mat_2 = [design_mat{2}];
design_mat_3 = [design_mat{2} design_mat{3}];
design_mat_4 = [design_mat{2} design_mat{3} design_mat{4}];
design_mat_5 = [design_mat{2} design_mat{3} design_mat{4} design_mat{5}];
design_mat_6 = [design_mat{2} design_mat{3} design_mat{4} design_mat{5} design_mat{6}];
design_mat_7 = [design_mat{2} design_mat{3} design_mat{4} design_mat{5} design_mat{6} design_mat{7}];
design_mat_8 = [design_mat{2} design_mat{3} design_mat{4} design_mat{5} design_mat{6} design_mat{7} design_mat{8}];


% d>7
inc = 2;
design_mat_9 = [design_mat{1+inc} design_mat{2+inc} design_mat{3+inc} design_mat{4+inc} design_mat{5+inc} design_mat{6+inc} design_mat{7+inc}];
inc = 3;
design_mat_10 = [design_mat{1+inc} design_mat{2+inc} design_mat{3+inc} design_mat{4+inc} design_mat{5+inc} design_mat{6+inc} design_mat{7+inc}];
inc = 4;
design_mat_11 = [design_mat{1+inc} design_mat{2+inc} design_mat{3+inc} design_mat{4+inc} design_mat{5+inc} design_mat{6+inc} design_mat{7+inc}];
inc = 5;
design_mat_12 = [design_mat{1+inc} design_mat{2+inc} design_mat{3+inc} design_mat{4+inc} design_mat{5+inc} design_mat{6+inc} design_mat{7+inc}];
inc = 6;
design_mat_13 = [design_mat{1+inc} design_mat{2+inc} design_mat{3+inc} design_mat{4+inc} design_mat{5+inc} design_mat{6+inc} design_mat{7+inc}];
inc = 7;
design_mat_14 = [design_mat{1+inc} design_mat{2+inc} design_mat{3+inc} design_mat{4+inc} design_mat{5+inc} design_mat{6+inc} design_mat{7+inc}];
inc = 8;
design_mat_15 = [design_mat{1+inc} design_mat{2+inc} design_mat{3+inc} design_mat{4+inc} design_mat{5+inc} design_mat{6+inc} design_mat{7+inc}];
inc = 9;
design_mat_16 = [design_mat{1+inc} design_mat{2+inc} design_mat{3+inc} design_mat{4+inc} design_mat{5+inc} design_mat{6+inc} design_mat{7+inc}];
inc = 10;
design_mat_17 = [design_mat{1+inc} design_mat{2+inc} design_mat{3+inc} design_mat{4+inc} design_mat{5+inc} design_mat{6+inc} design_mat{7+inc}];
inc = 11;
design_mat_18 = [design_mat{1+inc} design_mat{2+inc} design_mat{3+inc} design_mat{4+inc} design_mat{5+inc} design_mat{6+inc} design_mat{7+inc}];
inc = 12;
design_mat_19 = [design_mat{1+inc} design_mat{2+inc} design_mat{3+inc} design_mat{4+inc} design_mat{5+inc} design_mat{6+inc} design_mat{7+inc}];
inc = 13;
design_mat_20 = [design_mat{1+inc} design_mat{2+inc} design_mat{3+inc} design_mat{4+inc} design_mat{5+inc} design_mat{6+inc} design_mat{7+inc}];
inc = 14;
design_mat_21 = [design_mat{1+inc} design_mat{2+inc} design_mat{3+inc} design_mat{4+inc} design_mat{5+inc} design_mat{6+inc} design_mat{7+inc}];
inc = 15;
design_mat_22 = [design_mat{1+inc} design_mat{2+inc} design_mat{3+inc} design_mat{4+inc} design_mat{5+inc} design_mat{6+inc} design_mat{7+inc}];
inc = 16;
design_mat_23 = [design_mat{1+inc} design_mat{2+inc} design_mat{3+inc} design_mat{4+inc} design_mat{5+inc} design_mat{6+inc} design_mat{7+inc}];
inc = 17;
design_mat_24 = [design_mat{1+inc} design_mat{2+inc} design_mat{3+inc} design_mat{4+inc} design_mat{5+inc} design_mat{6+inc} design_mat{7+inc}];
inc = 18;
design_mat_25 = [design_mat{1+inc} design_mat{2+inc} design_mat{3+inc} design_mat{4+inc} design_mat{5+inc} design_mat{6+inc} design_mat{7+inc}];


%% Run PCA to get the most important stims 
for i = 1:25 % Assume you have design_mat_1 to design_mat_10
    eval(strcat('pc_mat_',num2str(i) ,'= pca_20(design_mat_',num2str(i),');'));
end