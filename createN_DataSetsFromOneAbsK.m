% createN_DataSetsFromOneAbs.m

%% creates
%     several data sets from one
%     combine datasets in two formats: .mat and csv

%% Inputs
% dataPathOrigData is the path to the dataset
% difStat is increment for different statistics
% dataPathSavedData is the name of the file where to save .mat 
% dataPathSavedDataAbs is the first part of the of the file where to save .csv abs(data)

%%% optional inputs:
% extChoiseDataset is switcher to the needed fomat for data saving: 
%    to mat if 0; csv and mat if 1, csv if 2
%%%

%% Outputs
% k is the number of files that are created
% saved files with real and imaginary data in several formats

%% Calling the function
% createN_DataSetsFromOne();
% 


function [k, name1, name2] = createN_DataSetsFromOneAbs(varargin)

switch nargin
    case 0
        disp('0 inputs given')
        return; 
    case 1
        disp('1 inputs given')
        return;
    case 4
        disp('5 inputs given')
        dataPathOrigData = varargin{1}; % the path to the original dataset
        difStat = varargin{2}; % increment for different statistics
        dataPathSavedData = varargin{3}; % name of the file where to save .mat
        dataPathSavedDataAbs = varargin{4}; % first part of the name of the file where to save .csv real(data)
        %%% default values
        % switcher to the needed fomat for data saving:
        %    to mat if 0; csv and mat if 1, csv if 2
        extChoiseDataset = 1;
        %%%
    case 5
        disp('6 inputs given')
        dataPathOrigData = varargin{1}; % the path to the original dataset
        difStat = varargin{2}; % increment for different statistics
        dataPathSavedData = varargin{3}; % name of the file where to save .mat
        dataPathSavedDataAbs = varargin{4}; % first part of the name of the file where to save .csv real(data)
        % switcher to the needed fomat for data saving:
        %    to mat if 0; csv and mat if 1, csv if 2
        extChoiseDataset = varargin{5};
     otherwise
        error('Unexpected inputs')
end % switch nargin

%%%

% load the data
load(dataPathOrigData)

%% data preparation
%===
% dim for simulation
dimSim = 1000 %size(data,1);

% dim for events
dimEv = size(data,2);

% dim for pulses
dimPl = size(data,3);

% difStatEv = difStat * dimEv; 
%    index for difStatEv
iDifStatEv = 1;
%===

% counter for dimSim
n = 1;
nStr1 = num2str(n);

% jump to dif. group
k = 1;
difStat = 10;
while n < dimSim
    n = difStat*k;

    % convert n to str (end)
    nStr2 = num2str(n);

    % index for a new group
    iSimNew = 1;

    % convert 3 dim into two dim
    for iSim = iDifStatEv:n
        for iEv = 1:dimEv
            for iPl = 1:dimPl
                % calculate the absolute value
                absData(iSimNew,iPl) = sqrt((real(data(iSim,iEv,iPl)))^2 + (imag(data(iSim,iEv,iPl)))^2);
            end % for iPl = 1:dimPl
            iSimNew = iSimNew + 1;
        end % for iEv = 1:dimEv
    end % for iSim = 1:dimSim
    
    % part of names
    name1{k} = nStr1;
    name2{k} = nStr2;

    iDifStatEv = n + 1;

    %% switcher to the needed fomat for data saving:
    switch extChoiseDataset
        case 0 % mat
            save([dataPathSavedData nStr1 '_' nStr2 '.mat'], 'absData', 'dimPl', 'k');
        case 1 % csv and mat
            %%% csv
            TAbs = array2table(absData);
                        
            % save
            writetable(TAbs,[dataPathSavedDataAbs  nStr1 '_' nStr2 '.csv'])
            %%%  
            
            % mat
            save([dataPathSavedData nStr1 '_' nStr2 '.mat'], 'absData', 'dimPl', 'k');
        case 2 % csv
            TAbs = array2table(reData);
                        
            % save
            writetable(TAbs,[dataPathSavedDataAbs  nStr1 '_' nStr2 '.csv'])
        otherwise
            error('Unexpected inputs')
    end % switch extChoiseDataset
   
    % convert n to str (beginning)
    nStr1 = num2str(n + 1);

    % next group
    k = k + 1;
end % n <= dimSim

% number of files that were created
k = k - 1;

% creat help file
save([dataPathSavedData '.mat'], 'k', 'name1', 'name2');







