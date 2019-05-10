%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%���ܣ���ʾ�������㷨�ڼ�����Ӿ��е�Ӧ��
%����C4.5������ʵ��ͼ���ֵ����
%������Win7��Matlab2012b
%Modi: NUDT-VAP
%ʱ�䣺2015-4-10
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


close all; clear; clc;
%% Step 1  ����ͼ��
Image = imread('flower_test.png');
Mask = imread('flower_mask.png');
figure; imshow(Image); title('Used Image');
figure; imshow(Mask); title('Used Mask');
% In the Mask:
%           Mask(i,j) = 0   -> class 0
%           Mask(i,j) = 255 -> class 1
%           Mask(i,j) = 128 -> unknown
%% Step 2 ѡ��ѵ������
[M,N,L] = size(Image);
Data = reshape(Image,[M*N,3]);
pID = find(Mask==255);
nID = find(Mask==0);
pNum = size(pID,1);
nNum = size(nID,1);
% 
TrainData = [Data(pID,:);Data(nID,:)]';
TrainValue = [1*ones([pNum,1]);0*ones([nNum,1])]';
TrainNum = pNum + nNum;
%% Step 3 ѵ��
DivNum = 32;
TrainDataFeatures = uint8(TrainData/DivNum)+1;
Nbins = max(TrainDataFeatures(:));
inc_node = TrainNum*10/100;
discrete_dim = [Nbins,Nbins,Nbins];
tree = BuildC45Tree(TrainDataFeatures, TrainValue, inc_node, discrete_dim, max(discrete_dim));
%% Step 4 ����
TestDataFeatures = uint8(Data'/DivNum)+1;
targets = UseC45Tree(TestDataFeatures, 1:M*N, tree, discrete_dim, unique(TrainValue));
Results = reshape(targets,[M,N]);
% 
figure; imshow(Results,[]); title('C4.5 Classification Results')