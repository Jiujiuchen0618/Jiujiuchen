%% ���������ռ�
function [action] = Action_space(M,B_total,P_total)
%% �����ʼ���������ڴ�ռ�
action=zeros(M,2,10000);
action_B=zeros(M,100);
action_P=zeros(M,100);

%% Ƶ�׺͹��ʷ���
%% ��һ���û�
B_user=B_total;
P_user=P_total;
for j = 1:1:10
    for k = 1:1:10
    action_B(1,k+(j-1)*10)=0.09*j*B_user;
    action_P(1,k+(j-1)*10)=0.09*j*P_user;
    end
end
%% �ڶ����û��͵������û�
for j = 1:1:10
    for k = 1:1:10
    action_B(2,k+(j-1)*10)=0.09*k*(B_total-action_B(1,1+(j-1)*10));
    action_B(3,k+(j-1)*10)=B_total-action_B(1,1+(j-1)*10)-action_B(2,k+(j-1)*10);
    action_P(2,k+(j-1)*10)=0.09*k*(P_total-action_P(1,1+(j-1)*10));
    action_P(3,k+(j-1)*10)=P_total-action_P(1,1+(j-1)*10)-action_P(2,k+(j-1)*10);
    end
end

%% �������
for i = 1:1:M
    for j = 1:1:100
        for k = 1:1:100
            action(i,:,k+(j-1)*100)=[action_B(i,j),action_P(i,k)];
        end
    end
end
    