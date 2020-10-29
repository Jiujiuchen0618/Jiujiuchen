%% ������ʼ��
clear all;
clc;
tic
M=3;
B_total=1000; %kHz
P_total=10; %dBm

N=100; %���ؿ���������
Reward=zeros(1,N);
P_allo=zeros(M,N);
F_allo=zeros(M,N);
for n=1:1:N
%% Qֵ���������
Counter=n
status_num=1;
action_num=10000;
iter_num=500;
[Q,U_map,U_maxv,action_all]=Q_learning(M,status_num,action_num,iter_num,B_total,P_total);

%% ��ȡ�����������Ӧ�Ķ���
U_max=max(U_map);
[~,index]=find(U_map==U_max);
[~,col]=size(index);
rand=unidrnd(col);
num=index(1,rand);
action_max=action_all(:,:,num);
F_allo(:,n)=action_max(:,1);
P_allo(:,n)=action_max(:,2);
Reward(n)=U_max;
end
R=mean(Reward);
F=[mean(F_allo(1,:));mean(F_allo(2,:));mean(F_allo(3,:));];
P=[mean(P_allo(1,:));mean(P_allo(2,:));mean(P_allo(3,:));];
toc