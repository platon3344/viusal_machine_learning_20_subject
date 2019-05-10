%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%���ܣ���ʾKmeans�����㷨�ڼ�����Ӿ��е�Ӧ��
%ʵ���������Kmeans����ʵ��ͼ��ķָ
%������Win7��Matlab2012b
%Modi: NUDT-VAP
%ʱ�䣺2014-10-17
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function kmeans_demo1()
clear;close all;clc;
%% ��ȡ����ͼ��
im = imread('city.jpg');
imshow(im), title('Imput image');
%% ת��ͼ�����ɫ�ռ�õ�����
cform = makecform('srgb2lab');
lab = applycform(im,cform);
ab = double(lab(:,:,2:3));
nrows = size(lab,1); ncols = size(lab,2);
X = reshape(ab,nrows*ncols,2)';
figure, scatter(X(1,:)',X(2,:)',3,'filled');  box on; %��ʾ��ɫ�ռ�ת����Ķ�ά�����ռ�ֲ�
%print -dpdf 2D1.pdf
%% �������ռ����Kmeans����
k = 5; % �������
max_iter = 100; %����������

[centroids, labels] = run_kmeans(X, k, max_iter); 

%% ��ʾ����ָ���
figure, scatter(X(1,:)',X(2,:)',3,labels,'filled'); %��ʾ��ά�����ռ����Ч��
hold on; scatter(centroids(1,:),centroids(2,:),60,'r','filled')
hold on; scatter(centroids(1,:),centroids(2,:),30,'g','filled')
box on; hold off;
%print -dpdf 2D2.pdf

pixel_labels = reshape(labels,nrows,ncols);
rgb_labels = label2rgb(pixel_labels);
figure, imshow(rgb_labels), title('Segmented Image');
%print -dpdf Seg.pdf
end

function [centroids, labels] = run_kmeans(X, k, max_iter)
% �ú���ʵ��Kmeans����
% ���������
%                   XΪ������������dxN
%                   kΪ�������ĸ���
%                   max_iterΪkemans������������Ĵ���
% ���������
%                   centroidsΪ�������� dxk
%                   labelsΪ�����������

%% ����K-means++�㷨��ʼ����������
  centroids = X(:,1+round(rand*(size(X,2)-1)));
  labels = ones(1,size(X,2));
  for i = 2:k
        D = X-centroids(:,labels);
        D = cumsum(sqrt(dot(D,D,1)));
        if D(end) == 0, centroids(:,i:k) = X(:,ones(1,k-i+1)); return; end
        centroids(:,i) = X(:,find(rand < D/D(end),1));
        [~,labels] = max(bsxfun(@minus,2*real(centroids'*X),dot(centroids,centroids,1).'));
  end
  
%% ��׼Kmeans�㷨
  for iter = 1:max_iter
        for i = 1:k, l = labels==i; centroids(:,i) = sum(X(:,l),2)/sum(l); end
        [~,labels] = max(bsxfun(@minus,2*real(centroids'*X),dot(centroids,centroids,1).'),[],1);
  end
  
end


