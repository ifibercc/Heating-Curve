clear
close all
%% ��������
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
xlabel('����/��')
ylabel('�¶�/^oC')