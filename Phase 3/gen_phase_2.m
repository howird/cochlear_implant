function [center_freq, filter_bank] = gen_phase_2(is_linear, filter_order, filter_types, N)
upper = 8000; % upper limit of Hz, limit is 8000
lower = 100; % upper limit of Hz

% get the upper and lower bounds, center frequencies and bandwidth of N
% filters with logarithmically sized bandwidths
[filter_bounds, center_freq] = gen_filter_info(lower, upper, N, is_linear);

% get an 1xN matrix of filters with the above specifications
filter_bank = gen_filter_bank(filter_bounds, filter_types, filter_order);
end

function [filter_bounds, center_freq] = gen_filter_info(lower, upper, N, is_linear)
% splits upper and lower frequencies into N sections with logarithmic widths
% parameters:
%   lower: the lower bound of the entire frequency range
%   upper: the upper bound of the entire frequency range
%   N: the number of sections to divide the range into
%   base: the base of the logarithm that the sections are divided with
% returns:
%   filter bounds: Nx2 matrix of the upper and lower bounds of the N
%       sections generated
%   center_freq: Nx1 matrix the center frequencies of the N sections
%   bandwidth: Nx1 matrix the bandwidths of the N sections
if is_linear
    bounds = linspace(lower, upper, N+1);
else
    bounds = logspace(log10(lower), log10(upper), N+1);
end

filter_bounds = [bounds(1:N); bounds(2:N+1)]';
center_freq = mean(filter_bounds, 2);
end

function table = gen_filter_bank(filter_bounds, filter_types, filter_order)
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
        if upper_freq > 7990
            upper_freq = 7999.9999;
        end
        type = filter_types(i);
        table = [table gen_filter(lower_freq, upper_freq, type, filter_order)];
    end

end

function bpFilt = gen_filter(lower_freq, upper_freq, type, filter_order)
    sample_rate = 16000;
    if isequal(type, 1)
        bpFilt = chebyFilt(lower_freq, upper_freq, sample_rate, filter_order);
    elseif isequal(type, 2)
        bpFilt = firFilt(lower_freq, upper_freq, sample_rate, filter_order);
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

function bpFilt = firFilt(lower_freq, upper_freq, sample_rate, filter_order)
bpFilt = designfilt('bandpassfir','FilterOrder',filter_order, ...
    'CutoffFrequency1',lower_freq ,'CutoffFrequency2',upper_freq, ...
    'SampleRate', sample_rate);
end