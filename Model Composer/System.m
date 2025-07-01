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
CarrierAmplitude    = 1;                % Başlangıç amplitüdü
time_delays         = [2, 4];           % IFM için zaman kaymaları (örnek sayısı)

TimeVector = 0:1/Fs:BroadcastTime-1/Fs;
TotalSamples = Fs*BroadcastTime;
JustNoiseSamples = Fs*JustNoiseTime;

[signal, time, pulse, noisySignals] = SystemInput('CarrierAmplitude', CarrierAmplitude);
Threshold_db = zeros(1,length(SNR_dB));
Threshold_linear = zeros(1,length(SNR_dB));
power_dB = zeros(1,length(SNR_dB));
before_mean_noise_power = zeros(1,length(SNR_dB));
for threshold_SNR_idx = 1:length(SNR_dB)
    % Gürültü gücünü sadece gürültü bölgesinden hesapla (0-100 μs)
    noise_power_linear = mean(abs(noisySignals(1:JustNoiseSamples,threshold_SNR_idx)).^2);
    noise_power_dB = 10*log10(noise_power_linear);
    
    before_mean_noise_power(threshold_SNR_idx) = JustNoiseSamples*noise_power_linear;

    % Threshold: gürültü seviyesinin 6 dB üzeri
    Threshold_db(threshold_SNR_idx) = noise_power_dB + 6;
    Threshold_linear(threshold_SNR_idx) = 10^(Threshold_db(threshold_SNR_idx)/10);
    
    % Toplam sinyal gücü
    power_linear = mean(abs(noisySignals(:,threshold_SNR_idx)).^2);
    power_dB(threshold_SNR_idx) = 10*log10(power_linear);
end

[IFM_results] = IFM(noisySignals);

% close all;