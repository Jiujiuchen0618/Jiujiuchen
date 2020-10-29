%% 车辆端动作选择
function [action_select] = Action(M,Q,t,B_total,P_total)
%% 矩阵初始化，分配内存空间
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
%% 循环迭代过程
if (t==1) %第一次迭代随机选择动作
%   for i=1:1:M
%       rand1=unidrnd(10);
%       rand2=unidrnd(10);
%       B_m(1,i)=action_B(i,rand1);
%       f_m(1,i)=action_f(i,rand2);
      rand_act=unidrnd(10000);
      action_select(:,:)=action(:,:,rand_act);    
%   end
else %之后的迭代根据贪婪策略选择动作
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
        [~,n]=find(a==max(a));%寻找最大Q值
        [~,col]=size(n);
        rand_col=unidrnd(col);
        num=n(1,rand_col);
        action_select(:,:)=action(:,:,num);
    end
end