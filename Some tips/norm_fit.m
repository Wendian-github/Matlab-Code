%% �ֲ���ϼ�����Ƶ�ʷֲ�ֱ��ͼ
x = randn(1000, 1);

% ��Ƶ�ʷֲ�ֱ��ͼ
[counts,centers] = hist(x, 7);
figure
bar(centers, counts / sum(counts))

% �ֲ��������
[mu,sigma]=normfit(x);

% ����֪�ֲ��ĸ����ܶ�����
x1 = -4:0.1:4;
y1 = pdf('Normal', x1, mu,sigma);
hold on
plot(x1, y1)
