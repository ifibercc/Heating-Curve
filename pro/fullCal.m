clear
close all
%% 读取数据
data1 = xlsread('../data/201502/full/wanXing150202.xlsx');
data2 = xlsread('../data/201502/full/wanXing150203.xlsx');
data3 = xlsread('../data/201502/full/wanXing150204.xlsx');
data4 = xlsread('../data/201502/full/wanXing150205.xlsx');
data5 = xlsread('../data/201502/full/wanXing150206.xlsx');
data6 = xlsread('../data/201502/full/wanXing150209.xlsx');
data7 = xlsread('../data/201502/full/wanXing150210.xlsx');
data8 = xlsread('../data/201502/full/wanXing150211.xlsx');
data9 = xlsread('../data/201502/full/wanXing150212.xlsx');
data10 = xlsread('../data/201502/full/wanXing150213.xlsx');
data11 = xlsread('../data/201502/full/wanXing150216.xlsx');
data12 = xlsread('../data/201502/full/wanXing150217.xlsx');
data13 = xlsread('../data/201502/full/wanXing150218.xlsx');
data14 = xlsread('../data/201502/full/wanXing150219.xlsx');
data15 = xlsread('../data/201502/full/wanXing150220.xlsx');
data16 = xlsread('../data/201502/full/wanXing150223.xlsx');
data17 = xlsread('../data/201502/full/wanXing150224.xlsx');
data18 = xlsread('../data/201502/full/wanXing150225.xlsx');
data19 = xlsread('../data/201502/full/wanXing150226.xlsx');
data20 = xlsread('../data/201502/full/wanXing150227.xlsx');
%% 检测异常点
% 3代表万德庄的出水温度，9代表兴泰里的出水温度
% isnan先检测出哪些点有空值，然后后再插入前后两个点的平均值
for i = 0:2
n31 = find(isnan(data1(:,3))); 
n32 = find(isnan(data2(:,3))); 
n33 = find(isnan(data3(:,3))); 
n34 = find(isnan(data4(:,3))); 
n35 = find(isnan(data5(:,3)));
n36 = find(isnan(data6(:,3))); 
n37 = find(isnan(data7(:,3))); 
n38 = find(isnan(data8(:,3))); 
n39 = find(isnan(data9(:,3))); 
n310 = find(isnan(data10(:,3))); 
n311 = find(isnan(data11(:,3)));
n312 = find(isnan(data12(:,3))); 
n313 = find(isnan(data13(:,3))); 
n314 = find(isnan(data14(:,3))); 
n315 = find(isnan(data15(:,3))); 
n316 = find(isnan(data16(:,3))); 
n317 = find(isnan(data17(:,3))); 
n318 = find(isnan(data18(:,3))); 
n319 = find(isnan(data19(:,3))); 
n320 = find(isnan(data20(:,3))); 

n91 = find(isnan(data1(:,9))); 
n92 = find(isnan(data2(:,9))); 
n93 = find(isnan(data3(:,9))); 
n94 = find(isnan(data4(:,9))); 
n95 = find(isnan(data5(:,9)));
n96 = find(isnan(data6(:,9))); 
n97 = find(isnan(data7(:,9))); 
n98 = find(isnan(data8(:,9))); 
n99 = find(isnan(data9(:,9))); 
n910 = find(isnan(data10(:,9))); 
n911 = find(isnan(data11(:,9)));
n912 = find(isnan(data12(:,9))); 
n913 = find(isnan(data13(:,9))); 
n914 = find(isnan(data14(:,9))); 
n915 = find(isnan(data15(:,9))); 
n916 = find(isnan(data16(:,9))); 
n917 = find(isnan(data17(:,9))); 
n918 = find(isnan(data18(:,9))); 
n919 = find(isnan(data19(:,9))); 
n920 = find(isnan(data20(:,9))); 
% 插入平均值，补足数据，更好的方式是用拉格朗日插值法
data1(n31,9)  = (data1(n31+1,9) + data1(n31 - 1,9))/2;
data2(n32,9)  = (data2(n32+1,9) + data1(n32 - 1,9))/2;
data3(n33,9)  = (data3(n33+1,9) + data1(n33 - 1,9))/2;
data4(n34,9)  = (data4(n34+1,9) + data1(n34 - 1,9))/2;
data5(n35,9)  = (data5(n35+1,9) + data1(n35 - 1,9))/2;
data6(n36,9) = (data6(n36+1,9) + data1(n36 - 1,9))/2;
data7(n37,9)  = (data7(n37+1,9) + data1(n37 - 1,9))/2;
data8(n38,9)  = (data8(n38+1,9) + data1(n38 - 1,9))/2;
data9(n39,9)  = (data9(n39+1,9) + data1(n39 - 1,9))/2;
data10(n310,9)  = (data10(n310+1,9) + data1(n310 - 1,9))/2;
data11(n311,9)  = (data11(n311+1,9) + data1(n311 - 1,9))/2;
data12(n312,9)  = (data12(n312+1,9) + data1(n312 - 1,9))/2;
data13(n313,9) = (data13(n313+1,9) + data1(n313 - 1,9))/2;
data14(n314,9)  = (data14(n314+1,9) + data1(n314 - 1,9))/2;
data15(n315,9)  = (data15(n315+1,9) + data1(n315 - 1,9))/2;
data16(n316,9) = (data16(n316+1,9) + data1(n316 - 1,9))/2;
data17(n317,9)  = (data17(n317+1,9) + data1(n317 - 1,9))/2;
data18(n318,9)  = (data18(n318+1,9) + data1(n318 - 1,9))/2;
data19(n319,9) = (data19(n319+1,9) + data1(n319 - 1,9))/2;
data20(n320,9)  = (data20(n320+1,9) + data1(n320 - 1,9))/2;

data1(n91,9)  = (data1(n91+1,9) + data1(n91 - 1,9))/2;
data2(n92,9)  = (data2(n92+1,9) + data1(n92 - 1,9))/2;
data3(n93,9)  = (data3(n93+1,9) + data1(n93 - 1,9))/2;
data4(n94,9)  = (data4(n94+1,9) + data1(n94 - 1,9))/2;
data5(n95,9)  = (data5(n95+1,9) + data1(n95 - 1,9))/2;
data6(n96,9) = (data6(n96+1,9) + data1(n96 - 1,9))/2;
data7(n97,9)  = (data7(n97+1,9) + data1(n97 - 1,9))/2;
data8(n98,9)  = (data8(n98+1,9) + data1(n98 - 1,9))/2;
data9(n99,9)  = (data9(n99+1,9) + data1(n99 - 1,9))/2;
data10(n910,9)  = (data10(n910+1,9) + data1(n910 - 1,9))/2;
data11(n911,9)  = (data11(n911+1,9) + data1(n911 - 1,9))/2;
data12(n912,9)  = (data12(n912+1,9) + data1(n912 - 1,9))/2;
data13(n913,9) = (data13(n913+1,9) + data1(n913 - 1,9))/2;
data14(n914,9)  = (data14(n914+1,9) + data1(n914 - 1,9))/2;
data15(n915,9)  = (data15(n915+1,9) + data1(n915 - 1,9))/2;
data16(n916,9) = (data16(n916+1,9) + data1(n916 - 1,9))/2;
data17(n917,9)  = (data17(n917+1,9) + data1(n917 - 1,9))/2;
data18(n918,9)  = (data18(n918+1,9) + data1(n918 - 1,9))/2;
data19(n919,9) = (data19(n919+1,9) + data1(n919 - 1,9))/2;
data20(n920,9)  = (data20(n920+1,9) + data1(n920 - 1,9))/2;
end
%% 数据处理
%计算二十天的平均值
% 
% wanTemp = (data1(:,3) + data2(:,3) + data3(:,3) + data4(:,3) + data5(:,3)+data6(:,3) + data7(:,3) + data8(:,3) + data9(:,3) + data10(:,3)+data11(:,3) + data12(:,3) + data13(:,3) + data14(:,3) + data15(:,3) + data16(:,3) + data17(:,3) + data18(:,3) + data19(:,3) + data20(:,3)) / 20;
% 
% xingTemp = (data1(:,9) + data2(:,9) + data3(:,9) + data4(:,9) + data5(:,9)+data6(:,9) + data7(:,9) + data8(:,9) + data9(:,9) + data10(:,9) + data11(:,9) + data12(:,9) + data13(:,9) + data14(:,9) + data15(:,9)+data16(:,9) + data17(:,9) + data18(:,9) + data19(:,9) + data20(:,9)) / 20;
% 
% outTemp = (data1(:,5) + data2(:,5) + data3(:,5) + data4(:,5) + data5(:,5)+data6(:,5) + data7(:,5) + data8(:,5) + data9(:,5) + data10(:,5) + data11(:,5) + data12(:,5) + data13(:,5) + data14(:,5) + data15(:,5)+data16(:,5) + data17(:,5) + data18(:,5) + data19(:,5) + data20(:,5)) / 20;
wanTemp = (data1(440:1440,3) + data2(440:1440,3) + data3(440:1440,3) + data4(440:1440,3) + data5(440:1440,3)+data6(440:1440,3) + data7(440:1440,3) + data8(440:1440,3) + data9(440:1440,3) + data10(440:1440,3)+data11(440:1440,3) + data12(440:1440,3) + data13(440:1440,3) + data14(440:1440,3) + data15(440:1440,3) + data16(440:1440,3) + data17(440:1440,3) + data18(440:1440,3) + data19(440:1440,3) + data20(440:1440,3)) / 20;

xingTemp = (data1(440:1440,9) + data2(440:1440,9) + data3(440:1440,9) + data4(440:1440,9) + data5(440:1440,9)+data6(440:1440,9) + data7(440:1440,9) + data8(440:1440,9) + data9(440:1440,9) + data10(440:1440,9) + data11(440:1440,9) + data12(440:1440,9) + data13(440:1440,9) + data14(440:1440,9) + data15(440:1440,9)+data16(440:1440,9) + data17(440:1440,9) + data18(440:1440,9) + data19(440:1440,9) + data20(440:1440,9)) / 20;

outTemp = (data1(440:1440,5) + data2(440:1440,5) + data3(440:1440,5) + data4(440:1440,5) + data5(440:1440,5)+data6(440:1440,5) + data7(440:1440,5) + data8(440:1440,5) + data9(440:1440,5) + data10(440:1440,5) + data11(440:1440,5) + data12(440:1440,5) + data13(440:1440,5) + data14(440:1440,5) + data15(440:1440,5)+data16(440:1440,5) + data17(440:1440,5) + data18(440:1440,5) + data19(440:1440,5) + data20(440:1440,5)) / 20;

% 评价曲线
judgeTemp = -outTemp + 46;
%outSun = (data1(1:len,9) + data2(1:len,9) + data3(1:len,9) + data4(1:len,9) + data5(1:len,9)+data6(1:len,9) + data7(1:len,9) + data8(1:len,9) + data9(1:len,9) + data10(1:len,9) + data11(1:len,9) + data12(1:len,9) + data13(1:len,9) + data14(1:len,9) + data15(1:len,9)+data16(1:len,9) + data17(1:len,9) + data18(1:len,9) + data19(1:len,9) + data20(1:len,9)) / 20;
%% 光滑数据
wanTempSmooth = smooth(wanTemp);
xingTempSmooth = smooth(xingTemp);
outTempSmooth = smooth(-outTemp);
judgeTempSmooth = smooth(judgeTemp);
%wanOutTempSmooth = smooth(wanTemp+outTemp);
%xingOutTempSmooth = smooth(xingTemp+outTemp);
%归零
% [topTemp,topIndex] = max(outTempSmooth);
% outTempFinal = outTempSmooth;
% wanTempFinal = wanTempSmooth - (wanTempSmooth(topIndex,1) - topTemp);
% xingTempFinal = xingTempSmooth - (xingTempSmooth(topIndex,1) - topTemp);
% wanOutTempFinal = wanOutTempSmooth - (wanOutTempSmooth(topIndex,1) - topTemp);
% xingOutTempFinal = xingOutTempSmooth - (xingOutTempSmooth(topIndex,1) - topTemp);
%% 归一化
wanTempOne = mapminmax(wanTempSmooth',0,1); 
xingTempOne = mapminmax(xingTempSmooth',0,1); 
outTempOne = mapminmax(outTempSmooth',0,1);
judgeTempOne = mapminmax(judgeTempSmooth', 0, 1);
%wanOutTempOne = mapminmax(wanOutTempSmooth',0,1); 
%xingOutTempOne = mapminmax(xingOutTempSmooth',0,1);

[topTemp,topIndex] = max(outTempOne);
outTempFinal = outTempOne;
%wanTempFinal = wanTempOne - (wanTempOne(1,topIndex) - topTemp);
%xingTempFinal = xingTempOne - (xingTempOne(1,topIndex) - topTemp);
wanTempFinal = wanTempOne;
xingTempFinal = xingTempOne;
judgeTempFinal = judgeTempOne;
%wanOutTempFinal = wanOutTempOne - (wanOutTempOne(1,topIndex) - topTemp);
%xingOutTempFinal = xingOutTempOne - (xingOutTempOne(1,topIndex) - topTemp);
%% Dicrete Frechet Distance
[cmWan, cSqWan] = DiscreteFrechetDist(wanTempFinal,judgeTempFinal);
[cmXing, cSqXing] = DiscreteFrechetDist(xingTempFinal,judgeTempFinal);
%[cmJudge, cSqJudge] = DiscreteFrechetDist(judgeTempFinal,outTempFinal);
%% 绘图
plot(data1(440:1440,13),wanTempFinal)
hold on
plot(data1(440:1440,13),xingTempFinal)
plot(data1(440:1440,13),judgeTempFinal) 
%plot(data1(:,13),wanOutTempFinal,'-.')
%plot(data1(:,13),xingOutTempFinal,'--')
%line([2 cmWan+2],[0.5 0.5],'color','m','linewidth',2)
%line([2 cmXing+2],[0.5 0.5],'color','m','linewidth',2)
datetick('x','HH')
xlabel('Time')
ylabel('Temp')
%title('万德庄-兴泰里 2015-02-02日至2015-02-27日出口总管平均温度对比图')
title(['万德庄' , num2str(cmWan) , '兴泰里' , num2str(cmXing)])
legend('万德庄','兴泰里','评价曲线')
grid on
set(get(gca,'Children'),'linewidth',1.5)