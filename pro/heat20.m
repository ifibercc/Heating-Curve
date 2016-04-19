clear
close all
%读取数据
data1 = xlsread('d://article/heat/data/201502/wanXing150202.xlsx');
data2 = xlsread('d://article/heat/data/201502/wanXing150203.xlsx');
data3 = xlsread('d://article/heat/data/201502/wanXing150204.xlsx');
data4 = xlsread('d://article/heat/data/201502/wanXing150205.xlsx');
data5 = xlsread('d://article/heat/data/201502/wanXing150206.xlsx');
data6 = xlsread('d://article/heat/data/201502/wanXing150209.xlsx');
data7 = xlsread('d://article/heat/data/201502/wanXing150210.xlsx');
data8 = xlsread('d://article/heat/data/201502/wanXing150211.xlsx');
data9 = xlsread('d://article/heat/data/201502/wanXing150212.xlsx');
data10 = xlsread('d://article/heat/data/201502/wanXing150213.xlsx');
data11 = xlsread('d://article/heat/data/201502/wanXing150216.xlsx');
data12 = xlsread('d://article/heat/data/201502/wanXing150217.xlsx');
data13 = xlsread('d://article/heat/data/201502/wanXing150218.xlsx');
data14 = xlsread('d://article/heat/data/201502/wanXing150219.xlsx');
data15 = xlsread('d://article/heat/data/201502/wanXing150220.xlsx');
data16 = xlsread('d://article/heat/data/201502/wanXing150223.xlsx');
data17 = xlsread('d://article/heat/data/201502/wanXing150224.xlsx');
data18 = xlsread('d://article/heat/data/201502/wanXing150225.xlsx');
data19 = xlsread('d://article/heat/data/201502/wanXing150226.xlsx');
data20 = xlsread('d://article/heat/data/201502/wanXing150227.xlsx');
%删除万德庄异常点
n21 = find(data1(:,2)<60);
n22 = find(data2(:,2)<60);
n23 = find(data3(:,2)<60);
n24 = find(data4(:,2)<60);
n25 = find(data5(:,2)<60);
n26 = find(data6(:,2)<60);
n27 = find(data7(:,2)<60);
n28 = find(data8(:,2)<60);
n29 = find(data9(:,2)<60);
n210 = find(data10(:,2)<60);
n211 = find(data11(:,2)<60);
n212 = find(data12(:,2)<60);
n213 = find(data13(:,2)<60);
n214 = find(data14(:,2)<60);
n215 = find(data15(:,2)<60);
n216 = find(data16(:,2)<60);
n217 = find(data17(:,2)<60);
n218 = find(data18(:,2)<60);
n219 = find(data19(:,2)<60);
n220 = find(data20(:,2)<60);
data1(n21,:) = [ ];
data2(n22,:) = [ ];
data3(n23,:) = [ ];
data4(n24,:) = [ ];
data5(n25,:) = [ ];
data6(n26,:) = [ ];
data7(n27,:) = [ ];
data8(n28,:) = [ ];
data9(n29,:) = [ ];
data10(n210,:) = [ ];
data11(n211,:) = [ ];
data12(n212,:) = [ ];
data13(n213,:) = [ ];
data14(n214,:) = [ ];
data15(n215,:) = [ ];
data16(n216,:) = [ ];
data17(n217,:) = [ ];
data18(n218,:) = [ ];
data19(n219,:) = [ ];
data20(n220,:) = [ ];
%删除兴泰里异常点
n51 = find(data1(:,5)<60);
n52 = find(data2(:,5)<60);
n53 = find(data3(:,5)<60);
n54 = find(data4(:,5)<60);
n55 = find(data5(:,5)<60);
n56 = find(data6(:,5)<60);
n57 = find(data7(:,5)<60);
n58 = find(data8(:,5)<60);
n59 = find(data9(:,5)<60);
n510 = find(data10(:,5)<60);
n511 = find(data11(:,5)<60);
n512 = find(data12(:,5)<60);
n513 = find(data13(:,5)<60);
n514 = find(data14(:,5)<60);
n515 = find(data15(:,5)<60);
n516 = find(data16(:,5)<60);
n517 = find(data17(:,5)<60);
n518 = find(data18(:,5)<60);
n519 = find(data19(:,5)<60);
n520 = find(data20(:,5)<60);
data1(n51,:) = [ ];
data2(n52,:) = [ ];
data3(n53,:) = [ ];
data4(n54,:) = [ ];
data5(n55,:) = [ ];
data6(n56,:) = [ ];
data7(n57,:) = [ ];
data8(n58,:) = [ ];
data9(n59,:) = [ ];
data10(n510,:) = [ ];
data11(n511,:) = [ ];
data12(n512,:) = [ ];
data13(n513,:) = [ ];
data14(n514,:) = [ ];
data15(n515,:) = [ ];
data16(n516,:) = [ ];
data17(n517,:) = [ ];
data18(n518,:) = [ ];
data19(n519,:) = [ ];
data20(n520,:) = [ ];
%计算最低维度
len = min([length(data1),length(data2),length(data3),length(data4),length(data5),length(data6),length(data7),length(data8),length(data9),length(data10)+length(data11),length(data12),length(data13),length(data14),length(data15),length(data16),length(data17),length(data18),length(data19),length(data20)]);
%计算五天的平均值
wanTemp = (data1(1:len,2) + data2(1:len,2) + data3(1:len,2) + data4(1:len,2) + data5(1:len,2)+data6(1:len,2) + data7(1:len,2) + data8(1:len,2) + data9(1:len,2) + data10(1:len,2)+data11(1:len,2) + data12(1:len,2) + data13(1:len,2) + data14(1:len,2) + data15(1:len,2) + data16(1:len,2) + data17(1:len,2) + data18(1:len,2) + data19(1:len,2) + data20(1:len,2)) / 20;
xingTemp = (data1(1:len,5) + data2(1:len,5) + data3(1:len,5) + data4(1:len,5) + data5(1:len,5)+data6(1:len,5) + data7(1:len,5) + data8(1:len,5) + data9(1:len,5) + data10(1:len,5) + data11(1:len,5) + data12(1:len,5) + data13(1:len,5) + data14(1:len,5) + data15(1:len,5)+data16(1:len,5) + data17(1:len,5) + data18(1:len,5) + data19(1:len,5) + data20(1:len,5)) / 20;
outTemp = (data1(1:len,4) + data2(1:len,4) + data3(1:len,4) + data4(1:len,4) + data5(1:len,4)+data6(1:len,4) + data7(1:len,4) + data8(1:len,4) + data9(1:len,4) + data10(1:len,4) + data11(1:len,4) + data12(1:len,4) + data13(1:len,4) + data14(1:len,4) + data15(1:len,4)+data16(1:len,4) + data17(1:len,4) + data18(1:len,4) + data19(1:len,4) + data20(1:len,4)) / 20;
outSun = (data1(1:len,9) + data2(1:len,9) + data3(1:len,9) + data4(1:len,9) + data5(1:len,9)+data6(1:len,9) + data7(1:len,9) + data8(1:len,9) + data9(1:len,9) + data10(1:len,9) + data11(1:len,9) + data12(1:len,9) + data13(1:len,9) + data14(1:len,9) + data15(1:len,9)+data16(1:len,9) + data17(1:len,9) + data18(1:len,9) + data19(1:len,9) + data20(1:len,9)) / 20;
%归一化
[wanTempOne] = mapminmax(wanTemp',0,1);
[xingTempOne] = mapminmax(xingTemp',0,1);
[outTempOne] = mapminmax(outTemp',0,1);
[outSunOne] = mapminmax(outSun',0,1);
%绘图
plot(data1(73:len,8),smooth(wanTempOne(73:len))) % 12:+4.65 02:+4.03
hold on
plot(data1(73:len,8),smooth(xingTempOne(73:len)))
plot(data1(73:len,8),smooth(1-outTempOne(73:len))) % 12:+72.884 02:+72.42
plot(data1(73:len,8),smooth(outSunOne(73:len)))
datetick('x','HH:MM')
xlabel('Time')
ylabel('Temp')
%title('万德庄-兴泰里 2014-12-01日至2014-12-30日出口总管平均温度对比图')
title('万德庄-兴泰里 2015-02-02日至2015-02-27日出口总管平均温度对比图')
legend('万德庄','兴泰里','室外温度','日照')
