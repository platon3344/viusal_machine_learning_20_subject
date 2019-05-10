function SCOEFF = pls(h,p,W,P,R)
%PLS��ƫ��С���˷��ع鷽�̵�ϵ��
%SCOEFF = pls(h,p,W,P,R)
%h-���ڽ�ģ�����ɷָ���
%p-�Ա�������
%W-ģ��ЧӦȨ��p��rankE0����
%P-ģ��ЧӦ�غ���p��rankE0����
%R-������غ���q��rankE0����
%SCOEFF--ƫ��С���˷��ع鷽�̵�ϵ��p��q����

for byk=1:h
    if byk==1
        WX(:,byk)=W(:,byk);
        SCOEFF=WX(:,byk)*R(:,byk)';
    else
        I=eye(p);
        ww=eye(p);
        for bykbyk=1:byk-1
            ww=ww*(1-W(:,bykbyk)*P(:,bykbyk)');
        end
        WX(:,byk)=ww*W(:,byk);
    end
    SCOEEF=WX(:,byk)*R(:,byk)';
end
