clear; 
clc;
close all;
echo off all
N = 10; % number of channels
upper = 8000; % upper limit of Hz
lower = 100; % upper limit of Hz

% get the upper and lower bounds, center frequencies and bandwidth of N
% filters with logarithmically sized bandwidths
base = 50;
[filter_bounds, center_freq, bandwidth] = gen_filter_info(lower, upper, N, base);

% create Nx6 char matrix specifying the type of each filter
percent_butter = 0.7;
[filter_types, filter_labels] = gen_filter_types(center_freq, bandwidth, percent_butter);

% get an 1xN matrix of filters with the above specifications
filter_bank = gen_filter_bank(filter_bounds, filter_types);

% % plot frequency response of filters
fvt = fvtool(filter_bank(1), filter_bank(2), filter_bank(3), ...
            filter_bank(4), filter_bank(5), filter_bank(6), ... 
                    filter_bank(7), filter_bank(8), filter_bank(9),...
                        filter_bank(10));

% % create labels for each filter and make a legend
legend(filter_labels, 'Location','southwest');

save('phase_2_out.mat', 'center_freq', 'filter_bank');

% Files = dir('../Output Audio/**/*.wav');
% 
% for k = 1:length(Files) 
%    filename = Files(k).name;
%    folder = Files(k).folder;
%    C = strsplit(folder,'/');
%    folder = C(length(C));
%    [newSoundArray, combinedSound] = Process_Audio(folder(1), filename, filter_bank);
%    
%    rectified = rectify(newSoundArray(1,:));
%    
%    output = envelope(rectified);
%    figure("Name","Low");
%    hold on;
%    plot((1:size(output,1)), output);
%    axis([0 2500 0 0.00025]);
%    xlabel('Sample Number, n'); 
%    ylabel('Amplitude'); 
%    hold off;  
%    rectified = rectify(newSoundArray(size(newSoundArray,1),:));
%    output = envelope(rectified);
%    figure("Name","High");
%    hold on;
%    plot((1:size(output,1)), output);
%    axis([0 2500 0 0.0025]);
%    xlabel('Sample Number, n'); 
%    ylabel('Amplitude'); 
%    hold off;  
%    break
% end