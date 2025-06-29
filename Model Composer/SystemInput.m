function NoisySignals  = SystemInput

    % Varsayılan Parametreler
    Fs = 300e6;
    BroadcastTime = 2e-3;
    PW = 10e-6;
    PRI = 100e-6;
    Fc = 25e6;
    SNR_dB = [10, 20, 40];
    CarrierAmplitude = 20;
    TimeVector = 0:1/Fs:BroadcastTime-1/Fs;
    
    %% Radar Sinyali Oluştur
    % Darbe treni oluşturma
    PulseTrain = PulseTrainGeneration(Fs, BroadcastTime, PW, PRI);
    ComplexCarrier = CarrierAmplitude * exp(1j * 2 * pi * Fc * TimeVector);
    PulseRadarSignal = ComplexCarrier .* PulseTrain;
    
    %% Gürültülü Sinyalleri Oluştur
    NoisySignals = zeros(length(PulseRadarSignal), length(SNR_dB));
    SignalPower = mean(abs(PulseRadarSignal).^2);
    
    for i = 1:length(SNR_dB)
        % Her SNR seviyesi için gürültü hesapla
        NoisePower = SignalPower / (10^(SNR_dB(i)/10));
        Noise = sqrt(NoisePower/2) * (randn(size(PulseRadarSignal)) + 1j*randn(size(PulseRadarSignal)));
        NoisySignals(:,i) = PulseRadarSignal + Noise;
    end
 
end

%% Yardımcı Fonksiyonlar
function [PulseTrain] = PulseTrainGeneration(Fs,BroadcastTime,PW,PRI)  
    TotalSamples = Fs*BroadcastTime;
    JustNoiseSamples = Fs * 100e-6;
    PulseTrain = zeros(1,TotalSamples);
    SignalStartSample = JustNoiseSamples + 1;

    PW_samples = PW * Fs;
    PRI_samples = PRI * Fs;
    
    pulse_start = SignalStartSample;
    while pulse_start + PW_samples - 1 <= TotalSamples
        pulse_end = pulse_start + PW_samples - 1;
        PulseTrain(pulse_start:pulse_end) = 1;
        pulse_start = pulse_start + PRI_samples;
    end
end
