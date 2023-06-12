% This program plots histograms with fitting.
% Created by Lesya on May 31, 2023 at 14:00 UTC

%% creates
%   use saved data or create a new dataset

%% Input: 
%     usedOrNew is load saved data (0) or run new one (1) 
%     difStat is the increment for different statistics
%     dist is a distribution: Generalized Pareto (threshold 0),
%        or Gamma (K-distribution) 
%     figSaveTitle is to save (1) or not to save (0) the figures with
%        Titles
%     filenameFig is the path where to save the figures
%     figNameTitle is the name of the fig with title 

close all; clear all;

% adjust 
%%%%%%%%%%%%%%%% 
% for used saved data (0) or run new one (1)
usedOrNew = 1;

% increment for different statistics
difStat = 10000;

% choose #bins for hist and distrib
dist = 'generalized pareto';
nbins = 50;

% save (1) or not to save (0) the figures with Titles
figSaveTitle = 1;

% data path for fig to be saved
filenameFig = 'C:\Users\lesya\Documents\GitHub\GenerativeCFAR_Detection\figData\pareto\';

% name of file
figNameTitleXY = 'paretoPlTXY';

% switcher to the needed fomat for data saving:
        %    to mat if 0; csv and mat if 1, csv if 2
        extChoiseDataset = 0;

%= data path for loading preprocced data
dataPathSavedData = 'paretoXYReIm';
dataPathSavedDataRe = 'paretoXYRe';
dataPathSavedDataIm = 'paretonXYIm';
%=

% data path for loading original data
dataPathOrigData = 'C:\Users\lesya\Documents\GitHub\GenerativeCFAR_Detection\training-data-pareto.mat';
%%%%%%%%%%%%%%%%

%% Input parameters 
%%% use saved data or create a new dataset
if usedOrNew == 1
    createN_DataSetsFromOneReIm(dataPathOrigData, difStat,...
            dataPathSavedData, dataPathSavedDataRe, dataPathSavedDataIm,...
            extChoiseDataset);
end % if usedOrNew == 1
%%%

%% plot histogram 
% load help file
load([dataPathSavedData '.mat'])

for iFile = 1:k

    % load a file
    load([dataPathSavedData name1{k} '_' name2{k} '.mat']);     

    %%% add here your functions

   
end % iFile = 1:k
