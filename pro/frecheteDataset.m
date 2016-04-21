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
frecheteDis = cell(1, 20);
for i = 1 : 20
    wanTemp    = data{i}(400:1200, 3);
    xingTemp   = data{i}(400:1200, 9);
    % �������ߣ�����ֻ����0�ȵĻ�����+46��
    judageTemp = -data{i}(400:1200, 5) + 46;
    % ������Ӧ��Frechete Distance
    frecheteDis{i}(1) = DiscreteFrechetDist(wanTemp, judageTemp);
    frecheteDis{i}(2) = DiscreteFrechetDist(xingTemp, judageTemp);
end
%% ��ͼ
% �������־��������
wanArr = zeros(1, 20);
xingArr = zeros(1, 20);
for i = 1 : 20
    wanArr(i) = frecheteDis{i}(1);
    xingArr(i) = frecheteDis{i}(2);
end
xData = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
scatter(xData, wanArr, 'g')
hold on
scatter(xData, xingArr, 'm')
legend('���ׯ', '��̩��')