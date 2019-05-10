%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%���ܣ���ʾ��Ҷ˹ѧϰ�㷨�ڼ�����Ӿ��е�Ӧ��
%���ڱ�Ҷ˹ѧϰʵ��Ŀ����ࣻ
%������Win7��Matlab2012b
%Modi: NUDT-VAP
%ʱ�䣺2014-02-04
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%���ر�������������
load human;
load background;
%�������ѵ�������Ͳ�������
for j=1:10
    k_s=13;
    k_d=120;
    hm_tr(250,252)=0;
    hm_test(250,252)=0;
    [hm_tr,hm_test]=randQ(human);
    randQ(background);
    bg_tr(250,252)=0;
    bg_test(250,252)=0;
    [bg_tr,bg_test]=randQ(background);
    %�����С���ձ�Ҷ˹������
    M_hm=hm_tr(1,k_s:k_d);
    for i=2:250
        M_hm=M_hm+(hm_tr(i,k_s:k_d));
    end
    M_hm=M_hm/250;
    M_bg=bg_tr(1,k_s:k_d);
    for i=2:250
        M_bg=M_bg+(bg_tr(i,k_s:k_d));
    end
    M_bg=M_bg/250;
    E_hm(k_d-k_s+1,k_d-k_s+1)=0;
    E_bg(k_d-k_s+1,k_d-k_s+1)=0;
    for i=1:250
        E_hm=E_hm+(hm_tr(i,k_s:k_d)-M_hm)'*(hm_tr(i,k_s:k_d)-M_hm);
        E_bg=E_bg+(bg_tr(i,k_s:k_d)-M_bg)'*(bg_tr(i,k_s:k_d)-M_bg);
    end
    E_hm=E_hm/250;
    E_bg=E_bg/250;

    %�������
    %����о�����������
    flag_hm(250)=0;
    flag_bg(250)=0;
    for i=1:250
        dk_hm=log(0.5)+log(0.95)-log(abs(det(E_bg)))/2-((hm_test(i,k_s:k_d)-M_bg)*inv(E_bg)*(hm_test(i,k_s:k_d)-M_bg)')/2;
        dk_bg=log(1.5)+log(0.05)-log(abs(det(E_hm)))/2-((hm_test(i,k_s:k_d)-M_hm)*inv(E_hm)*(hm_test(i,k_s:k_d)-M_hm)')/2;
        if(dk_hm<=dk_bg)
            flag_hm(i)=1;
        else flag_hm(i)=0;
        end
    end
    s2_hm=sum(flag_hm);
    for i=1:250
        dk_hm=log(0.5)+log(0.95)-log(abs(det(E_bg)))/2-((bg_test(i,k_s:k_d)-M_bg)*inv(E_bg)*(bg_test(i,k_s:k_d)-M_bg)')/2;
        dk_bg=log(1.5)+log(0.05)-log(abs(det(E_hm)))/2-((bg_test(i,k_s:k_d)-M_hm)*inv(E_hm)*(bg_test(i,k_s:k_d)-M_hm)')/2;
        if(dk_hm>dk_bg)
            flag_bg(i)=1;
        else
            flag_bg(i)=0;
        end
    end
    %ͳ�Ʒ�����
    s2_bg=sum(flag_bg);
    err_hg(j)=(250-s2_hm)/250;
    err_gh(j)=(250-s2_bg)/250;
end
ERR_HG=0;
ERR_GH=0;

for j=1:10
    ERR_HG=ERR_HG+err_hg(j);
    ERR_GH=ERR_GH+err_gh(j);
end
ERR_HG=ERR_HG/10;
ERR_GH=ERR_GH/10;
    


