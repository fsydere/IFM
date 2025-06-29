function [avg_freq_out,freq_err_out] = IFM(noisySignals)
    %% Varsayılan Parametreler
    Fs = 300e6;
    JustNoiseTime = 100e-6;
    Fc = 25e6;
    SNR_dB = [10, 20, 40];
    time_delays = [2, 4];

    %% Sistem Parametrelerini Hesapla
    JustNoiseSamples = Fs*JustNoiseTime;
    
    % Threshold hesaplama
    Threshold_db = zeros(1,length(SNR_dB));
    Threshold_linear = zeros(1,length(SNR_dB));
    power_dB = zeros(1,length(SNR_dB));
    
    for threshold_SNR_idx = 1:length(SNR_dB)
        % Gürültü gücünü sadece gürültü bölgesinden hesapla (0-100 μs)
        noise_power_linear = mean(abs(noisySignals(1:JustNoiseSamples,threshold_SNR_idx)).^2);
        noise_power_dB = 10*log10(noise_power_linear);
        
        % Threshold: gürültü seviyesinin 6 dB üzeri
        Threshold_db(threshold_SNR_idx) = noise_power_dB + 6;
        Threshold_linear(threshold_SNR_idx) = 10^(Threshold_db(threshold_SNR_idx)/10);
        
        % Toplam sinyal gücü
        power_linear = mean(abs(noisySignals(:,threshold_SNR_idx)).^2);
        power_dB(threshold_SNR_idx) = 10*log10(power_linear);
    end

    %% IFM (Instantaneous Frequency Measurement) İşleme

    % Her SNR seviyesi ve zaman kayması kombinasyonu için IFM
    IFM_results = struct();
    avg_freq_out = zeros(length(SNR_dB),length(time_delays));
    freq_err_out = zeros(length(SNR_dB),length(time_delays));
    for snr_idx = 1:length(SNR_dB)
        current_SNR = SNR_dB(snr_idx);
        current_signal = noisySignals(:, snr_idx);
        current_threshold = Threshold_linear(snr_idx);
               
        % Zarf tespiti (Envelope Detection)
        envelope = abs(current_signal).^2; % Güç zarfı
        
        % Threshold üzerindeki bölgeleri tespit et
        above_threshold = envelope > current_threshold;
        
        % Pulse bölgelerini bulma
        pulse_regions = findPulseRegions(above_threshold);
                
        % Her zaman kayması için IFM hesaplama
        for delay_idx = 1:length(time_delays)
            delay_samples = time_delays(delay_idx);
                        
            % IFM hesaplama
            [freq_estimates, avg_freq, freq_error] = calculateIFM(current_signal, pulse_regions, delay_samples, Fs, Fc);
            
            % Sonuçları kaydet
            field_name = sprintf('SNR_%ddB_delay_%d', current_SNR, delay_samples);
            IFM_results.(field_name).freq_estimates = freq_estimates;
            IFM_results.(field_name).average_frequency = avg_freq;
            IFM_results.(field_name).frequency_error = freq_error;
            IFM_results.(field_name).pulse_regions = pulse_regions;
            IFM_results.(field_name).envelope = envelope;
            IFM_results.(field_name).threshold = current_threshold;
            
            avg_freq_out(delay_idx,snr_idx) = avg_freq;
            freq_err_out(delay_idx,snr_idx) = freq_error;
        end
    end

    %% Yardımcı Fonksiyonlar

    function pulse_regions = findPulseRegions(above_threshold)
        % Threshold üzerindeki bağlı bölgeleri bulur
        pulse_regions = [];
        
        % Threshold geçişlerini bul
        diff_threshold = diff([0; above_threshold; 0]);
        start_indices = find(diff_threshold == 1);
        end_indices = find(diff_threshold == -1) - 1;
        
        % Her pulse bölgesi için başlangıç ve bitiş indekslerini kaydet
        for i = 1:length(start_indices)
            if start_indices(i) <= end_indices(i)
                pulse_regions = [pulse_regions; start_indices(i), end_indices(i)];
            end
        end
    end

    function [freq_estimates, avg_freq, freq_error] = calculateIFM(signal, pulse_regions, delay_samples, Fs, true_freq)
        % Sampling period
        freq_estimates = [];
        
        for i = 1:size(pulse_regions, 1)
            start_idx = pulse_regions(i, 1);
            end_idx = pulse_regions(i, 2);
            pulse_signal = signal(start_idx:end_idx);
            
            % Convert real signal to analytic (complex) form
            if isreal(pulse_signal)
                pulse_signal = hilbert(pulse_signal);
            end
            
            if length(pulse_signal) > delay_samples
                % Extract delayed and original segments
                delayed_signal = pulse_signal(1:end-delay_samples);
                original_signal = pulse_signal(delay_samples+1:end);
                
                % Vectorized phase difference calculation
                phase_diffs = angle(original_signal .* conj(delayed_signal));
                current_estimates = phase_diffs*Fs / (2 * pi * delay_samples);
                
                % Append estimates for this pulse
                freq_estimates = [freq_estimates; current_estimates(:)];
            end
        end
        
        % Compute average frequency and error
        if isempty(freq_estimates)
            avg_freq = NaN;
            freq_error = NaN;
        else
            avg_freq = mean(freq_estimates);
            freq_error = abs(avg_freq - true_freq);
        end
    end

   end