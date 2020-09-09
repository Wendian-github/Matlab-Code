%% I. ��ջ�������
clear; clc; close all
%% II. Generate training / testing data
%%
% 1. load data
NIR = ''
octane = ''
%%
% % 2. �������ѵ�����Ͳ��Լ�
temp = randperm(size(NIR,1));
% ѵ��������50������
P_train = NIR(temp(1:50),:)';
T_train = octane(temp(1:50),:)';
% ���Լ�����10������
P_test = NIR(temp(51:end),:)';
T_test = octane(temp(51:end),:)';
N = size(P_test,2);

%% III. ���ݹ�һ��
[p_train, p] = mapminmax(P_train,0,1);  % or mapstd
p_test = mapminmax('apply',P_test,p);

[t_train, p_t] = mapminmax(T_train,0,1);

%% IV. BP�����紴����ѵ�����������
%%
% 1. ��������
net = newff(p_train,t_train,19); % random input weight and output weight
% view(net) 
%%
% 2. ����ѵ������
net.trainParam.epochs = 1000; % iterations
net.trainParam.goal = 1e-3; % mse 
net.trainParam.lr = 0.01; % learning rate 

%%
% 3. ѵ������
net = train(net,p_train,t_train);

%%
% 4. �������
y_test = sim(net,p_test);

%%
% 5. ���ݷ���һ��
y_test = mapminmax('reverse', y_test, p_t);

%% V. ��������
%%
% 1. MSE
MSE = mean(sum((T_test - y_test).^2))

%%
% 2. ����ϵ��R^2
% R2 = (N * sum(T_sim .* T_test) - sum(T_sim) * sum(T_test))^2 / ((N * sum((T_sim).^2) - (sum(T_sim))^2) * (N * sum((T_test).^2) - (sum(T_test))^2)); 
R = corrcoef(y_test, T_test);
R2 = R(1, 2) ^ 2;
clear R
%%
% 3. ����Ա�
% result = [T_test' T_sim' MSE']

%% VI. ��ͼ
figure
h1 = plot(T_test, y_test, 'o');
hold on 
h2 = plot([0.005 1], [0.005 1], '-r', 'linewidth', 1.2);
xlabel('a(555) m^{-1}', 'fontsize', 12)
ylabel('Estimated a(555) m^{-1}', 'fontsize', 12)
string = {['R^2=' num2str(R2) ' MSE=' num2str(MSE)]};
title(string)
set(gca, 'xlim', [0.005 0.8], 'ylim', [0.005 0.8], 'fontsize', 11, 'linewidth', 1.2)
disp({['R^2=' num2str(R2)] ['MSE=' num2str(MSE)]});
legend(h2, '1 : 1', 'edgecolor', 'w')

