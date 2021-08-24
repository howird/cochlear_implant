function output = rectify_envelope(input, filter_order, envelope_cutoff_frequency)
input = rectify(input);
sample_rate = 16000;
output = zeros(size(input));
lpFilt = designfilt('lowpassiir', 'FilterOrder',filter_order, ...
     'HalfPowerFrequency',envelope_cutoff_frequency, 'SampleRate',sample_rate);
for i = 1:size(input, 1)
    output(i,:) = filter(lpFilt, input(i,:));
end
end

function output = rectify(input)
output = abs(input);
end


