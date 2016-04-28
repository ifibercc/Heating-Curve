clear
close all
%% 加载数据
data = cell(1, 20);
for i = 1 : 20
    data{i} = xlsread(['WanXing/', num2str(i), '.xlsx']);
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
    % 万德庄评价曲线，室外温度反转，并加上日照因素
    judgeTempWan = -data{i}(400:1200, 5) + 2.5 * (data{i}(400:1200, 6) / 350);
    judgeTempXing = -data{i}(400:1200, 11) + 2.5 * (data{i}(400:1200, 12) / 350);
    % 获得三条曲线的至高至低点
    [~, wanMax] = max(wanTemp);
    [~, wanMin] = min(wanTemp);
    [~, judgeMaxWan] = max(judgeTempWan);
    [~, judgeMinWan] = min(judgeTempWan);
    [~, judgeMaxXing] = max(judgeTempXing);
    [~, judgeMinXing] = min(judgeTempXing);
    [~, xingMax] = max(xingTemp);
    [~, xingMin] = min(xingTemp);
    % 计算两条曲线的欧氏距离？就是点之间的间隔
%       wanDistArr(i) = abs(((wanMax - judgeMax) + (wanMin - judgeMin))/2);
%       xingDistArr(i) = abs(((xingMax - judgeMax) + (xingMin - judgeMin))/2);
      wanDistArr(i) = abs(wanMax - judgeMaxWan);
      xingDistArr(i) = abs(xingMax - judgeMaxXing);
    % 计算相应的Frechete Distance
    wanFrecheteArr(i) = DiscreteFrechetDist(wanTemp, judgeTempWan);
    xingFrecheteArr(i) = DiscreteFrechetDist(xingTemp, judgeTempXing);
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



% plot(data{1}(400:1200,13),data{19}(400:1200,9))
% hold on
% judgeTempXing = -data{19}(400:1200, 11) + 2.5 * (data{19}(400:1200, 12) / 350);
% plot(data{1}(400:1200,13), judgeTempXing)
% %plot(data{1}(400:1200,13),data{9}(400:1200, 11))
% %plot(data{1}(400:1200,13),data{9}(400:1200, 12))
% datetick('x','HH')
% legend('兴泰里','温度','日照')