%% ��������ֲ�ʽQ-Learning
function [Q,U_map,U_maxv,action_all]=Q_learning(M,status_num,action_num,iter_num,B_total,P_total)
%% �����ʼ���������ڴ�ռ�
Q=zeros(status_num,action_num,M,iter_num);
action=zeros(M,2,10000);
action_select=zeros(M,2);
action_all=zeros(M,2,iter_num);
U_map=zeros(1,iter_num);
U_maxv=zeros(1,iter_num);
%% ѭ����������
for t=1:iter_num
  if (t==1) %�״ε������ñȴ�С��ֱ�����Qֵ��
    [action]=Action_space(M,B_total,P_total);
    [action_select]=Action(M,Q,t,B_total,P_total);
    action_all(:,:,t)=action_select;
    U_map(1,t)=Allocation(M,action_select,B_total,P_total);
%     for i=1:M
        a=action_select(:,:);
        A=action(:,:,:);
        %Ѱ�ҵ�ǰ�������ڶ����ռ��λ�ã��������Ӧ����ֵ�Qֵ���Ӧλ��
        for j = 1:10000
            if (A(1,1,j)==a(1,1)&&action(1,2,j)==a(1,2))
                m=j;
            end
        end
        Q(1,m,:,t)=U_map(t,1);
        U_maxv(1,t)=max(U_map);
%     end
  else %����ĵ�����Ҫ�ȱȴ�С���ڽ���Qֵ��ĸ���
    [action_select]=Action(M,Q,t,B_total,P_total);
    action_all(:,:,t)=action_select;
    U_map(1,t)=Allocation(M,action_select,B_total,P_total);
%     for i=1:M
        Q(:,:,:,t)=Q(:,:,:,t-1);
        a=action_select(:,:);
        A=action(:,:,:);
        %Ѱ�ҵ�ǰ�������ڶ����ռ��λ�ã��������Ӧ����ֵ�Qֵ���Ӧλ��
        for j = 1:10000
            if (A(1,1,j)==a(1,1)&&A(1,2,j)==a(1,2))
                m=j;
            end
        end
        %����µľ��ȴ���֮ǰ��ֵ�������Qֵ��
        if(U_map(1,t)>Q(1,m,:,t)) 
            Q(1,m,:,t)=U_map(1,t);
        end
        U_maxv(1,t)=max(U_map);
%     end
  end
end