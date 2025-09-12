%% Load NIRS Toolbox
% addpath if needed
% addpath(genpath('path_to_nirs_toolbox'));

%% Read Data
datafolder = './Example_data/cutted_data';
dataset = nirs.io.loadDirectory(datafolder, {'Subject'});

%% Read design matrix (rows 140 to 2096)
design_mat = './Example_data/surprisal_data/HH_DesignMatrix_augmented.csv';
T = readtable(design_mat);
stimmarkexcel = T.End_time_combined; % Time
lex_surprisal = T.lex_surprisal_bits;  % lex Surprisal
pos_surprisal = T.pos_surprisal_bits; % sytax surprisal
pho_surprisal = T.phoneme_surprisal_bits; % phoneme surprisal
word_rate     = T.WordRate;  % Word rate
word_freq  = T.Log_Freq_HAL; % Word frequency

%% Loop through each subject and assign stimulus
for k = 1:length(dataset)
    clearvars -except k dataset stimmarkexcel word_rate word_freq lex_surprisal pos_surprisal pho_surprisal

    % Align timing
    try
        existingStim = dataset(k,1).stimulus.keys;
        if isempty(existingStim)
            error('Stimulus not initialized');
        end
        difff = dataset(k,1).stimulus.values{1,1}.onset(1) - stimmarkexcel(1);
        
    catch
        difff = 0;  % fallback if no stimulus present
    end

    % Create stimulus structure
    stim = Dictionary();  % NIRS toolbox stimulus dictionary

    % Channel 1: Binary stimulus
    s1 = nirs.design.StimulusEvents();
    %s1.onset = stimmarkexcel + difff;
    s1.onset = stimmarkexcel;
    s1.dur = ones(1957,1) * 0.02;
    s1.amp = word_rate;
    s1.name = 'word_rate';
    stim('stim_channel1') = s1;

    % Channel 2: Word freq
    s2 = nirs.design.StimulusEvents();
    s2.onset = s1.onset;
    s2.dur = s1.dur;
    s2.amp = word_freq;
    s2.name = 'word_freq';
    stim('stim_channel2') = s2;
    
    % Channel 3: Lex Surprisal
    s3 = nirs.design.StimulusEvents();
    s3.onset = s1.onset;
    s3.dur = s1.dur;
    s3.amp = lex_surprisal;
    s3.name = 'lex_surp';
    stim('stim_channel3') = s3;
    
    % Channel 4: Pos Surprisal
    s4 = nirs.design.StimulusEvents();
    s4.onset = s1.onset;
    s4.dur = s1.dur;
    s4.amp = pos_surprisal;
    s4.name = 'pos_surp';
    stim('stim_channel4') = s4;
    
    % Channel 5: Pho Surprisal
    s5 = nirs.design.StimulusEvents();
    s5.onset = s1.onset;
    s5.dur = s1.dur;
    s5.amp = pho_surprisal;
    s5.name = 'pho_surp';
    stim('stim_channel5') = s5;

    % Update dataset
    dataset(k,1).stimulus = stim;

    disp(['Subject ' num2str(k) ' complete...']);
end

%% Save result
mkdir('D:\Downloads\Data_Updated_Stimuli')
save('D:\Downloads\Data_Updated_Stimuli\Data_Gain_Stimuli_Surprisal_WordRate.mat', ...
     'dataset', '-v7.3', '-nocompression');
