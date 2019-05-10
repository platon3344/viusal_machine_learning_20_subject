function [W,C,T,U,P,R]=plspcr(E0,F0)
%PLSPCR��ȡPLS��ģ�������п��ܵ����ɷ�
%[W,C,T,U,P,R]=plspcr(E0,F0)
%E0-�Ա�����׼������������n��p����
%F0-�������׼������������n��p����
%W -ģ��ЧӦȨ��p��rankE0����
%C -�����Ȩ��q��rankE0����
%T -�Ա���ϵͳ���ɷֵ÷�n��rankE0����
%U -�����ϵͳ���ɷֵ÷�n��rankE0����
%P -ģ��ЧӦ�غ���p��rankE0����
%R -������غ���q��rankE0����

A=rank(E0);
W=[];
C=[];
T=[];
U=[];
P=[];
R=[];
for byk=1:A
%��ȡ���������ɷ�
EFFE=E0'*F0*F0'*E0;
FEEF=F0'*E0*E0'*F0;

[w,LAMBDA]=eigs(EFFE,1,'lm')
[c,LAMBDA]=eigs(FEEF,1,'lm')
t1=E0*w;
u1=F0*c;
W=[W,w];
C=[C,c];
T=[T,t1];
U=[U,u1];

%����в�
p1=(E0'*t1)/norm(t1)^2;
E1=E0-t1*p1';
E0=E1;
r1=(F0'*t1)/norm(t1)^2;
F1=F0-t1*r1';
F0=F1;
P=[P,p1];
R=[R,r1];
end















