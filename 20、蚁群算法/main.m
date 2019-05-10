%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%���ܣ���ʾ��Ⱥ�㷨�ڼ�����Ӿ��е�Ӧ��
%������Ⱥ�㷨ʵ��·���滮��
%������Win7��Matlab2012b
%Modi: NUDT-VAP
%ʱ�䣺2014-02-04
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



function [Alocation,Newbest,traceInfo]=aca_ant_colony_system %(InitOps);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%               ��Ⱥ�㷨��ʼ������ʼ                     %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% ���ⶨ�壺��ȡ����λ�����ꡢ����������  %%%%%%%%%
InitOps=[];
[Location,DistMatrix,Ncities,Bestx,Lengx] = pr76init(InitOps); 
close all;
figure (1);
hold on;
minx=min(DistMatrix(:,1));
maxx=max(DistMatrix(:,1));
miny=min(DistMatrix(:,2));
maxy=max(DistMatrix(:,2));
minm=min(minx,miny);
maxm=max(maxx,maxy);
l=(maxm-minm)/10;
for i=1:Ncities
    plot(Location(i,1),Location(i,2),'*b');
    text (Location(i,1)+l,Location(i,2)+l,num2str(i));
end
for i=1:Ncities-1
    line([Location(Bestx(i),1),Location(Bestx(i+1),1)] , [Location(Bestx(i),2),Location(Bestx(i+1),2)]) ;
end
line([Location(Bestx(1),1),Location(Bestx(Ncities),1)] , [Location(Bestx(1),2),Location(Bestx(Ncities),2)]) ;
grid on,title(['��ʼ·��ͼ-',num2str(Lengx)]),xlabel('������'),ylabel('������');
legend('����λ��');
hold off ;
% ��ʼ�����������״̬
rand('state',sum(100*clock));

% ================================================
% ʹ������ڷ�����һ����ʼ����,���ݴ˼�����Ϣϵ��ֵ
    p=zeros(1,Ncities+1);
    p(1)=round(Ncities*rand+0.5);% p�洢Ŀǰ�ҵ������г��еı��
    i=p(1);
    count=2;
	while count <= Ncities
     	NNdist= inf ;%NNdist�洢Ŀǰ�ҵ��ĺ͵�ǰ���о�����̵ĳ��еľ���
     	pp= i ;% i�洢��ǰ���еı�� pp�洢Ŀǰ�ҵ��ĳ��б��
     	for j= 1: Ncities
          	if (DistMatrix(i, j) < NNdist) & (j~=i) & ((j~=p) == ones(1,length(p)))
                % Ŀ����е�Ҫ��Ϊ��������̡��Ҳ����ǵ�ǰ���У�Ҳ��������ǰ�Ѿ��߹��ĳ���
                NNdist= DistMatrix(i, j) ; 
                pp= j ;
          	end           
     	end
     	p(count)=pp; 
        i= pp ;
     	count= count + 1 ;
	end
    p=AcatspEval(p,DistMatrix,Ncities);
    len=p(1,Ncities+1);
	Q0=1/(Ncities*len);
%%%%%%%%%%               �趨ϵͳ�йز���           %%%%%%%%%%
MaxNc=5000;% ������
A=1;% ��Ϣ������
B=2;% ������Ϣ����
P1=0.1;% �ֲ��ӷ�ϵ����ֵ
P2=0.1;% ȫ�ֻӷ�ϵ����ֵ
R0=0.9; %ѡ�����
M=10;% ��������
%%%%%%%%%%   ��ʼ����Ϣ�ء�������Ϣ����ȷ���������λ�ü��������    %%%%%%%%%%
Pheromone=Q0*ones(Ncities,Ncities);% ��Ϣ�س�ʼ����;
Heuristic=1./DistMatrix;% ������Ϣ��ʼ����
Temp=ones(1,Ncities);
Heuristic=1./(1./Heuristic+diag(Temp));
RandL=round(rand(M,1)*Ncities+0.5);%�������λ��
Alocation0=zeros(M,Ncities+1);% ���M+1������������·�������Ⱦ����ʼ��
Alocation0(:,1)=RandL;
Allow0=repmat(1:Ncities,M,1);% ������ʵĳ��о����ʼ��
for Ak=1:M
    Allow0(Ak,RandL(Ak))=0;
end
%%%%%%%%%%                ���в�����ʼ��             %%%%%%%%%%
Nc=1;% ��һ��
Lbestdis=inf;
Cbestdis=inf;
Fnewbest=0;
Alocation=Alocation0;% ��Ÿ�����������·�������Ⱦ����ʼ��
Allow=Allow0; % ������󸳳�ֵ
t1=clock;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%               ��Ⱥ�㷨��ʼ���������                     %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                  ��Ⱥ�㷨��ѭ����ʼ                      %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

while(Nc<=MaxNc)
   
      % M������ѡ��Ncities������
      for Cityi=2:Ncities+1
          if Cityi<Ncities+1 
              for Ak=1:M
                  i=Alocation(Ak,Cityi-1);% ��ǰ����
                  j=Select_for_aca(R0,Ak,i,Allow,A,B,Pheromone,Heuristic);% ����Pijѡ����һ������j
                  Alocation(Ak,Cityi)=j;
                  Allow(Ak,j)=0;% �����������
                  Pheromone(i,j)=(1-P1)*Pheromone(i,j)+P1*Q0;      % ��Ϣ�����ߵ�������
                  Pheromone(j,i)= Pheromone(i,j);
               end
           else % ���س�������
              for Ak=1:M
                  i=Alocation(Ak,Cityi-1);% ��ǰ����
                  j=Alocation(Ak,1);
                  Pheromone(i,j)=(1-P1)*Pheromone(i,j)+P1*Q0;      % ��Ϣ�����ߵ�������
                  Pheromone(j,i)=Pheromone(i,j);
               end
           end
      end
      
      % ����ÿ�������ҵ���·���ĳ���

      for Ak=1:M
           Alocation(Ak,:)=AcatspEval(Alocation(Ak,:),DistMatrix,Ncities);% ������Ӧֵ��ÿ�������ҵ���·������
      end
      
      % �������š�����;
      t2=clock;
      t=etime(t2,t1);
      [Cbestdis,Am]=min(Alocation(1:M,Ncities+1));
      Cbest=Alocation(Am,:);
      % �����������ֵ
      traceInfo(Nc,1)=Nc; 		          %current generation
      traceInfo(Nc,2)= Cbest(Ncities+1);       %Best fittness
      traceInfo(Nc,3)=mean(Alocation(:,Ncities+1));     %Avg fittness
      traceInfo(Nc,4)=std(Alocation(:,Ncities+1)); %�����׼����
      if (Cbestdis<Lbestdis)||(Nc==1)
         Fnewbest=Fnewbest+1;
         Newbest(Fnewbest,1)=Nc;
         Newbest(Fnewbest,2)=t;
         Newbest(Fnewbest,3:Ncities+3)=Cbest;
         Lbest=Cbest;
         Lbestdis=Cbest(Ncities+1);
      end
      
      % ��Ϣ������ȫ�ָ���
      
      Iindex=Lbest(1:Ncities);
      Jindex=[Lbest(2:Ncities) Lbest(1)];
      for k=1:Ncities
          Pheromone(Iindex(k),Jindex(k))=(1-P1)*Pheromone(Iindex(k),Jindex(k))+P2*(1./Lbest(Ncities+1));%������·���ϵ���Ϣ������
          Pheromone(Jindex(k),Iindex(k))=Pheromone(Iindex(k),Jindex(k));
      end
      
      RandL=Alocation(:,Ncities);
      Alocation=zeros(M,Ncities+1);% ���M+1������������·�������Ⱦ����ʼ��
      Alocation(:,1)=RandL;
      Allow=repmat(1:Ncities,M,1);% ������ʵĳ��о����ʼ��
      for Ak=1:M
          Allow(Ak,RandL(Ak))=0;
      end
      Nc=Nc+1;
  end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                  ��Ⱥ�㷨��ѭ������                      %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                 ��Ⱥ�㷨���ģ�鿪ʼ                     %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ��ͼ�η�ʽ��ʾ���н����ʼ %%

%figure(1);
%hold on;
%plot ( traceInfo (: , 1) , traceInfo (: , 2) ) ;
%grid on,title('��������'),xlabel('����'),ylabel('���Ÿ�����Ӧֵ');
%legend('���Ÿ�����Ӧֵ');
%hold off;

%figure(2);
%hold on;
%plot( traceInfo (: , 1) , traceInfo (: , 3) ) ;
%grid on,title('��������'),xlabel('����'),ylabel('ƽ����Ӧֵ');
%legend('ƽ����Ӧֵ');
%hold off;

figure(2);
hold on;
plot( Newbest (: , 1) , Newbest (: , Ncities+3) ) ;
grid on,title('ȫ�����Ž�仯'),xlabel('����'),ylabel('ȫ�����Ž���Ӧ��');
legend('ȫ�����Ž���Ӧ��');
hold off;

figure (3);
Gbest=Newbest(Fnewbest,:);
hold on;
minx=min(DistMatrix(:,1));
maxx=max(DistMatrix(:,1));
miny=min(DistMatrix(:,2));
maxy=max(DistMatrix(:,2));
minn=min(minx,miny);
maxx=max(maxx,maxy);
l=(maxx-minn)/100;
for i=1:Ncities
    plot(Location(i,1),Location(i,2),'*b');
    text (Location(i,1)+l,Location(i,2)+l,num2str(i));
end
for i=3:Ncities+1
    line([Location(Gbest(i),1),Location(Gbest(i+1),1)] , [Location(Gbest(i),2),Location(Gbest(i+1),2)]) ;
end
line([Location(Gbest(3),1),Location(Gbest(Ncities+2),1)] , [Location(Gbest(3),2),Location(Gbest(Ncities+2),2)]) ;
grid on,title(['ȫ�����Ž�·��ͼ-',num2str(Lbestdis)]),xlabel('������'),ylabel('������');
legend('����λ��');

hold off ;
%% ��ͼ�η�ʽ��ʾ���н����ʼ %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



