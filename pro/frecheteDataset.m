clear
close all
%% ��������
data = cell(1, 20);
for i = 1 : 20
    data{i} = xlsread(['cell/', num2str(i), '.xlsx']);
end
%% ����쳣��
% 3�������ׯ�ĳ�ˮ�¶ȣ�9������̩��ĳ�ˮ�¶�
% isnan�ȼ�����Щ���п�ֵ��Ȼ����ٲ���ǰ���������ƽ��ֵ
nullWan  = cell(1, 20);
nullXing = cell(1, 20);
nullOut  = cell(1, 20);
% ִ��3�飬������NaN�����
for j = 1 : 3
    for i = 1 : 20
        % ���ҳ����ׯ����̩��Ŀ���������
        nullWan{i}  = find(isnan(data{i}(:, 3)));    
        nullXing{i} = find(isnan(data{i}(:, 9)));
        nullOut{i}  = find(isnan(data{i}(:, 5)));
        % ����������ǰ���ֵ�
        data{i}(nullWan{i}, 3)  = (data{i}(nullWan{i} + 1, 3) + data{i}(nullWan{i} + 1, 3)) / 2;
        data{i}(nullXing{i}, 9) = (data{i}(nullXing{i} + 1, 9) + data{i}(nullXing{i} + 1, 9)) / 2;
        data{i}(nullOut{i}, 5)  = (data{i}(nullOut{i} + 1, 5) + data{i}(nullOut{i} + 1, 5)) / 2;
    end
end
%% ���ݴ���
wanFrecheteArr = zeros(1, 20);
xingFrecheteArr = zeros(1, 20);
wanDistArr = zeros(1, 20);
xingDistArr = zeros(1, 20);
for i = 1 : 20
    wanTemp    = data{i}(400:1200, 3);
    xingTemp   = data{i}(400:1200, 9);
    % �������ߣ�����ֻ����0�ȵĻ�����+46��
    judgeTemp = -data{i}(400:1200, 5) + 46;
    % ����������ߵ��������͵�
    [~, wanMax] = max(wanTemp);
    [~, wanMin] = min(wanTemp);
    [~, judgeMax] = max(judgeTemp);
    [~, judgeMin] = min(judgeTemp);
    [~, xingMax] = max(xingTemp);
    [~, xingMin] = min(xingTemp);
    % �����������ߵ�ŷ�Ͼ��룿���ǵ�֮��ļ��
    wanDistArr(i) = abs(((wanMax - judgeMax) + (wanMin - judgeMin))/2);
    xingDistArr(i) = abs(((xingMax - judgeMax) + (xingMin - judgeMin))/2);
    % ������Ӧ��Frechete Distance
    wanFrecheteArr(i) = DiscreteFrechetDist(wanTemp, judgeTemp);
    xingFrecheteArr(i) = DiscreteFrechetDist(xingTemp, judgeTemp);
end
%% ����
wanMatrix = [wanDistArr; wanFrecheteArr]';
xingMatrix = [xingDistArr; xingFrecheteArr]';
bothMatrix = [wanMatrix; xingMatrix];
% ��ʱ����K-means
[u,re] = kmeans(bothMatrix, 2);
%% ��ͼ
plot(wanMatrix(:, 1), wanMatrix(:, 2), '*');
hold on
plot(xingMatrix(:, 1), xingMatrix(:, 2), 'o');
plot(u(:, 1), u(:, 2), 'Xg');
legend('���ׯ', '��̩��', '���ĵ�')
title('Frechete + Delay��K-means������')
xlabel('Delay')
ylabel('FDF')