clear; close all; clc;
%% System Girişi
% Sistem Parametreleri
Fs                  = 300e6;            % Örnekleme frekansı (300 MHz)
BroadcastTime       = 2e-3;             % Toplam yayın süresi (2 ms)
JustNoiseTime       = 100e-6;           % Sadece gürültü süresi (100 μs)
PW                  = 10e-6;            % Darbe genişliği (10 μs)
PRI                 = 100e-6;           % Darbe tekrarlama aralığı (100 μs)
Fc                  = 25e6;             % Taşıyıcı frekans (25 MHz)
SNR_dB              = [10, 20, 40];     % SNR seviyeleri (dB)
CarrierAmplitude    = 20;               % Başlangıç amplitüdü
time_delays         = [2, 4];           % IFM için zaman kaymaları (örnek sayısı)

TimeVector = 0:1/Fs:BroadcastTime-1/Fs;
TotalSamples = Fs*BroadcastTime;
JustNoiseSamples = Fs*JustNoiseTime;

[signal, time, pulse, noisySignals] = SystemInput();

%% System Processing

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

fprintf('\n=== Threshold Değerleri ===\n');
for i = 1:length(SNR_dB)
    fprintf('SNR %d dB için Threshold: %.2f dB\n', SNR_dB(i), Threshold_db(i));
end
fprintf('============================\n\n');

%% IFM (Instantaneous Frequency Measurement) İşleme

% Her SNR seviyesi ve zaman kayması kombinasyonu için IFM
IFM_results = struct();

for snr_idx = 1:length(SNR_dB)
    current_SNR = SNR_dB(snr_idx);
    current_signal = noisySignals(:, snr_idx);
    current_threshold = Threshold_linear(snr_idx);
    
    fprintf('SNR %d dB için IFM işleme başlıyor...\n', current_SNR);
    
    % Zarf tespiti (Envelope Detection)
    envelope = abs(current_signal).^2; % Güç zarfı
    
    % Threshold üzerindeki bölgeleri tespit et
    above_threshold = envelope > current_threshold;
    
    % Pulse bölgelerini bulma
    pulse_regions = findPulseRegions(above_threshold);
    
    fprintf('  Tespit edilen darbe sayısı: %d\n', size(pulse_regions, 1));
    
    % Her zaman kayması için IFM hesaplama
    for delay_idx = 1:length(time_delays)
        delay_samples = time_delays(delay_idx);
        
        fprintf('    Zaman kayması %d örnek için işleme...\n', delay_samples);
        
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
        
        fprintf('      Ortalama frekans: %.6f MHz (Hata: %.6f MHz)\n', ...
            avg_freq/1e6, freq_error/1e6);
    end
    fprintf('\n');
end

%% Sonuçları Görselleştir
visualizeIFMResults(IFM_results, TimeVector, SNR_dB, time_delays, Fc);

%% Sonuç Analizi ve Rapor
fprintf('\n=== IFM SONUÇ ANALİZİ ===\n');
fprintf('Gerçek Taşıyıcı Frekans: %.6f MHz\n\n', Fc/1e6);

% Sonuçları tablo formatında yazdır
fprintf('%-15s %-15s %-20s %-15s\n', 'SNR (dB)', 'Zaman Kayması', 'Ölçülen Frekans (MHz)', 'Hata (MHz)');
fprintf('%-15s %-15s %-20s %-15s\n', '-------', '-------------', '------------------', '----------');

for snr_idx = 1:length(SNR_dB)
    for delay_idx = 1:length(time_delays)
        field_name = sprintf('SNR_%ddB_delay_%d', SNR_dB(snr_idx), time_delays(delay_idx));
        avg_freq = IFM_results.(field_name).average_frequency;
        freq_error = IFM_results.(field_name).frequency_error;
        
        fprintf('%-15d %-15d %-20.6f %-15.6f\n', ...
            SNR_dB(snr_idx), time_delays(delay_idx), avg_freq/1e6, freq_error/1e6);
    end
end

fprintf('\n=== ANALİZ BULGULARI ===\n');
analyzeMeasurementPerformance(IFM_results, SNR_dB, time_delays, Fc);

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

function visualizeIFMResults(IFM_results, TimeVector, SNR_dB, time_delays, true_freq)
    % IFM sonuçlarını görselleştir
    
    % Ana sonuç grafikleri
    figure('Position', [100, 100, 1400, 1000], 'Name', 'IFM Analysis Results');
    
    % Alt grafik sayısını hesapla
    num_plots = length(SNR_dB) * length(time_delays);
    rows = length(SNR_dB);
    cols = length(time_delays) + 1; % +1 for envelope plot
    
    plot_idx = 1;
    
    for snr_idx = 1:length(SNR_dB)
        % Zarf grafiği
        subplot(rows, cols, (snr_idx-1)*cols + 1);
        field_name = sprintf('SNR_%ddB_delay_%d', SNR_dB(snr_idx), time_delays(1));
        envelope = IFM_results.(field_name).envelope;
        threshold = IFM_results.(field_name).threshold;
        
        plot(TimeVector*1e6, 10*log10(envelope));
        hold on;
        plot(TimeVector*1e6, 10*log10(threshold)*ones(size(TimeVector)), 'r--', 'LineWidth', 2);
        xlabel('Zaman (μs)');
        ylabel('Güç (dB)');
        title(sprintf('SNR %d dB - Zarf ve Threshold', SNR_dB(snr_idx)));
        legend('Zarf', 'Threshold', 'Location', 'best');
        grid on;
        xlim([0, 500]);
        
        % Her zaman kayması için frekans tahmini grafikleri
        for delay_idx = 1:length(time_delays)
            subplot(rows, cols, (snr_idx-1)*cols + 1 + delay_idx);
            field_name = sprintf('SNR_%ddB_delay_%d', SNR_dB(snr_idx), time_delays(delay_idx));
            freq_estimates = IFM_results.(field_name).freq_estimates;
            
            if ~isempty(freq_estimates)
                plot(freq_estimates/1e6, 'o-', 'LineWidth', 2, 'MarkerSize', 6);
                hold on;
                plot([1, length(freq_estimates)], [true_freq/1e6, true_freq/1e6], 'r--', 'LineWidth', 2);
                xlabel('Darbe Numarası');
                ylabel('Frekans (MHz)');
                title(sprintf('Delay %d - Frekans Tahminleri', time_delays(delay_idx)));
                legend('Ölçülen', 'Gerçek', 'Location', 'best');
                grid on;
            else
                text(0.5, 0.5, 'Veri Yok', 'HorizontalAlignment', 'center');
            end
        end
    end
    
    % Hata analizi grafiği
    figure('Position', [200, 200, 1000, 600], 'Name', 'IFM Error Analysis');
    
    % Hata matrisini oluştur
    error_matrix = zeros(length(SNR_dB), length(time_delays));
    
    for snr_idx = 1:length(SNR_dB)
        for delay_idx = 1:length(time_delays)
            field_name = sprintf('SNR_%ddB_delay_%d', SNR_dB(snr_idx), time_delays(delay_idx));
            error_matrix(snr_idx, delay_idx) = IFM_results.(field_name).frequency_error / 1e6;
        end
    end
    
    % Hata matrisi görselleştirmesi
    subplot(1, 2, 1);
    imagesc(error_matrix);
    colorbar;
    xlabel('Zaman Kayması Index');
    ylabel('SNR Index');
    title('Frekans Hata Matrisi (MHz)');
    set(gca, 'XTick', 1:length(time_delays), 'XTickLabel', time_delays);
    set(gca, 'YTick', 1:length(SNR_dB), 'YTickLabel', SNR_dB);
    
    % Hata grafikleri
    subplot(1, 2, 2);
    for delay_idx = 1:length(time_delays)
        plot(SNR_dB, error_matrix(:, delay_idx), 'o-', 'LineWidth', 2, ...
            'DisplayName', sprintf('Delay %d samples', time_delays(delay_idx)));
        hold on;
    end
    xlabel('SNR (dB)');
    ylabel('Frekans Hatası (MHz)');
    title('SNR vs Frekans Hatası');
    legend('Location', 'best');
    grid on;
end

function analyzeMeasurementPerformance(IFM_results, SNR_dB, time_delays, true_freq)
    % Ölçüm performansını analiz et
    
    % En iyi ve en kötü performansı bul
    min_error = Inf;
    max_error = 0;
    best_config = '';
    worst_config = '';
    
    for snr_idx = 1:length(SNR_dB)
        for delay_idx = 1:length(time_delays)
            field_name = sprintf('SNR_%ddB_delay_%d', SNR_dB(snr_idx), time_delays(delay_idx));
            error = IFM_results.(field_name).frequency_error;
            
            if ~isnan(error)
                if error < min_error
                    min_error = error;
                    best_config = sprintf('SNR %d dB, Delay %d samples', SNR_dB(snr_idx), time_delays(delay_idx));
                end
                
                if error > max_error
                    max_error = error;
                    worst_config = sprintf('SNR %d dB, Delay %d samples', SNR_dB(snr_idx), time_delays(delay_idx));
                end
            end
        end
    end
    
    fprintf('En iyi performans: %s (Hata: %.6f MHz)\n', best_config, min_error/1e6);
    fprintf('En kötü performans: %s (Hata: %.6f MHz)\n', worst_config, max_error/1e6);
    
    % Zaman kayması karşılaştırması
    fprintf('\nZaman Kayması Analizi:\n');
    for delay_idx = 1:length(time_delays)
        avg_error = 0;
        count = 0;
        for snr_idx = 1:length(SNR_dB)
            field_name = sprintf('SNR_%ddB_delay_%d', SNR_dB(snr_idx), time_delays(delay_idx));
            error = IFM_results.(field_name).frequency_error;
            if ~isnan(error)
                avg_error = avg_error + error;
                count = count + 1;
            end
        end
        if count > 0
            avg_error = avg_error / count;
            fprintf('  %d örnek gecikme ortalama hatası: %.6f MHz\n', time_delays(delay_idx), avg_error/1e6);
        end
    end
    
    % SNR etkisi analizi
    fprintf('\nSNR Etkisi Analizi:\n');
    for snr_idx = 1:length(SNR_dB)
        avg_error = 0;
        count = 0;
        for delay_idx = 1:length(time_delays)
            field_name = sprintf('SNR_%ddB_delay_%d', SNR_dB(snr_idx), time_delays(delay_idx));
            error = IFM_results.(field_name).frequency_error;
            if ~isnan(error)
                avg_error = avg_error + error;
                count = count + 1;
            end
        end
        if count > 0
            avg_error = avg_error / count;
            fprintf('  SNR %d dB ortalama hatası: %.6f MHz\n', SNR_dB(snr_idx), avg_error/1e6);
        end
    end
end