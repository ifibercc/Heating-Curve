% 一致性分析对比图
a = [
0.61
0.66
0.48
0.64
0.59
0.55
0.57  
];

b = [
0.14
0.17
0.18
0.17
0.20
0.21
0.25 
];
plot(a,'--k','linewidth',2);
hold on 
plot(b,'k','linewidth',2)
legend('甲锅炉房','乙锅炉房')
xlabel('日期/天')
ylabel('一致性度量')
