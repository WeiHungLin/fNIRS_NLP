%% Create the hb object
% By Frank Hu 2025-09
datafolder='./Example_data/cutted_data';
raw = nirs.io.loadDirectory(datafolder,{'Subject'});

disp('Running data resample...')
resample=nirs.modules.Resample();
resample.Fs=1;
downraw=resample.run(raw);

disp('Converting Optical Density...')
odconv=nirs.modules.OpticalDensity();
od=odconv.run(downraw);

disp('Applying  Modified Beer Lambert Law...')
mbll=nirs.modules.BeerLambertLaw();
hb=mbll.run(od);

disp('Trimming .nirs files...')
trim=nirs.modules.TrimBaseline();
trim.preBaseline=0;
trim.postBaseline=0;
hb_trim=trim.run(hb);

%% Save the hb data with fixed length 837 sec

% ssc_list, only the channel with hbo and not short separation channels are
% included
lc_list_hbo = [1 3 5 7 11 13 15 17 21 23 25 27 31 33 37 39 41 ...
    43 45 47 49 53 55 57 59 63 65 67 71 75 77 79];

% Check the length of the hb data 
for i = 1:length(hb_trim)
    if length(hb_trim(i).data)~=837
        disp(i);
        disp(length(hb_trim(i).data))
    end
end
% Looks like all the data are in 837 sec

% Save the hbo data to the data folder
for i = 1:length(hb_trim)
    try
        hbodata = hb_trim(i).data(1:837,lc_list_hbo);
    catch
        disp(strcat(hb_trim(i).description,' not fit...'));
    end
    [folder, baseFileName, ~] = fileparts(hb_trim(i).description);
    ext='.mat';
    fileNameWithExt = [baseFileName, ext];
    save(strcat('./Example_data/hbo_data_forcast',fileNameWithExt), 'hbodata');
    disp(strcat(num2str(i),'...'));
end