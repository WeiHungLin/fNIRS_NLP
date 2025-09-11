%% Create the hb object
%--------------This part see Step B---------------------------
% 
% datafolder='F:\MatlabBackUp\PROJECT_HH_ENGLISH\Pilot_Aanalysis_LLM_data_prep\story_data_v2\WD';
% % datafolder='/Volumes/Franknano/MatlabBackUp/PROJECT_DyslexiaR01/HHData_Cleaned';
% raw = nirs.io.loadDirectory(datafolder,{'Subject'});
% 
% disp('Running data resample...')
% resample=nirs.modules.Resample();
% resample.Fs=1;
% downraw=resample.run(raw);
% 
% disp('Converting Optical Density...')
% odconv=nirs.modules.OpticalDensity();
% od=odconv.run(downraw);
% 
% disp('Applying  Modified Beer Lambert Law...')
% mbll=nirs.modules.BeerLambertLaw();
% hb=mbll.run(od);
% 
% % for i = 1:length(hb)
% %     if length(hb(i).time) == length(hb(i).data)
% %         disp(1)
% %     else
% %         disp(0)
% %     end
% % end
% 
% disp('Trimming .nirs files...')
% trim=nirs.modules.TrimBaseline();
% trim.preBaseline=0;
% trim.postBaseline=30;
% hb_trim=trim.run(hb);
%% Check which data is in the sample
for i=1:length(hb_trim)
   r(i,1)=str2num(hb_trim(i).demographics.values{2}); 
end

%% Save the hb data with fixed length 4180 to ignore the 0 section
% Check if the length of the hb data is the same
lc_list_hbo = [1 3 5 7 11 13 15 17 21 23 25 27 31 33 37 39 41 ...
    43 45 47 49 53 55 57 59 63 65 67 71 75 77 79];
% ssc_list

for i = 1:length(hb_trim)
    if length(hb_trim(i).data)~=836
        disp(i);
        disp(length(hb_trim(i).data))
    end
end
% Looks like all the data are in 836 sec

for i = 1:97
    try
        hbodata = hb_trim(i).data(1:836,lc_list_hbo);
    catch
        disp(strcat(hb_trim(i).description,' not fit...'));
    end
    [folder, baseFileName, ~] = fileparts(hb_trim(i).description);
    ext='.mat';
    fileNameWithExt = [baseFileName, ext];
    save(strcat('./Data/v3_hbdata/extracted_hbo_data_full/TD/',fileNameWithExt), 'hbodata');
    disp(strcat(num2str(i),'...'));
end

for i = 98:173
    try
        hbodata = hb_trim(i).data(1:836,lc_list_hbo);
    catch
        disp(strcat(hb_trim(i).description,' not fit...'));
    end
    [folder, baseFileName, ~] = fileparts(hb_trim(i).description);
    ext='.mat';
    fileNameWithExt = [baseFileName, ext];
    save(strcat('./Data/v3_hbdata/extracted_hbo_data_full/WD/',fileNameWithExt), 'hbodata');
    disp(strcat(num2str(i),'...'));
end
