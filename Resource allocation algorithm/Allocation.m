%% 联合频谱资源和计算资源分配
function [U_total] = Allocation(M,action_select,B_total,P_total)
%目标函数；（奖励函数）
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

n0=-174; %信道噪声
N=10^(n0/10)*1000;
d=[0.3 0.3 0.3];
v=[0 0 0];


%将动作选择结果赋值给B_m和f_m
B_m=action_select(:,1)';
P_m=action_select(:,2)';

Ph=channel(M,P_m,d,v);


%% 判断边界条件并进行资源分配
if sum(B_m)>B_total||sum(P_m)>P_total
    U_map=0;
else
%目标函数；（奖励函数）

for m = 1:1:M
    q(m)=1-(alpha*(a*exp(b*B_m(m)*log2(1+Ph(m)/(N*B_m(m))))).^beta+gamma); %失真率
    Eb_N(m)=mean(Ph(m)/((log2(1+Ph(m)/(N*B_m(m))))*(N*B_m(m))));%归一化信噪比
    p(m)=2*(1-1/sqrt(Modu))/(log2(sqrt(Modu)))*qfunc(sqrt(2*Eb_N(m)*(3*log2(sqrt(Modu))/(Modu-1))));%误码率计算
    U_map(m)=f(m).*(1-q(m)).*(1-p(m));
end
end

U_total=sum(U_map);
