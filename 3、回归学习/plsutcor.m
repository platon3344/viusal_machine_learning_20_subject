function cr=plsutcor(U,T) 
%PLSUTCOR����t1/u1ͼ�����������ߵ����ϵ��
%cr=plsutcor(U,T)
%U-�������ȡ�ĳɷ�
%T-�Ա�����ȡ�ĳɷ�
%cr-�Ա���������������ϵ��

u1=U(:,1);
t1=T(:,1);
ut=[u1,t1];
cr=corrcoef(ut)
plot(t1,u1,'o')
lsline
title('t1/u1ͼ')
xlabel('t1')
ylabel('u1')
