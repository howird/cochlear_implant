clear; 
clc;
close all;
echo off all;
is_linear = 0; % 0:logarithmic spacing, 1:linear spacing, default 0
filter_order = 20; % default 20
NUM_CHANNELS = 15; % default 10
% filter_types = [0 0 0 0 1]; % 5 channels
filter_types = [0 0 0 0 0 0 0 0 0 0 0 1 1 1 1]; % 15 channels
% filter_types = [0 0 0 0 0 0 0 1 1 1]; % this is the default, line below is for all the same type
% filter_types = zeros(1, NUM_CHANNELS) + 0; % 1xNUM_CHANNELS matrix which defines type for each filter 0:butter, 1:cheby, 2:FIR
envelope_order = 4; % default 4
envelope_cutoff_freq = 400; % default 400

output_audio_folder = 8; 

output_audio_folder_names = ['Design 1 - Original', "Design 2 - FIR", 'Design 3 - Linear Spacing', ...
    "Design 4 - Higher Filter Order", "Design 5 - Higher Cutoff Freq for Envelope", ...
    "Design 6 - All Butterworth", "Design 7 - 5 Channels", "Design 8 - 15 Channels"];

Files = dir('Phase 2 Audio/**/*.wav');

for k = 1:length(Files) 
   filename = Files(k).name;
   folder = Files(k).folder;
   C = strsplit(folder,'/');
   folder = C(length(C));
   Phase_3(folder(1), filename, is_linear, filter_order,NUM_CHANNELS, ...
       filter_types, envelope_order, envelope_cutoff_freq, ...
       output_audio_folder_names(output_audio_folder));
end