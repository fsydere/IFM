function [PulseTrain] = PulseTrainGeneration(Fs,BroadcastTime,PW,PRI)  
    TotalSamples = Fs*BroadcastTime;
    JustNoiseSamples = Fs * 100e-6;
    PulseTrain = zeros(TotalSamples, 1);
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