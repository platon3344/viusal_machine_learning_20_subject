function [Rdx,RdX,RdXt,Rdy,RdY,RdYt] = plsrd(E0,F0,T,h)
%E0-��׼������Ա�������
%F0-��׼��������������
%T-�Ա���ϵͳ���ɷֵ÷�n��rankE0����
%h-���ڽ�ģ��ϣ�����н����������������ɷָ���
%Rdx-�����ɷֶ���ĳ�Ա����Ľ�������
%RdX-�����ɷֶ����Ա�����Ľ�������
%RdXt-ȫ�����ɷֶ��Ա�������ۻ���������
%Rdy-�����ɷֶ���ĳ������Ľ�������
%RdY-�����ɷֶ��������Ľ�������
%RdYt-ȫ�����ɷֶ����������ۻ���������

%--�ɷֶ��Ա���������������--
[nr,nx]=size(E0);
[nr,ny]=size(F0);
Rdx=zeros(nx,h);
t1=zeros(nr,1);
x1=zeros(nr,1);
for xj=1:nx
    for ti=1:h
        t1=T(:,ti);
        x1=E0(:,xj);
        cc=(corrcoef(t1,x1)).^2;
        Rdx(xj,ti)=cc(1,2);
    end
end
Rdx;
RdX=sum(Rdx)./nx;
RdXt=sum(RdX);
%--�ɷֶ���������������ķ���--
Rdy=zeros(ny,h);
y1=zeros(nr,1);
for yj=1:ny
    for ti=1:h
        t1=T(:,ti);
        y1=F0(:,yj);
        rr=(corrcoef(t1,y1)).^2;
        Rdy(yj,ti)=rr(1,2);
    end
end
Rdy;
RdY=sum(Rdy)./ny;
RdYt=sum(RdY);


















