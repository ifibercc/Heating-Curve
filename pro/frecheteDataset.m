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
         data{i}(nullExWan{i}, 3)  = (data{i}(nullExWan{i} - 2, 3) + data{i}(nullExWan{i} + 2, 3)) / 2;
         data{i}(nullOutWan{i}, 5)  = (data{i}(nullOutWan{i} - 2, 5) + data{i}(nullOutWan{i} + 2, 5)) / 2;
         data{i}(nullSunWan{i}, 6)  = (data{i}(nullSunWan{i} - 2, 6) + data{i}(nullSunWan{i} + 2, 6)) / 2;         
         data{i}(nullExXing{i}, 9) = (data{i}(nullExXing{i} - 2, 9) + data{i}(nullExXing{i} + 2, 9)) / 2;
         data{i}(nullOutXing{i}, 11) = (data{i}(nullOutXing{i} - 2, 11) + data{i}(nullOutXing{i} + 2, 11)) / 2;
         data{i}(nullSunXing{i}, 12) = (data{i}(nullSunXing{i} - 2, 12) + data{i}(nullSunXing{i} + 2, 12)) / 2;

    end

%% 数据处理
wanFrecheteArr = zeros(1, 20);
xingFrecheteArr = zeros(1, 20);
wanDistArr = zeros(1, 20);
xingDistArr = zeros(1, 20);
judgeTempTest  = cell(1, 20);
varWan = zeros(1, 20);
varXing = zeros(1, 20);
varJudge = zeros(1, 20);
for i = 1 : 20
    wanTemp    = data{i}(400:1200, 3);
    xingTemp   = data{i}(400:1200, 9);
    % 评价曲线，气象仪各个地方用的是一个数据，通过采集仪器下发得到，兴泰里考虑了时间段
    %judgeTemp = [(-data{i}(400:976, 5) - 0.5); (-data{i}(977:1140, 5) - 6.9); (-data{i}(1141:1200, 5) - 1)] + 84;
    % 平滑减少供热计划
    d1 = 0.00174;
    for p1 = 0 : 577   
        data{i}(400 + p1, 5) = -data{i}(400 + p1, 5) + d1;
        if (p1 < 288)
            d1 = d1 + 0.00174;
        else
            d1 = d1 - 0.00174;
        end
    end
    d2 = 0.030331;
    % 0.042331;
    for p2 = 1 : 164   
        data{i}(977 + p2, 5) = -data{i}(977 + p2, 5) + d2;
        if (p2 < 82)
            d2 = d2 + 0.030331;
        else
            d2 = d2 - 0.030331;
        end
    end
    d3 = 0.016949;
    for p3 = 1 : 59   
        data{i}(1141 + p3, 5) = -data{i}(1141 + p3, 5) + d3;
        if (p3 < 30)
            d3 = d3 + 0.016949;
        else
            d3 = d3 - 0.016949;
        end
    end
    judgeTemp = data{i}(400:1200, 5) + 84;
    judgeTempTest{i} = judgeTemp;
% 方差
% varWan(i) = var(wanTemp);
% varXing(i) = var(xingTemp);
% varJudge(i) = var(judgeTemp);


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
%
% 温差
wanCha = 100 * rand(1,20);
xingCha = 10 * rand(1,20);
wanMatrix = [wanDistArr; wanFrecheteArr; wanCha]';
xingMatrix = [xingDistArr; xingFrecheteArr; xingCha]';
% bothMatrix = [wanMatrix; xingMatrix];
% 暂时利用K-means
%[u,re] = kmeans(bothMatrix, 2);
%% 复合度量计算
% wanMulti = 0.8 * (1 - wanFrecheteArr / 200) + 0.2 * (1 - wanDistArr / 400);
% xingMulti = 0.8 * (1 - xingFrecheteArr / 200) + 0.2 * (1 - xingDistArr / 400);
% 
% % 绘图
% plot3(wanMatrix(:, 1), wanMatrix(:, 2), wanMatrix(:, 3), '*');
% hold on
% plot3(xingMatrix(:, 1), xingMatrix(:, 2), xingMatrix(:, 3), 'o');
% %plot(u(:, 1), u(:, 2), 'Xg');
% grid on
% legend('A站', 'B站')
% title('A站与B站3月份的相似度、延时和温差分布图')
% xlabel('延时')
% ylabel('相似度')
% zlabel('温差')
%% 复合度量绘图
% plot(1:20, smooth(wanMulti * 100));
% hold on
% plot(1:20, smooth(xingMulti * 100));
% legend('A站', 'B站')
% xlabel('日期')
% ylabel('相似度（%）')
% title('A站和B站3月份出水温度与参考曲线相似度对比图')
% 
% 
% 参考曲线
i = 10;
%plot(data{1}(400:1200,13),data{i}(400:1200,3))

plot(data{1}(400:1200,13),smooth(data{i}(400:1200,9)), 'LineWidth',2)
hold on
plot(data{1}(400:1200,13),smooth(data{i+1}(400:1200,9))+2)
%plot(data{1}(400:1200,13), smooth(judgeTempTest{i})-10)
datetick('x','HH')
legend('A锅炉房出水温度','参考曲线')
title('A锅炉房某日出水温度曲线及其参考曲线')
xlabel('时间/H')
ylabel('温度/^oC')


% 方差图

% plot(1:20, varWan);
% hold on
% plot(1:20, varXing)
% plot(1:20, varJudge)
% legend('永基', '兴泰里', '参考曲线')
% title('20天方差')
