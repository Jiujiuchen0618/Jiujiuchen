clc;
clear all;
%P=10,B�������������Ӱ�죻
B=[1000 2000 3000 4000 5000];
QL=[1.2723 1.3053 1.3185 1.3248 1.3288]; %Q-learning�㷨����
GS=[1.2734 1.3063 1.3199 1.3266 1.3299]; %��������㷨
MA=[1.2483 1.2929 1.3139 1.3238 1.3285]; %ƽ�������㷨
% UB=[1.4 1.4 1.4 1.4 1.4]; %�Ͻ�
%B=1000,P�������������Ӱ�죻
P=[10 20 30 40 50];
QL2=[1.2723 1.2814 1.2864 1.2901 1.2924]; %Q-learning�㷨����
GS2=[1.2734 1.2829 1.2875 1.2904 1.2925]; %��������㷨
MA2=[1.2483 1.2598 1.2658 1.2697 1.2726]; %ƽ�������㷨

figure(1)
hold on;
grid on;
box on;
plot(B,GS,'k-','linewidth',2)
plot(B,QL,'r-*','linewidth',2,'Markersize',6)
plot(B,MA,'b-','linewidth',2)
% plot(B,UB)
axis([1000 5000 1.24 1.34])
xlabel('Total bandwidth (kHz)')
ylabel('Reward')
legend('G-search based','Q-learning based','Mean-allocation based','location','southeast')

figure(2)
hold on;
grid on;
box on;
plot(P,GS2,'k-','linewidth',2)
plot(P,QL2,'r-*','linewidth',2,'Markersize',6)
plot(P,MA2,'b-','linewidth',2)
% plot(B,UB)
axis([10 50 1.2 1.3])
xlabel('Total power (dBm)')
ylabel('Reward')
legend('G-search based','Q-learning based','Mean-allocation based','location','southeast')