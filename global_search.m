clc;
clear all;
%ƽ������
%%Ŀ�꺯����������������
M=3;
q=zeros(1,M);
Eb_N=zeros(1,M);
p=zeros(1,M);
U_map=zeros(1,M);
B_m=zeros(1,M);
P_m=zeros(1,M);
B_max=zeros(1,M);
P_max=zeros(1,M);
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
P_total=10;

L=50; %��������
t=0;
U_max=zeros(1,L*L*L*L);
for a1=1:1:L
    for b1=1:1:L
        for c1=1:1:L
            for d1=1:1:L
              B_m(1)=(a1*0.9*B_total)/L;
              P_m(1)=(b1*0.9*P_total)/L;
              B_m(2)=(c1*0.9*(B_total-B_m(1)))/L;
              P_m(2)=(d1*0.9*(P_total-P_m(1)))/L;
              B_m(3)=B_total-B_m(1)-B_m(2);
              P_m(3)=P_total-P_m(1)-P_m(2);
               for m=1:1:M
               q(m)=1-(alpha*(a*exp(b*B_m(m)*log2(1+P_m(m)*h(m)/N))).^beta+gamma); %ʧ����
               Eb_N(m)=mean(P_m(m)*h(m)/((log2(1+P_m(m)*h(m)/N))*N));%��һ�������
               p(m)=2*(1-1/sqrt(Modu))/(log2(sqrt(Modu)))*qfunc(sqrt(2*Eb_N(m)*(3*log2(sqrt(Modu))/(Modu-1))));%�����ʼ���
               U_map(m)=f(m).*(1-q(m)).*(1-p(m));
               end
               U_max(1,(a1-1)*L*L*L+(b1-1)*L*L+(c1-1)*L+d1)=sum(U_map);
               t=t+1
            end
        end
    end
end

[Maxv,Loca]=max(U_max);