function [sol] = AcatspEval(sol,distMatrix,numvars)
% ���ܣ�����������Ӧ��
% ���룺solһ������
% ������ø��弰����Ӧ��val

val = sum(diag(distMatrix(sol(1:numvars),[sol(2:numvars) sol(1)])));
sol(numvars+1)=val;
