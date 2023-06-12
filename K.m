% This program plots histograms with fitting.
% Created by Lesya on May 31, 2023 at 14:00 UTC

%% creates
%   use saved data or create a new dataset

%% Input: 
%     usedOrNew is load saved data (0) or run new one (1) 
%     difStat is the increment for different statistics
%     dist is a distribution: Gamma (K-distribution) 
%     figSaveTitle is to save (1) or not to save (0) the figures with
%        Titles
%     filenameFig is the path where to save the figures
%     figNameTitle is the name of the fig with title 
%     dataPathOrigData is the path to the dataset
%     difStat is increment for different statistics
%     dataPathSavedData is the name of the file where to save information
%       about the group selection 
%     dataPathSavedDataAbs is the first part of the name of the file where to save data
%     extChoiseDataset is switcher to the needed fomat for data saving: 
%        to mat if 0; csv and mat if 1, csv if 2

close all; clear all;

% adjust 
%%%%%%%%%%%%%%%% 
% for used saved data (0) or run new one (1)
usedOrNew = 0;

% increment for different statistics
difStat = 10000;

% choose #bins for hist and distrib
dist = 'gamma';
nbins = 50;

% name of distr for title of a fig
distFig = 'K';

% save (1) or not to save (0) the figures with Titles
figSaveTitle = 1;

% data path for fig to be saved
filenameFig = 'C:\Users\lesya\Documents\GitHub\GenerativeCFAR_Detection\figData\K\';

% name of file
figNameTitle = 'KPlT';

% switcher to the needed fomat for data saving:
%    to mat if 0; csv and mat if 1, csv if 2
extChoiseDataset = 1;

%= data path for loading preprocced data
dataPathSavedData = 'KInf';
dataPathSavedDataAbs = 'KAbs';
%=

% data path for loading original data
dataPathOrigData = 'C:\Users\lesya\Documents\GitHub\GenerativeCFAR_Detection\training-data-K.mat';
%%%%%%%%%%%%%%%%

%% Input parameters 
%%% use saved data or create a new dataset
if usedOrNew == 1
    createN_DataSetsFromOneAbs(dataPathOrigData, difStat,...
            dataPathSavedData, dataPathSavedDataAbs, ...
            extChoiseDataset);
end % if usedOrNew == 1
%%%

%% plot histogram 
% load help file
load([dataPathSavedData '.mat'])

for iFile = 1:k
    % load a file
    load([dataPathSavedDataAbs name1{iFile} '_' name2{iFile} '.mat']);     

    for iPl = 1:dimPl
        % convert tarIn to str
        iPlStr = num2str(iPl);
    
        %  obtain parameters used in fitting
        pd = fitdist(absData(:,iPl),dist);
    
        % plot histogram
        %===
        figure(iPl)
        hC = histfit(absData(:,iPl),nbins,dist);
    
        % plot with Y-axis in percentages 
        yt = get(gca, 'YTick');
        set(gca, 'YTick', yt, 'YTickLabel', round(100*yt/numel(absData(:,iPl)),2))
    
        % color of the bins
        hC(1).FaceColor = [.8 .8 1];
    
        title(['distr.: ' distFig ', ' ...
             ' a = ' num2str(pd.a,'%5.4f') ', ' ...
             ' b = ' num2str(pd.b,'%5.4f') ', Pl.' iPlStr ', gr. '...
             name1{iFile} '-' name2{iFile}]);
        ylabel('% of total data');
        xlabel('\surd(Re(data)^2 + Im(data)^2)');
        grid on;
        %===  
    
        % to save (1) or not to save (0) the figures with Titles
        if figSaveTitle == 1
            savefig(strcat(filenameFig, figNameTitle, name1{iFile}, '_',...
                    name2{iFile}, 'Pl', iPlStr, '.fig')); % fig format
            saveas(gcf, strcat(filenameFig, figNameTitle, name1{iFile}, '_',...
                    name2{iFile}, 'Pl', iPlStr, '.jpg')); % jpg format;
               % gcf means to save current fig
        end % if figSaveTitle == 1
    end % for iPl = 1:dimPl
    clear absData;
end % iFile = 1:k
