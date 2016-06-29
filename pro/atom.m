clear
close all
%% 加载数据
dataset = cell(1, 20);
for i = 1 : 20
    dataset{i} = xlsread(['YongXing/atom/', num2str(i), '.xlsx']);
end
data=dataset{1};
jiachu = data(61:901,16);
yichu = data(61:901,17);

plot(data(61:901,13),jiachu)
hold on
plot(data(61:901,13),yichu)

datetick('x','HH')
xlabel('日期/天')
ylabel('温度/^oC')