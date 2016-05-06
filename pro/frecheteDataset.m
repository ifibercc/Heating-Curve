clear
close all
%% 加载数据
data = cell(1, 20);
for i = 1 : 20
    data{i} = xlsread(['YongXing/', num2str(i), '.xlsx']);
end
%% 检测异常点
% 3代表万德庄的出水温度，9代表兴泰里的出水温度，5为万德庄室外温度，6为万德庄室外日照
% 11为兴泰里室外温度，12为兴泰里室外日照
% isnan先检测出哪些点有空值，然后后再插入前后两个点的平均值
nullExWan  = cell(1, 20);
nullExXing = cell(1, 20);
nullOutWan  = cell(1, 20);
nullSunWan  = cell(1, 20);
nullOutXing = cell(1, 20);
nullSunXing = cell(1, 20);
% 执行3遍，有连续NaN的情况

    for i = 1 : 20
        % 查找出万德庄和兴泰里的空数据序列
        nullExWan{i}  = find(isnan(data{i}(:, 3)));
        nullOutWan{i}  = find(isnan(data{i}(:, 5)));
        nullSunWan{i}  = find(isnan(data{i}(:, 6)));
        nullExXing{i} = find(isnan(data{i}(:, 9)));
        nullOutXing{i} = find(isnan(data{i}(:, 11)));
        nullSunXing{i} = find(isnan(data{i}(:, 12)));

        % 将空数据用前后均值填补
%          data{i}(nullExWan{i}, 3)  = (data{i}(nullExWan{i} - 2, 3) + data{i}(nullExWan{i} + 2, 3)) / 2;
%          data{i}(nullOutWan{i}, 5)  = (data{i}(nullOutWan{i} - 2, 5) + data{i}(nullOutWan{i} + 2, 5)) / 2;
%          data{i}(nullSunWan{i}, 6)  = (data{i}(nullSunWan{i} - 2, 6) + data{i}(nullSunWan{i} + 2, 6)) / 2;         
%          data{i}(nullExXing{i}, 9) = (data{i}(nullExXing{i} - 2, 9) + data{i}(nullExXing{i} + 2, 9)) / 2;
%          data{i}(nullOutXing{i}, 11) = (data{i}(nullOutXing{i} - 2, 11) + data{i}(nullOutXing{i} + 2, 11)) / 2;
%          data{i}(nullSunXing{i}, 12) = (data{i}(nullSunXing{i} - 2, 12) + data{i}(nullSunXing{i} + 2, 12)) / 2;

    end

%% 数据处理
wanFrecheteArr = zeros(1, 20);
xingFrecheteArr = zeros(1, 20);
wanDistArr = zeros(1, 20);
xingDistArr = zeros(1, 20);
for i = 1 : 20
    wanTemp    = data{i}(400:1200, 3);
    xingTemp   = data{i}(400:1200, 9);
    % 评价曲线，气象仪各个地方用的是一个数据，通过采集仪器下发得到，兴泰里考虑了时间段
    judgeTemp = [(-data{i}(400:976, 5) - 0.5); (-data{i}(977:1140, 5) - 6.9); (-data{i}(1141:1200, 5) - 1)] + 84;
    % 计算相应的Frechete Distance
    wanFrecheteArr(i) = DiscreteFrechetDist(wanTemp, judgeTemp);
    xingFrecheteArr(i) = DiscreteFrechetDist(xingTemp, judgeTemp);
    % 获得三条曲线的至高至低点
    wanTempNow = wanTemp;
    xingTempNow = xingTemp;
    judgeTempNow = judgeTemp;
    wanDis = 0;
    xingDis = 0;
    for j = 1 : 100
        [~, wanMax] = max(wanTempNow);
        [~, xingMax] = max(xingTempNow);
        [~, judgeMax] = max(judgeTempNow);
        wanDis = wanDis + wanMax - judgeMax;
        xingDis = xingDis + xingMax - judgeMax;
        wanTempNow(wanMax) = -99;
        xingTempNow(xingMax) = -99;
    end

    % 计算两条曲线的欧氏距离？就是点之间的间隔
%       wanDistArr(i) = abs(((wanMax - judgeMax) + (wanMin - judgeMin))/2);
%       xingDistArr(i) = abs(((xingMax - judgeMax) + (xingMin - judgeMin))/2);
      wanDistArr(i) = wanDis / 100;
      xingDistArr(i) = xingDis / 100;

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
legend('永基', '兴泰里')
title('Frechete + Delay的K-means聚类结果')
xlabel('Delay')
ylabel('FDF')

% i = 5;
% judgeTemp = [(-data{i}(400:976, 5) - 0.5); (-data{i}(977:1140, 5) - 6.9); (-data{i}(1141:1200, 5) - 1)] + 84;
% plot(data{1}(400:1200,13),data{i}(400:1200,3))
% hold on
% plot(data{1}(400:1200,13),data{i}(400:1200,9))
% plot(data{1}(400:1200,13), judgeTemp)
% datetick('x','HH')
% legend('永基','兴泰里','评价')
% title('永基和兴泰里3月2日出水温度及评价曲线对比图')