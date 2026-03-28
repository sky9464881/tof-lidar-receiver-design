% === 폴더 목록 설정 ===
base = 'C:\Users\sky94\OneDrive\문서\MATLAB\att';
subfolders = ["csv16", "csv20", "csv30", "csv40", "csv50", "csv56", "csv_ch1"];

% === 색상 설정 ===
colors = lines(length(subfolders));

% === 플로팅 시작 ===
figure; hold on;
threshold = 0;  % 교차 기준값
zero_crossings_all = cell(length(subfolders), 1);  % 교차점 저장

for i = 1:length(subfolders)
    folder = fullfile(base, subfolders(i));
    files = dir(fullfile(folder, '*.csv'));

    if isempty(files)
        warning('%s 폴더에 CSV 파일이 없습니다.', subfolders(i));
        continue;
    end

    data0 = readmatrix(fullfile(folder, files(1).name));
    time = data0(:, 1);
    N = length(time);
    M = length(files);
    amplitudes = zeros(N, M);

    for j = 1:M
        data = readmatrix(fullfile(folder, files(j).name));
        if length(data(:,2)) ~= N
            error("파일 %s: 길이 불일치", files(j).name);
        end
        amplitudes(:, j) = data(:, 2);
    end

    mean_wave = mean(amplitudes, 2);

    % === y = threshold 교차점 계산 ===
    zero_crossings = [];  % 초기화
    for k = 1:N-1
        y1 = mean_wave(k);
        y2 = mean_wave(k+1);
        if (y1 - threshold) * (y2 - threshold) < 0  % 교차 지점 존재
            x1 = time(k);
            x2 = time(k+1);
            x_cross = x1 + (threshold - y1) * (x2 - x1) / (y2 - y1);
            zero_crossings(end+1) = x_cross;
        end
    end
    zero_crossings_all{i} = zero_crossings;  % 결과 저장

    % === 플로팅 ===
    plot(time, mean_wave, 'LineWidth', 1.5, ...
        'DisplayName', subfolders(i), 'Color', colors(i,:));
end

xlabel('Time (s)');
ylabel('Mean Amplitude');
title(['Folder-wise Averaged Waveforms (Threshold = ' num2str(threshold) ')']);
legend('Location', 'best');
grid on;

% === 교차점 출력 ===
fprintf('\n===== y = %.3f 교차점 (x 값) =====\n', threshold);
for i = 1:length(subfolders)
    crossings = zero_crossings_all{i};
    if isempty(crossings)
        fprintf('%s: 교차 없음\n', subfolders(i));
    else
        fprintf('%s: %.6e\n', subfolders(i), crossings);
    end
end
