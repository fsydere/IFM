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

[IFM_results] = IFM(noisySignals);