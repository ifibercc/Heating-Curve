clear
close all
%读取数据
data1 = xlsread('d://article/heat/data/wanXing141215.xlsx');
data2 = xlsread('d://article/heat/data/wanXing141216.xlsx');
data3 = xlsread('d://article/heat/data/wanXing141217.xlsx');
data4 = xlsread('d://article/heat/data/wanXing141218.xlsx');
data5 = xlsread('d://article/heat/data/wanXing141219.xlsx');
%删除万德庄异常点
n21 = find(data1(:,2)<60);
n22 = find(data2(:,2)<60);
n23 = find(data3(:,2)<60);
n24 = find(data4(:,2)<60);
n25 = find(data5(:,2)<60);
data1(n21,:) = [ ];
data2(n22,:) = [ ];
data3(n23,:) = [ ];
data4(n24,:) = [ ];
data5(n25,:) = [ ];
%删除兴泰里异常点
n51 = find(data1(:,5)<60);
n52 = find(data2(:,5)<60);
n53 = find(data3(:,5)<60);
n54 = find(data4(:,5)<60);
n55 = find(data5(:,5)<60);
data1(n51,:) = [ ];
data2(n52,:) = [ ];
data3(n53,:) = [ ];
data4(n54,:) = [ ];
data5(n55,:) = [ ];
%计算最低维度
len = min([length(data1),length(data2),length(data3),length(data4),length(data5)]);
%计算五天的平均值
wanAve = (data1(1:len,2) + data2(1:len,2) + data3(1:len,2) + data4(1:len,2) + data5(1:len,2)) / 5;
xingAve = (data1(1:len,5) + data2(1:len,5) + data3(1:len,5) + data4(1:len,5) + data5(1:len,5)) / 5;
outAve = (data1(1:len,4) + data2(1:len,4) + data3(1:len,4) + data4(1:len,4) + data5(1:len,4)) / 5;
%绘图
plot(data1(1:len,8),smooth(wanAve))
hold on
plot(data1(1:len,8),smooth(xingAve))
plot(data1(1:len,8),smooth(outAve))
datetick('x','HH:MM')
xlabel('Time')
ylabel('Temp')
title('万德庄-兴泰里 2014-12-15日至2014-12-20日出口总管平均温度对比图')
legend('万德庄','兴泰里','室外温度')
