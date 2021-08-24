function [filter_bounds, center_freq, bandwidth] = gen_filter_info(lower, upper, N, base)
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
bounds = logspace([log2(lower)/log2(base)], [log2(upper)/log2(base)], N+1, base);
filter_bounds = [bounds(1:N); bounds(2:N+1)]';
center_freq = mean(filter_bounds, 2);
bandwidth = filter_bounds(:,2) - filter_bounds(:,1);
end

function y = logspace(d1, d2, n, base)
y = base .^ linspace(d1, d2, n);
end
