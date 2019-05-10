function RA = plsra(T,R,F0,rankE0)
%PLSRA������ɷֵ��ۻ����ⶨϵ��
%RA=plsra(T,R,F0,rankE0)
%T���Ա���ϵͳ���ɷֵ÷�N��rankE0����
%R��������غ���q��rankE0����
%F0���������׼������������n��q����
%rankE0-plspcr��ȡ�����ɷָ���

RAAA=[];
for byk=1:rankE0
    RAbyk=sum(norm(T(:,byk)).^2*norm(R(:,byk)).^2)./(norm(F0))^2;
    RAAA=[RAAA,RAbyk];
end
RA=cumsum(RAAA);
    
