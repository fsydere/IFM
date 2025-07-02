function [PulseRadarSignal, TimeVector, PulseTrain, NoisySignals] = SystemInput(varargin)
% RADARPULSETRAINGENERATOR Radar darbe treni oluşturur ve analiz eder
%
% Kullanım:
%   [signal, time, pulse] = RadarPulseTrainGenerator()
%   [signal, time, pulse] = RadarPulseTrainGenerator('ParameterName', Value, ...)
%
% Giriş Parametreleri (isteğe bağlı):
%   'Fs'                - Örnekleme frekansı (Hz) [varsayılan: 300e6]
%   'BroadcastTime'     - Toplam yayın süresi (s) [varsayılan: 2e-3]
%   'JustNoiseTime'     - Sadece gürültü süresi (s) [varsayılan: 100e-6]
%   'PW'                - Darbe genişliği (s) [varsayılan: 10e-6]
%   'PRI'               - Darbe tekrarlama aralığı (s) [varsayılan: 100e-6]
%   'Fc'                - Taşıyıcı frekans (Hz) [varsayılan: 25e6]
%   'SNR_dB'            - SNR seviyeleri (dB) [varsayılan: [10, 20, 40]]
%   'CarrierAmplitude'  - Taşıyıcı amplitüdü [varsayılan: 20]
%   'PlotResults'       - Sonuçları çiz (true/false) [varsayılan: true]
%
% Çıkış:
%   PulseRadarSignal    - Kompleks radar sinyali (temiz)
%   TimeVector          - Zaman vektörü
%   PulseTrain          - Darbe treni (baseband)
%   NoisySignals        - Gürültülü sinyaller (her SNR için ayrı sütun)
%
% Örnek:
%   % Varsayılan parametrelerle
%   [signal, time, pulse, noisySignals] = RadarPulseTrainGenerator();
%   
%   % Özel parametrelerle
%   [signal, time, pulse, noisySignals] = RadarPulseTrainGenerator('Fc', 50e6, 'PW', 5e-6, 'PlotResults', false);

%% Varsayılan Parametreler
defaultFs = 300e6;
defaultBroadcastTime = 2e-3;
defaultJustNoiseTime = 100e-6;
defaultPW = 10e-6;
defaultPRI = 100e-6;
defaultFc = 25e6;
defaultSNR_dB = [10, 20, 40];
defaultCarrierAmplitude = 1;
defaultPlotResults = true;

%% Giriş Parametrelerini Parse Et
p = inputParser;
addParameter(p, 'Fs', defaultFs, @(x) isnumeric(x) && x > 0);
addParameter(p, 'BroadcastTime', defaultBroadcastTime, @(x) isnumeric(x) && x > 0);
addParameter(p, 'JustNoiseTime', defaultJustNoiseTime, @(x) isnumeric(x) && x > 0);
addParameter(p, 'PW', defaultPW, @(x) isnumeric(x) && x > 0);
addParameter(p, 'PRI', defaultPRI, @(x) isnumeric(x) && x > 0);
addParameter(p, 'Fc', defaultFc, @(x) isnumeric(x) && x > 0);
addParameter(p, 'SNR_dB', defaultSNR_dB, @(x) isnumeric(x));
addParameter(p, 'CarrierAmplitude', defaultCarrierAmplitude, @(x) isnumeric(x) && x > 0);
addParameter(p, 'PlotResults', defaultPlotResults, @(x) islogical(x));

parse(p, varargin{:});

% Parametreleri değişkenlere ata
Fs = p.Results.Fs;
BroadcastTime = p.Results.BroadcastTime;
JustNoiseTime = p.Results.JustNoiseTime;
PW = p.Results.PW;
PRI = p.Results.PRI;
Fc = p.Results.Fc;
SNR_dB = p.Results.SNR_dB;
CarrierAmplitude = p.Results.CarrierAmplitude;
PlotResults = p.Results.PlotResults;

%% Sistem Parametrelerini Hesapla
TimeVector = 0:1/Fs:BroadcastTime-1/Fs;
TotalSamples = Fs*BroadcastTime;
JustNoiseSamples = Fs*JustNoiseTime;

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

for i = 1:length(SNR_dB)
    timespan = 0:1/Fs:BroadcastTime - 1/Fs;  % Doğru zaman vektörü
    data = timeseries(NoisySignals(:,i), timespan);
    
    file_name = sprintf('../SystemInputs/Fs_%d_Fc_%dMHz_PW_%dus_PRI_%dus_SNR_%ddB.mat', ...
        Fs/1e6, Fc/1e6, PW*1e6, PRI*1e6, SNR_dB(i));
    
    save(file_name, '-v7.3', 'data');  
end


for i = 1:length(SNR_dB)
    % Gerçek ve sanal kısımları ayır ve ölçekle
    real_part = round(real(NoisySignals(:, i)) * 2^15);
    imag_part = round(imag(NoisySignals(:, i)) * 2^15);

    % Saturasyon (int16 sınırı)
    real_part = min(max(real_part, -32768), 32767);
    imag_part = min(max(imag_part, -32768), 32767);

    % int16 türüne dönüştür
    real_part = int16(real_part);
    imag_part = int16(imag_part);

    % Dosya adını oluştur
    file_name_real = sprintf('../SystemInputs/Fs_%d_Fc_%dMHz_PW_%dus_PRI_%dus_SNR_%ddB_real.txt', ...
                        Fs/1e6, Fc/1e6, PW*1e6, PRI*1e6, SNR_dB(i));
    file_name_imag = sprintf('../SystemInputs/Fs_%d_Fc_%dMHz_PW_%dus_PRI_%dus_SNR_%ddB_imag.txt', ...
                        Fs/1e6, Fc/1e6, PW*1e6, PRI*1e6, SNR_dB(i));

    % Dosyayı aç (yazma modunda)
    fid = fopen(file_name_real, 'w');
    fid2 = fopen(file_name_imag, 'w');

    % Her satıra real ve imag değerlerini yaz
    for k = 1:length(real_part)
        fprintf(fid, '%d\n', real_part(k));  % tab ayracı
        fprintf(fid2, '%d\n', imag_part(k));  % tab ayracı
    end

    % Dosyayı kapat
    fclose(fid);
    fclose(fid2);
end

%% Sonuçları Görselleştir
if PlotResults
    plotResults(TimeVector, PulseTrain, PulseRadarSignal, NoisySignals, SNR_dB, Fs, PW, PRI, Fc, BroadcastTime);
end

%% Sistem bilgilerini göster
fprintf('\n=== Radar Darbe Treni Parametreleri ===\n');
fprintf('Örnekleme Frekansı: %.1f MHz\n', Fs/1e6);
fprintf('Darbe Genişliği: %.1f μs\n', PW*1e6);
fprintf('PRI: %.1f μs\n', PRI*1e6);
fprintf('Taşıyıcı Frekans: %.1f MHz\n', Fc/1e6);
fprintf('Toplam Süre: %.1f ms\n', BroadcastTime*1e3);
fprintf('Darbe Sayısı: %d\n', floor(BroadcastTime/PRI));
fprintf('Toplam Örnek Sayısı: %d\n', length(TimeVector));
fprintf('=======================================\n\n');

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

function plotResults(TimeVector, PulseTrain, PulseRadarSignal, NoisySignals, SNR_dB, Fs, PW, PRI, Fc, BroadcastTime)
    % Ana sinyal grafikleri
    figure('Position', [100, 100, 1200, 800], 'Name', 'Radar Darbe Treni Analizi');
    
    % Alt grafik 1: Darbe treni
    subplot(3,1,1);
    plot(TimeVector*1e6, PulseTrain);
    xlabel('Zaman (μs)');
    ylabel('Amplitüd');
    title('Darbe Treni (Baseband)');
    grid on;
    xlim([0, 500]); % İlk 500 μs'yi göster
    
    % Alt grafik 2: Gerçel kısım
    subplot(3,1,2);
    plot(TimeVector*1e6, real(PulseRadarSignal));
    xlabel('Zaman (μs)');
    ylabel('Amplitüd');
    title('Radar Darbe Treni - Gerçel Kısım');
    grid on;
    xlim([0, 500]); % İlk 500 μs'yi göster
    
    % Alt grafik 3: Frekans spektrumu
    subplot(3,1,3);
    N = length(PulseRadarSignal);
    f = (-N/2:N/2-1)*(Fs/N);
    PSD = abs(fftshift(fft(PulseRadarSignal))).^2;
    plot(f/1e6, 10*log10(PSD));
    xlabel('Frekans (MHz)');
    ylabel('Güç (dB)');
    title('Frekans Spektrumu');
    grid on;
    
    % SNR analizi
    figure('Position', [200, 200, 1200, 600], 'Name', 'SNR Analizi');
    
    for i = 1:length(SNR_dB)        
        subplot(2, 2, i);
        plot(TimeVector*1e6, real(NoisySignals(:,i)));
        xlabel('Zaman (μs)');
        ylabel('Amplitüd');
        title(['SNR = ', num2str(SNR_dB(i)), ' dB']);
        grid on;
        xlim([0, 300]); % İlk 300 μs'yi göster
    end
    
    % Sistem parametrelerini göster
    subplot(2, 2, 4);
    axis off;
    text(0.1, 0.9, 'Sistem Parametreleri:', 'FontSize', 12, 'FontWeight', 'bold');
    text(0.1, 0.8, ['Örnekleme Frekansı: ', num2str(Fs/1e6), ' MHz'], 'FontSize', 10);
    text(0.1, 0.7, ['Darbe Genişliği: ', num2str(PW*1e6), ' μs'], 'FontSize', 10);
    text(0.1, 0.6, ['PRI: ', num2str(PRI*1e6), ' μs'], 'FontSize', 10);
    text(0.1, 0.5, ['Taşıyıcı Frekans: ', num2str(Fc/1e6), ' MHz'], 'FontSize', 10);
    text(0.1, 0.4, ['Toplam Süre: ', num2str(BroadcastTime*1e3), ' ms'], 'FontSize', 10);
    text(0.1, 0.3, ['Darbe Sayısı: ', num2str(floor(BroadcastTime/PRI))], 'FontSize', 10);
end