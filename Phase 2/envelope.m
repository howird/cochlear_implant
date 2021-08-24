function output = envelope(input)
  
sample_rate = 16000;
filter_order = 4;

%cheby1
% lpFilt = designfilt('lowpassiir', 'FilterOrder',filter_order, ...
%      'PassbandFrequency',400 ,'PassbandRipple',0.2, ...
%      'SampleRate',sample_rate);

% butter
lpFilt = designfilt('lowpassiir', 'FilterOrder',filter_order, ...
     'HalfPowerFrequency',400, 'SampleRate',sample_rate);
fvt = fvtool(lpFilt);
output = filter(lpFilt, input);
output = transpose(output);

end


