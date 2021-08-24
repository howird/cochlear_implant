function [filter_types, filter_labels] = gen_filter_types(center_freq, bandwidth, percent_butter)
%helper function that generates 2 N-row lists specifying the 
% characteristics of each filter
% parameters:
%   center_freq: Nx1 matrix the center frequencies of the N sections
%   bandwidth: Nx1 matrix the bandwidths of the N sections
%   percent_butter: float to specify what percentage of the filters should be
%       butterworth filters, the rest will be cheby1
% returns:
%   filter_types: Nx1 binary array specifying if the filter is a butter (0)
%       or a cheby1 (1)
%   filter_labels: N row cell table with the label of each filter

N = size(bandwidth, 1);
num_butter = round(N*percent_butter);
filter_names = [repmat('butter', num_butter, 1); repmat('cheby1', N-num_butter, 1)];
filter_types = [zeros(num_butter, 1); ones(N-num_butter, 1)];

filter_labels = cell(1,N);
for i = 1:N
    filter_labels{1, i} =  sprintf('%s, f_c: %iHz, bandwidth: %iHz', ...
        filter_names(i,:), floor(center_freq(i)), floor(bandwidth(i)));
end

end

