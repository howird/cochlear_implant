function s = gen_implant_input(input_sound, Fs, filter_bank, center_freq, envelope_order, envelope_cutoff_freq)
    % Task 10
    len = size(input_sound, 1);
    cosines = gen_cos_mat(center_freq, len, Fs);

    % Task 11
    out = apply_filters(input_sound, filter_bank);
    rect_out = rectify_envelope(out, envelope_order, envelope_cutoff_freq);
    scaled_cosines = rect_out.*cosines;

    % Task 12
    s = sum(scaled_cosines);
    s = s/max(s); % normalize
    
    function out = gen_cos_mat(freqs, len, Fs)
        out = zeros(size(freqs, 1), len);
        for i=1:size(freqs, 1)
            out(i,:) = gen_cos(freqs(i), len, Fs);
        end
    end

    function v = gen_cos(freq, len, Fs)
        t = linspace(0, len/Fs, len); % domain for cosine function to be played
        v = cos(2*pi*freq*t); % cosine function with angular frequency of 2000pi rad/s, frequency of 1000 Hz
    end

    function filteredSounds = apply_filters(y, filter_bank)
        filteredSounds = zeros(size(filter_bank, 2), size(y, 1));
        for i=1:size(filter_bank, 2)
            dataOut = filter(filter_bank(1,i), y);
            filteredSounds(i, :) = dataOut;
        end
    end

end


