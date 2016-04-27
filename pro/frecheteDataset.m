clear
close all
%% 加载数据
data = cell(1, 20);
for i = 1 : 20
    data{i} = xlsread(['YongXing/', num2str(i), '.xlsx']);
end
%% 检测异常点
% 3代表万德庄的出水温度，9代表兴泰里的出水温度，5为室外温度，6为室外日照
% isnan先检测出哪些点有空值，然后后再插入前后两个点的平均值
nullWan  = cell(1, 20);
nullXing = cell(1, 20);
nullOut  = cell(1, 20);
nullSun  = cell(1, 20);
% 执行3遍，有连续NaN的情况

    for i = 1 : 20
        % 查找出万德庄和兴泰里的空数据序列
        nullWan{i}  = find(isnan(data{i}(:, 3)));
        nullXing{i} = find(isnan(data{i}(:, 9)));
        nullOut{i}  = find(isnan(data{i}(:, 5)));
        nullSun{i}  = find(isnan(data{i}(:, 6)));
        % 将空数据用前后均值填补
         data{i}(nullWan{i}, 3)  = (data{i}(nullWan{i} - 2, 3) + data{i}(nullWan{i} + 2, 3)) / 2;
         data{i}(nullXing{i}, 9) = (data{i}(nullXing{i} - 2, 9) + data{i}(nullXing{i} + 2, 9)) / 2;
         data{i}(nullOut{i}, 5)  = (data{i}(nullOut{i} - 2, 5) + data{i}(nullOut{i} + 2, 5)) / 2;
         data{i}(nullSun{i}, 6)  = (data{i}(nullSun{i} - 2, 6) + data{i}(nullSun{i} + 2, 6)) / 2;
    end

%% 数据处理
wanFrecheteArr = zeros(1, 20);
xingFrecheteArr = zeros(1, 20);
wanDistArr = zeros(1, 20);
xingDistArr = zeros(1, 20);
for i = 1 : 20
    wanTemp    = data{i}(400:1200, 3);
    xingTemp   = data{i}(400:1200, 9);
    % 评价曲线，室外温度反转，并加上日照因素
    judgeTemp = -data{i}(400:1200, 5) + 2.5 * (data{i}(400:1200, 6) / 350);
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
%      wanDistArr(i) = abs(wanMax - judgeMax);
%      xingDistArr(i) = abs(xingMax - judgeMax);
    % 计算相应的Frechete Distance
    wanFrecheteArr(i) = DiscreteFrechetDist(wanTemp, judgeTemp);
    xingFrecheteArr(i) = DiscreteFrechetDist(xingTemp, judgeTemp);
end
%% 处理
wanMatrix = [wanDistArr; wanFrecheteArr]';
xingMatrix = [xingDistArr; xingFrecheteArr]';
bothMatrix = [wanMatrix; xingMatrix];
% 暂时利用K-means
%[u,re] = kmeans(bothMatrix, 2);
%% 绘图
plot(wanMatrix(:, 1), wanMatrix(:, 2), '*');
hold on
plot(xingMatrix(:, 1), xingMatrix(:, 2), 'o');
%plot(u(:, 1), u(:, 2), 'Xg');
legend('万德庄', '兴泰里')
title('Frechete + Delay的K-means聚类结果')
xlabel('Delay')
ylabel('FDF')



plot(data{1}(400:1200,13),data{17}(400:1200,9))
hold on
plot(data{1}(400:1200,13),data{17}(400:1200, 5))
plot(data{1}(400:1200,13),data{17}(400:1200, 6))
datetick('x','HH')
legend('兴泰里','温度','日照')