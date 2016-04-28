clear
close all
%% ��������
data = cell(1, 20);
for i = 1 : 20
    data{i} = xlsread(['WanXing/', num2str(i), '.xlsx']);
end
%% ����쳣��
% 3�������ׯ�ĳ�ˮ�¶ȣ�9������̩��ĳ�ˮ�¶ȣ�5Ϊ���ׯ�����¶ȣ�6Ϊ���ׯ��������
% 11Ϊ��̩�������¶ȣ�12Ϊ��̩����������
% isnan�ȼ�����Щ���п�ֵ��Ȼ����ٲ���ǰ���������ƽ��ֵ
nullExWan  = cell(1, 20);
nullExXing = cell(1, 20);
nullOutWan  = cell(1, 20);
nullSunWan  = cell(1, 20);
nullOutXing = cell(1, 20);
nullSunXing = cell(1, 20);
% ִ��3�飬������NaN�����

    for i = 1 : 20
        % ���ҳ����ׯ����̩��Ŀ���������
        nullExWan{i}  = find(isnan(data{i}(:, 3)));
        nullOutWan{i}  = find(isnan(data{i}(:, 5)));
        nullSunWan{i}  = find(isnan(data{i}(:, 6)));
        nullExXing{i} = find(isnan(data{i}(:, 9)));
        nullOutXing{i} = find(isnan(data{i}(:, 11)));
        nullSunXing{i} = find(isnan(data{i}(:, 12)));

        % ����������ǰ���ֵ�
%          data{i}(nullExWan{i}, 3)  = (data{i}(nullExWan{i} - 2, 3) + data{i}(nullExWan{i} + 2, 3)) / 2;
%          data{i}(nullOutWan{i}, 5)  = (data{i}(nullOutWan{i} - 2, 5) + data{i}(nullOutWan{i} + 2, 5)) / 2;
%          data{i}(nullSunWan{i}, 6)  = (data{i}(nullSunWan{i} - 2, 6) + data{i}(nullSunWan{i} + 2, 6)) / 2;         
%          data{i}(nullExXing{i}, 9) = (data{i}(nullExXing{i} - 2, 9) + data{i}(nullExXing{i} + 2, 9)) / 2;
%          data{i}(nullOutXing{i}, 11) = (data{i}(nullOutXing{i} - 2, 11) + data{i}(nullOutXing{i} + 2, 11)) / 2;
%          data{i}(nullSunXing{i}, 12) = (data{i}(nullSunXing{i} - 2, 12) + data{i}(nullSunXing{i} + 2, 12)) / 2;

    end

%% ���ݴ���
wanFrecheteArr = zeros(1, 20);
xingFrecheteArr = zeros(1, 20);
wanDistArr = zeros(1, 20);
xingDistArr = zeros(1, 20);
for i = 1 : 20
    wanTemp    = data{i}(400:1200, 3);
    xingTemp   = data{i}(400:1200, 9);
    % ���ׯ�������ߣ������¶ȷ�ת����������������
    judgeTempWan = -data{i}(400:1200, 5) + 2.5 * (data{i}(400:1200, 6) / 350);
    judgeTempXing = -data{i}(400:1200, 11) + 2.5 * (data{i}(400:1200, 12) / 350);
    % ����������ߵ��������͵�
    [~, wanMax] = max(wanTemp);
    [~, wanMin] = min(wanTemp);
    [~, judgeMaxWan] = max(judgeTempWan);
    [~, judgeMinWan] = min(judgeTempWan);
    [~, judgeMaxXing] = max(judgeTempXing);
    [~, judgeMinXing] = min(judgeTempXing);
    [~, xingMax] = max(xingTemp);
    [~, xingMin] = min(xingTemp);
    % �����������ߵ�ŷ�Ͼ��룿���ǵ�֮��ļ��
%       wanDistArr(i) = abs(((wanMax - judgeMax) + (wanMin - judgeMin))/2);
%       xingDistArr(i) = abs(((xingMax - judgeMax) + (xingMin - judgeMin))/2);
      wanDistArr(i) = abs(wanMax - judgeMaxWan);
      xingDistArr(i) = abs(xingMax - judgeMaxXing);
    % ������Ӧ��Frechete Distance
    wanFrecheteArr(i) = DiscreteFrechetDist(wanTemp, judgeTempWan);
    xingFrecheteArr(i) = DiscreteFrechetDist(xingTemp, judgeTempXing);
end
%% ����
wanMatrix = [wanDistArr; wanFrecheteArr]';
xingMatrix = [xingDistArr; xingFrecheteArr]';
bothMatrix = [wanMatrix; xingMatrix];
% ��ʱ����K-means
%[u,re] = kmeans(bothMatrix, 2);
%% ��ͼ
plot(wanMatrix(:, 1), wanMatrix(:, 2), '*');
hold on
plot(xingMatrix(:, 1), xingMatrix(:, 2), 'o');
%plot(u(:, 1), u(:, 2), 'Xg');
legend('���ׯ', '��̩��')
title('Frechete + Delay��K-means������')
xlabel('Delay')
ylabel('FDF')



% plot(data{1}(400:1200,13),data{19}(400:1200,9))
% hold on
% judgeTempXing = -data{19}(400:1200, 11) + 2.5 * (data{19}(400:1200, 12) / 350);
% plot(data{1}(400:1200,13), judgeTempXing)
% %plot(data{1}(400:1200,13),data{9}(400:1200, 11))
% %plot(data{1}(400:1200,13),data{9}(400:1200, 12))
% datetick('x','HH')
% legend('��̩��','�¶�','����')