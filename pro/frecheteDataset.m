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
frecheteDis = cell(1, 20);
for i = 1 : 20
    wanTemp    = data{i}(400:1200, 3);
    xingTemp   = data{i}(400:1200, 9);
    % 评价曲线，现在只是在0度的基础上+46度
    judageTemp = -data{i}(400:1200, 5) + 46;
    % 计算相应的Frechete Distance
    frecheteDis{i}(1) = DiscreteFrechetDist(wanTemp, judageTemp);
    frecheteDis{i}(2) = DiscreteFrechetDist(xingTemp, judageTemp);
end
%% 绘图
% 生成两种距离的数组
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
legend('万德庄', '兴泰里')