function X0 = stand(X)
% STAND�����ݾ���X���н��б�׼�����������׼������X0
% X��ԭʼ���ݾ���X0�Ǳ�׼��������ݾ���
zeros(size(X));
[nr,nx]=size(X);
for mk=1:nr
X0(mk,:)=(X(mk,:)-mean(X))./std(X);
end