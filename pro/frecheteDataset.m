clear
close all
%% 加载数据
data = cell(1, 20);
for i = 1 : 20
    data{i} = xlsread(['cell/', num2str(i), '.xlsx']);
end
%% 检测异常点
% 3代表万德庄的出水温度，9代表兴泰里的出水温度
% isnan先检测出哪些点有空值，然后后再插入前后两个点的平均值
nullWan  = cell(1, 20);
nullXing = cell(1, 20);
nullOut  = cell(1, 20);
% 执行3遍，有连续NaN的情况
for j = 1 : 3
    for i = 1 : 20
        % 查找出万德庄和兴泰里的空数据序列
        nullWan{i}  = find(isnan(data{i}(:, 3)));    
        nullXing{i} = find(isnan(data{i}(:, 9)));
        nullOut{i}  = find(isnan(data{i}(:, 5)));
        % 将空数据用前后均值填补
        data{i}(nullWan{i}, 3)  = (data{i}(nullWan{i} + 1, 3) + data{i}(nullWan{i} + 1, 3)) / 2;
        data{i}(nullXing{i}, 9) = (data{i}(nullXing{i} + 1, 9) + data{i}(nullXing{i} + 1, 9)) / 2;
        data{i}(nullOut{i}, 5)  = (data{i}(nullOut{i} + 1, 5) + data{i}(nullOut{i} + 1, 5)) / 2;
    end
end
%% 数据处理
wanFrecheteArr = zeros(1, 20);
xingFrecheteArr = zeros(1, 20);
wanDistArr = zeros(1, 20);
xingDistArr = zeros(1, 20);
for i = 1 : 20
    wanTemp    = data{i}(400:1200, 3);
    xingTemp   = data{i}(400:1200, 9);
    % 评价曲线，现在只是在0度的基础上+46度
    judgeTemp = -data{i}(400:1200, 5) + 46;
    % 获得三条曲线的至高至低点
    [~, wanMax] = max(wanTemp);
    [~, wanMin] = min(wanTemp);
    [~, judgeMax] = max(judgeTemp);
    [~, judgeMin] = min(judgeTemp);
    [~, xingMax] = max(xingTemp);
    [~, xingMin] = min(xingTemp);
    % 计算两条曲线的欧氏距离？就是点之间的间隔
    wanDistArr(i) = abs(((wanMax - judgeMax) + (wanMin - judgeMin))/2);
    xingDistArr(i) = abs(((xingMax - judgeMax) + (xingMin - judgeMin))/2);
    % 计算相应的Frechete Distance
    wanFrecheteArr(i) = DiscreteFrechetDist(wanTemp, judgeTemp);
    xingFrecheteArr(i) = DiscreteFrechetDist(xingTemp, judgeTemp);
end
%% 处理
wanMatrix = [wanDistArr; wanFrecheteArr]';
xingMatrix = [xingDistArr; xingFrecheteArr]';
bothMatrix = [wanMatrix; xingMatrix];
% 暂时利用K-means
[u,re] = kmeans(bothMatrix, 2);
%% 绘图
plot(wanMatrix(:, 1), wanMatrix(:, 2), '*');
hold on
plot(xingMatrix(:, 1), xingMatrix(:, 2), 'o');
plot(u(:, 1), u(:, 2), 'Xg');
legend('万德庄', '兴泰里', '中心点')
title('Frechete + Delay的K-means聚类结果')
xlabel('Delay')
ylabel('FDF')