% This program plots histograms with fitting.
% Created by Lesya on May 31, 2023 at 14:00 UTC

%% Input: 
%     dist is a distribution: normal, or Generalized Pareto (threshold 0),
%        or Gamma (K-distribution) 
%     figSaveTitle is to save (1) or not to save (0) the figures with
%        Titles
%     filenameFig is the path where to save the figures
%     figNameTitle is the name of the fig with title 

close all; clear all;

% adjust 
%%%%%%%%%%%%%%%% 
% choose #bins for hist and distrib
dist = 'normal';
nbins = 50;

% save (1) or not to save (0) the figures with Titles
figSaveTitle = 1;

% data path for fig to be saved
filenameFig = 'C:\Users\lesya\Documents\GitHub\GenerativeCFAR_Detection\figData\gaussian\';

% name of file
figNameTitle = 'gaussianPlT';
%%%%%%%%%%%%%%%%

% load the data
load('C:\Users\lesya\Documents\GitHub\GenerativeCFAR_Detection\training-data-gaussian.mat')

%% data preparation
%===
% dim for simulation
dimSim = size(data,1);

% dim for events
dimEv = size(data,2);

% dim for pulses
dimPl = size(data,3);

% dimSim * dimEv
dimSimEv = dimSim * dimEv; 
% index for dimSimEv
iDimSimEv = 1;
%===
% convert 3 dim into two dim
for iSim = 1:dimSim
    for iEv = 1:dimEv
        for iPl = 1:dimPl
            % calculate the absolute value
            absData(iDimSimEv,iPl) = sqrt((real(data(iSim,iEv,iPl)))^2 + (imag(data(iSim,iEv,iPl)))^2);
        end % for iPl = 1:dimPl
        iDimSimEv = iDimSimEv + 1;
    end % for iEv = 1:dimEv
end % for iSim = 1:dimSim



%% plot histogram 
% 
for iPl = 1:dimPl
    % convert tarIn to str
    iPlStr = num2str(iPl);
    %  obtain parameters used in fitting
    pd = fitdist(absData(iPl),dist);
    h = histfit(absData(iPl),nbins,dist);
    histfit(absData(iPl),nbins,dist);
    h(1).FaceColor = [.8 .8 1];
    title('Left Subplot');
    grid on;

    % to save (1) or not to save (0) the figures with Titles
    if figSaveTitle == 1
        savefig(strcat(filenameFig, figNameTitle, iPlStr, '.fig')); % fig format
        saveas(gcf, strcat(filenameFig, figNameTitle, iPlStr, '.jpg')); % jpg format;
           % gcf means to save current fig
    end % if figSaveTitle == 1
end % for iPl = 1:dimPl