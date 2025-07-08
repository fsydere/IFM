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

[noisySignals] = SystemInput('Fs',Fs, ...
    'BroadcastTime',BroadcastTime, 'JustNoiseTime',JustNoiseTime, ...
    'PW',PW, 'PRI',PRI, 'Fc',Fc, 'SNR_dB',SNR_dB, ...
    'CarrierAmplitude',CarrierAmplitude);

% For Debug Purposes Only
% Before_mean_noise = zeros(1,length(SNR_dB)); After_mean_noise =
% zeros(1,length(SNR_dB));
% 
% for threshold_SNR_idx = 1:length(SNR_dB)
%     Before_mean_noise(threshold_SNR_idx) = JustNoiseSamples *
%     mean(abs(noisySignals(1:JustNoiseSamples,threshold_SNR_idx)).^2);
%     After_mean_noise(threshold_SNR_idx) =
%     mean(abs(noisySignals(1:JustNoiseSamples,threshold_SNR_idx)).^2);
% end

[IFM_results] = IFM(noisySignals,'Fs',Fs, ...
    'BroadcastTime',BroadcastTime, 'JustNoiseTime',JustNoiseTime, ...
     'Fc',Fc, 'SNR_dB',SNR_dB, 'time_delays', time_delays);

% close all;