close all
clear
x=1.5:0.001:2.1*pi;
y1=0.8*sin(0.8*x)+70;
y2=0.8*sin(0.8*x)+70.5;
y3=0.8*sin(0.8*x)+69.5;
y4=0.8*sin(0.8*x+0.5)+70;
y5=0.8*sin(0.8*x-0.5)+70;
plot(x,y1);
hold on
plot(x,y2);
plot(x,y3);
plot(x,y4);
plot(x,y5);

