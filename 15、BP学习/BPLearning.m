%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ����:��ʾBP�㷨�ڼ�����Ӿ��е�Ӧ��
% ����BP�㷨ѵ��������ʵ��Ŀ�����
%������Win7��Matlab2012b
% Modi:NUDT-VAP
% ʱ��:2014-10-10
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% load training data
clear all;
data = load('mnist.mat');
train_x = double(data.train_x) / 255;
train_y = double(data.train_y);
test_x  = double(data.test_x) / 255;
test_y  = double(data.test_y);
clear('data');

%% NN train
input_dim           = size(train_x, 2);
output_dim          = size(train_y, 2);
hidden_sz           = 100;
nn.sizes            = [input_dim, hidden_sz, output_dim];
nn.n                = numel(nn.sizes);
nn.learning_rate    = 0.1;
nn.momentum         = 0.5;

opts.numepochs      = 2;
opts.batchsize      = 100;

rng('default');
for i = 1:nn.n - 1
    nn.W{i}  = (rand(nn.sizes(i+1), nn.sizes(i)+1) - 0.5) * 2 * 4 * sqrt(6 / (nn.sizes(i+1) + nn.sizes(i)));
    nn.vW{i} = zeros(size(nn.W{i}));
end
disp('Start to train NN using BP');
nn = nntrain(nn, train_x, train_y, opts);

%% NN test
disp('Start to test NN:');
[err_rate, err_num] = nntest(nn, test_x, test_y);
% With 2 epochs, the error rate: could be around 10%.
disp(['Final classification error rate: ' num2str(err_rate*100), '%.']);
