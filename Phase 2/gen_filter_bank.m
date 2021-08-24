function table = gen_filter_bank(filter_bounds, filter_types)
% generates a 1xN matrix of filters
% parameters:
%   filter_bounds: Nx2 matrix with each row being the lower and upper bound
%   filter_type: 1xN matrix specifying type of filter 0:butter, 1:cheby1
% returns:
%   table: a 1xN array of digitalFilter objects specified by the parameters
N = size(filter_bounds, 1);
table = [];
for i = 1:N
    lower_freq = filter_bounds(i,1);
    upper_freq = filter_bounds(i,2);
    type = filter_types(i);
    if i == N
        disp([lower_freq, upper_freq, type]);
    end
    table = [table gen_filter(lower_freq, upper_freq, type)];
end
end

function bpFilt = gen_filter(lower_freq, upper_freq, type)
sample_rate = 16000;
filter_order = 20;
if isequal(type, 1)
    bpFilt = chebyFilt(lower_freq, upper_freq, sample_rate, filter_order);
else
    bpFilt = butterFilt(lower_freq, upper_freq, sample_rate, filter_order);
end
end

function bpFilt = butterFilt(lower_freq, upper_freq, sample_rate, filter_order)
bpFilt = designfilt('bandpassiir', 'FilterOrder',filter_order, ...
         'HalfPowerFrequency1',lower_freq, 'HalfPowerFrequency2',upper_freq, ...
         'SampleRate',sample_rate);
end

function bpFilt = chebyFilt(lower_freq, upper_freq, sample_rate, filter_order)
passband_ripple = 3;
bpFilt = designfilt('bandpassiir', 'FilterOrder',filter_order, ...
    'PassbandFrequency1',lower_freq, 'PassbandFrequency2',upper_freq, ...
    'PassbandRipple',passband_ripple, 'SampleRate',sample_rate);
end

% function bpFilt = chebyFilt2(lower_freq, upper_freq, sample_rate, filter_order)
% stopband_attenuation = 40;
% bpFilt = designfilt('bandpassiir','FilterOrder',filter_order, ...
%     'StopbandFrequency1',lower_freq, 'StopbandFrequency2',upper_freq, ...
%     'StopbandAttenuation',stopband_attenuation, 'SampleRate',sample_rate);
% end