
%% A Linear Programming Approach to the Minimum Cost Sparsest Input Selectio for Structured Systems
%% Input: [As,Bs] is the sparsity pattern of the structured systems; k is the upper bound for input sparsity; the input does not need to satisfy the source-SCC grouped input constraint.  
%% Output: the selected input links in the optimal solution. 
%% See the example of Yuan Zhang, et.al  A Linear Programming Approach to the Minimum Cost Sparsest Input Selectio for Structured Systems.
%clear
k=100;
% As=[1     1     0     0     0     0
%      1     0     0     0     0     0
%      0     0     0     0     1     0
%      0     0     0     0     1     0
%      0     0     0     1     0     0
%      0     1     1     1     0     0];
%  Bs=[   1     1     0
%      1     0     1
%      1     0     1
%      0     0     0
%      0     0     1
%      0     0     0];
 
%  As=[    1     1     1
%      1     0     0
%      1     0     0];
% Bs=[1     1
%      1     1
%      1     0];
% As=[     0     1     0     0     0
%      1     0     1     0     0
%      0     1     0     1     1
%      0     1     1     0     0
%      0     0     1     0     0];
%  Bs=[0     0
%      1     0
%      1     1
%      0     1
%      0     0];
% As=[   0     1     0     0     0     0     0
%      1     0     1     1     0     0     0
%      0     1     0     0     0     0     0
%      0     1     0     0     1     1     1
%      0     0     0     1     0     0     0
%      0     0     0     1     0     0     0
%      0     0     0     1     0     0     0];
%  Bs=[1     1     0
%      0     0     0
%      0     0     1
%      0     0     0
%      1     0     0
%      0     0     1
%      0     0     0];

% As=[      0     1     0     0     0     0     0     0     0     0
%      0     0     1     0     0     0     0     0     0     0
%      1     1     0     0     0     0     0     0     0     0
%      0     0     0     0     0     1     0     0     0     0
%      0     0     0     1     0     1     0     0     0     0
%      0     0     0     0     1     0     0     0     0     0
%      0     0     1     0     0     0     0     1     0     0
%      0     0     0     0     0     1     0     0     0     0
%      0     0     0     0     0     0     1     0     0     0
%      0     0     0     0     0     0     0     1     0     0];
%  
%  Bs=[ 1     0     0     0     0     0
%      1     1     0     0     0     0
%      1     1     0     0     0     0
%      0     0     1     1     0     0
%      0     0     1     1     0     0
%      0     0     0     1     0     0
%      0     0     0     0     1     1
%      0     0     0     0     1     0
%      0     0     0     0     0     1
%      0     0     0     0     0     1];
%  As=[      0     0     1     0     0     0     0
%      1     0     0     0     0     0     0
%      0     0     0     0     0     0     1
%      0     1     0     0     0     0     0
%      1     0     0     0     0     0     0
%      0     0     1     0     0     0     0
%      1     1     1     0     0     0     0];
%  
%  Bs=[     0     0     0     0
%      0     1     1     1
%      0     0     0     0
%      0     1     0     0
%      0     1     0     0
%      0     1     0     0
%      1     0     0     0];

As=[    0     1     0     0     0     0
     0     0     1     0     0     0
     1     0     1     1     0     0
     0     0     1     1     0     0
     0     0     1     1     0     0
     0     0     1     1     0     0];
 Bs=[  1     0     0     0
     0     1     0     0
     0     0     1     0
     0     0     0     1
     1     1     0     0
     1     1     0     0];

n=size(As,1);
m=size(Bs,2);


% r=2; % source SCC
% C=cell(r,1);
% %C{1}=[1,2,3,4,5];% input the source SCC
% %C{1}=[1,2];% input the source SCC
% %C{2}=[4,5];
% C{1}=[1,2,3];% input the source SCC
% C{2}=[4,5,6];
[C,r]=findsourceSCC(As');
AB=[As,Bs];
order=find(AB);
[orderrow,ordercolumn]=find(AB);% nonzero entry

xdim=sum(sum(AB))+r;% xdim
edgenum=sum(sum(AB));

%%% Aeq*x=beq;
beq=ones(n,1);
Aeq=zeros(n,xdim); % equality 
for i=1:n % equality 
    rowp=find(orderrow==i);
    Aeq(i,rowp)=1;
end
%%% Ax<= b;
b=ones(n+m+r);
b=[ones(n+m,1);zeros(r,1)];
A=zeros(n+m+r,xdim);
for i=1:n+m 
    colp=find(ordercolumn==i);
    A(i,colp)=1; % column 
end

%%%
f=zeros(xdim,1);
%%% find the positions of scc
for i=n+m+1:n+m+r
    t=i-(n+m);
    scct=C{t};
    size_scc=length(scct);
    scc_p=[];
    for scci=1:size_scc
        for sccj=n+1:n+m
            scc_temp1=find(orderrow==scct(scci));
            scc_temp2=find(ordercolumn==sccj);
            scc_p=[scc_p,intersect(scc_temp1,scc_temp2)];
        end
    end
    A(i,scc_p)=-1;
    A(i,xdim-r+t)=1;
   
    f(xdim-r+t)=-1;
end

 bposition=find(order>n*n);
 f(bposition)=1;
 
 
 
 

 
 %f(bposition)=cost;
%   alast=f';
%   A=[A;alast];
%   b=[b;k-r];
  % assign cost
%cost=[1 90 1 100 10 100 1 50 30 20 1 1 10 20 30]';
 %cost=ones(length(bposition),1);
 %cost=randi(2,length(bposition),1);
% cost=ones(length(bposition),1);
%  f(bposition)=cost;
%%%% specifize f
%f=[]
% fend=-min(cost([1,2,3,6]));
 % f(end)=fend;
%f=randi(4,xdim,1);
%f=ones(xdim,1);

lb=zeros(xdim,1);
ub=ones(xdim,1);

%%%%%%%%%%%
modifyI=[zeros(r,edgenum),eye(r)];
tilde_M=[A;Aeq;modifyI;-eye(xdim)];
ylen=size(tilde_M,1);
%%%%%%%%%%%%%%
%f=-tilde_M'* randi(2,ylen,1);
% not TDI£º example 
 clast=[ 0     0     0     1     1     1     1     1     1     1     1     0     1     1     0     1     1     0     0     1]';
 f=-clast;

%[x,fval]=linprog(f,A,b,Aeq,beq,lb,ub);
[x,fval]=linprog(f,[A;Aeq],[b;beq],[],[],lb,ub);
disp('primal:')
disp(fval)
fopt=fval+r;
disp('optimal matching:')
disp(x)
 disp('optimal value:')
 disp(fopt)

xinput=find(x==1);
xinput=xinput(find(xinput>sum(sum(As))));
xinput=xinput(find(xinput<sum(sum(AB))+1));

inputedge=[orderrow(xinput),ordercolumn(xinput)-n];
disp('input edge x<-u')
disp(inputedge)
% 
% %draw the network
% square_AB=[AB;zeros(m,n+m)];
% G = digraph(square_AB');
% %G = digraph(square_AB',{'x_1','x_2','x_3','x_4','x_5','x_6','u_1','u_2','u_3'});
% plot(G)


%%%%%%%%%%%%%%% check the dual function 

modifyI=[zeros(r,edgenum),eye(r)];
tilde_M=[A;Aeq;modifyI;-eye(xdim)];
ylen=size(tilde_M,1);

tilde_b=[b;beq;ones(r,1);zeros(xdim,1)];
[x1,fval1]=linprog(tilde_b,-eye(ylen),zeros(ylen,1),tilde_M',-f);
%disp('optimal matching:')
disp('dual 2')
disp(x1)
disp('optimal value:')
disp(fval1)
disp('difference')
disp(fval1-fval)
%%%% check dual 2

rank([tilde_M',-f])-rank([tilde_M'])
% modifyI=[zeros(r,edgenum),ones(r)];
% tilde_M=[A;Aeq;-Aeq;modifyI;-ones(xdim)];
% ylen=size(tilde_M,1);
% tilde_b=[b;beq;-beq;ones(r,1);zeros(xdim,1)];
% [x1,fval1]=linprog(tilde_b,-eye(ylen),zeros(ylen,1),tilde_M',-f);
% %disp('optimal matching:')
% disp('dual')
% disp(x1)
% disp('optimal value:')
% disp(fval1)
