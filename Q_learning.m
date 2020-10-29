%% 多智能体分布式Q-Learning
function [Q,U_map,U_maxv,action_all]=Q_learning(M,status_num,action_num,iter_num,B_total,P_total)
%% 矩阵初始化，分配内存空间
Q=zeros(status_num,action_num,M,iter_num);
action=zeros(M,2,10000);
action_select=zeros(M,2);
action_all=zeros(M,2,iter_num);
U_map=zeros(1,iter_num);
U_maxv=zeros(1,iter_num);
%% 循环迭代过程
for t=1:iter_num
  if (t==1) %首次迭代不用比大小，直接填充Q值表
    [action]=Action_space(M,B_total,P_total);
    [action_select]=Action(M,Q,t,B_total,P_total);
    action_all(:,:,t)=action_select;
    U_map(1,t)=Allocation(M,action_select,B_total,P_total);
%     for i=1:M
        a=action_select(:,:);
        A=action(:,:,:);
        %寻找当前动作所在动作空间的位置，并将其对应奖励值填到Q值表对应位置
        for j = 1:10000
            if (A(1,1,j)==a(1,1)&&action(1,2,j)==a(1,2))
                m=j;
            end
        end
        Q(1,m,:,t)=U_map(t,1);
        U_maxv(1,t)=max(U_map);
%     end
  else %后面的迭代需要先比大小，在进行Q值表的更新
    [action_select]=Action(M,Q,t,B_total,P_total);
    action_all(:,:,t)=action_select;
    U_map(1,t)=Allocation(M,action_select,B_total,P_total);
%     for i=1:M
        Q(:,:,:,t)=Q(:,:,:,t-1);
        a=action_select(:,:);
        A=action(:,:,:);
        %寻找当前动作所在动作空间的位置，并将其对应奖励值填到Q值表对应位置
        for j = 1:10000
            if (A(1,1,j)==a(1,1)&&A(1,2,j)==a(1,2))
                m=j;
            end
        end
        %如果新的精度大于之前的值，则更新Q值表
        if(U_map(1,t)>Q(1,m,:,t)) 
            Q(1,m,:,t)=U_map(1,t);
        end
        U_maxv(1,t)=max(U_map);
%     end
  end
end