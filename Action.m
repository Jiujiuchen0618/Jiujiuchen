%% �����˶���ѡ��
function [action_select] = Action(M,Q,t,B_total,P_total)
%% �����ʼ���������ڴ�ռ�
iter_num=5000;
if t<(iter_num/4)
    epsilon=0.80;
else
  if t>=(iter_num/4) && t<(2*iter_num/4)
    epsilon=0.9;
  else
    if t>=(2*iter_num/4) && t<(3*iter_num/4)
    epsilon=0.95;
    else
    epsilon=1;
    end
  end
end
action_select=zeros(M,2);
[action]=Action_space(M,B_total,P_total);
%% ѭ����������
if (t==1) %��һ�ε������ѡ����
%   for i=1:1:M
%       rand1=unidrnd(10);
%       rand2=unidrnd(10);
%       B_m(1,i)=action_B(i,rand1);
%       f_m(1,i)=action_f(i,rand2);
      rand_act=unidrnd(10000);
      action_select(:,:)=action(:,:,rand_act);    
%   end
else %֮��ĵ�������̰������ѡ����
%   for i=1:1:M
    rand=unifrnd(0,1);
    if rand>epsilon
%         rand1=unidrnd(10);
%         rand2=unidrnd(10);
%         B_m(1,i)=action_B(i,rand1);
%         f_m(1,i)=action_f(i,rand2);
        rand_act=unidrnd(10000);
        action_select(:,:)=action(:,:,rand_act); 
    else
        a=Q(1,:,:,t-1);
        [~,n]=find(a==max(a));%Ѱ�����Qֵ
        [~,col]=size(n);
        rand_col=unidrnd(col);
        num=n(1,rand_col);
        action_select(:,:)=action(:,:,num);
    end
end