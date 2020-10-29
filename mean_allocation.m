clc;
clear all;
%ƽ������
%%Ŀ�꺯����������������
M=3;
q=zeros(1,M);
Eb_N=zeros(1,M);
p=zeros(1,M);
U_map=zeros(1,M);
%% ��������
f=[0.9 0.4 0.1]; %������Ҫ��Ȩ��

%��Ϣʧ���� q
alpha=-4.247e-10;
beta=5.1;
gamma=0.9521;
a=45.96;
b=-8.648e-5;

%��Ϣ������ p
Modu=4;

%�ŵ�����
h=[1 1 1]; %�ŵ�����
N=0.1; %�ŵ�����

B_total=1000;
P_total=50;
B_m=zeros(1,M);
P_m=zeros(1,M);

for m = 1:1:M
    B_m(m)=B_total/M;
    P_m(m)=P_total/M;
    q(m)=1-(alpha*(a*exp(b*B_m(m)*log2(1+P_m(m)*h(m)/N))).^beta+gamma); %ʧ����
    Eb_N(m)=mean(P_m(m)*h(m)/((log2(1+P_m(m)*h(m)/N))*N));%��һ�������
    p(m)=2*(1-1/sqrt(Modu))/(log2(sqrt(Modu)))*qfunc(sqrt(2*Eb_N(m)*(3*log2(sqrt(Modu))/(Modu-1))));%�����ʼ���
    U_map(m)=f(m).*(1-q(m)).*(1-p(m));
end

U_max=sum(U_map)