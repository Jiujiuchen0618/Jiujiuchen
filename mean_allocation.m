clc;
clear all;
%平均分配
%%目标函数；（奖励函数）
M=3;
q=zeros(1,M);
Eb_N=zeros(1,M);
p=zeros(1,M);
U_map=zeros(1,M);
%% 参数设置
f=[0.9 0.4 0.1]; %内容重要性权重

%信息失真率 q
alpha=-4.247e-10;
beta=5.1;
gamma=0.9521;
a=45.96;
b=-8.648e-5;

%信息误码率 p
Modu=4;

%信道条件
h=[1 1 1]; %信道增益
N=0.1; %信道噪声

B_total=1000;
P_total=50;
B_m=zeros(1,M);
P_m=zeros(1,M);

for m = 1:1:M
    B_m(m)=B_total/M;
    P_m(m)=P_total/M;
    q(m)=1-(alpha*(a*exp(b*B_m(m)*log2(1+P_m(m)*h(m)/N))).^beta+gamma); %失真率
    Eb_N(m)=mean(P_m(m)*h(m)/((log2(1+P_m(m)*h(m)/N))*N));%归一化新造比
    p(m)=2*(1-1/sqrt(Modu))/(log2(sqrt(Modu)))*qfunc(sqrt(2*Eb_N(m)*(3*log2(sqrt(Modu))/(Modu-1))));%误码率计算
    U_map(m)=f(m).*(1-q(m)).*(1-p(m));
end

U_max=sum(U_map)