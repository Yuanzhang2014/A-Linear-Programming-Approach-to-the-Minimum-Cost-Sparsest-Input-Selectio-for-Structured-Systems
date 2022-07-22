% As=[1 1 0;1 0 0;0 0 0];
% Bs=[1 1;1 0;1 0];
%% A Linear Programming Approach to the Minimum Cost Sparsest Input Selectio for Structured Systems
%% Input: [As,Bs] is the sparsity pattern of the structured systems; the input does not need to satisfy the source-SCC grouped input constraint.  
%% Output: the selected input links in the optimal solution. 
%% See the example of Yuan Zhang, et.al  A Linear Programming Approach to the Minimum Cost Sparsest Input Selectio for Structured Systems.
%% This is the code of Example 1 in the revised version of Total Unimodularity and Strongly Polynomial Solvability of Constrained Minimum Input
%% Selections for Structural Controllability: an LP-based Method, under view in IEEE TAC. In this example, we provide an example showing that without Assumption 3, the defined 
%% polytope P_rel may not be integral. 
clear
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


% r=1; % source SCC
% C=cell(r,1);
% %C{1}=[1,2,3,4,5];% input the source SCC
% %C{1}=[1,2,3];% input the source SCC
% C{1}=[1,2];
%C{2}=[4,5,6];
[C,r]=findsourceSCC(As');
AB=[As,Bs];
order=find(AB);
[orderrow,ordercolumn]=find(AB);

xdim=sum(sum(AB))+r;% xdim
edgenum=sum(sum(AB));
%%% Aeq*x=beq;
beq=ones(n,1);
Aeq=zeros(n,xdim);
for i=1:n
    rowp=find(orderrow==i);
    Aeq(i,rowp)=1;
end
%%% Ax<= b;
b=ones(n+m+r);
b=[ones(n+m,1);zeros(r,1)];
A=zeros(n+m+r,xdim);
for i=1:n+m
    colp=find(ordercolumn==i);
    A(i,colp)=1;
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
  
% f= [ 0     0     0     1     1     1     1     1     1     1     1     0     1     1     0     1     1     0     0     1]';
  %f(10)=100;
 % f(7)=100;
%%%% specifize f
%f=[]

lb=zeros(xdim,1);
ub=ones(xdim,1);
%[x,fval]=linprog(-f,A,b,Aeq,beq,lb,ub);

[x,fval]=linprog(-f,[A;Aeq],[b;beq],[],[],lb,ub);

% fopt=fval+r;
disp('optimal matching:')
disp(x)
disp('optimal value:')
disp(fval)

% xinput=find(x==1);
% xinput=xinput(find(xinput>sum(sum(As))));
% xinput=xinput(find(xinput<sum(sum(AB))+1));
% 
% inputedge=[orderrow(xinput),ordercolumn(xinput)-n];
% disp('input edge x<-u')
% disp(inputedge)

%draw the network
square_AB=[AB;zeros(m,n+m)];
G = digraph(square_AB');
%G = digraph(square_AB',{'x_1','x_2','x_3','x_4','x_5','x_6','u_1','u_2','u_3'});
plot(G)

%%%%%%
f=[ 0     0     0     1     1     1     1     1     1     1     1     0     1     1     0     1     1     0     0     1]';
modifyI=[zeros(r,edgenum),eye(r)];
tilde_M=[A;Aeq;modifyI;-eye(xdim)];
ylen=size(tilde_M,1);

tilde_b=[b;beq;ones(r,1);zeros(xdim,1)];
[x1,fval1]=linprog(tilde_b,-eye(ylen),zeros(ylen,1),tilde_M',f);
%disp('optimal matching:')
disp('dual 2')
disp(x1)
disp('optimal value:')
disp(fval1)


%%%
% [x,fval]=linprog(-f,[A],[b],[Aeq],[beq],lb,ub);
% [x1,fval1]=linprog(tilde_b,-eye(ylen),zeros(ylen,1),tilde_M',f);
% Apoly=[A;Aeq;-Aeq;eye(xdim);-eye(xdim)];
% bpoly=[b;beq;-beq;ones(xdim,1);-zeros(xdim,1)];
% 
% [x,fval]=linprog(-f,Apoly,bpoly);
% 
% This example shows that the polytope P_rel is not integral. 
Apoly2=[A;Aeq;eye(xdim);-eye(xdim)];bpoly2=[b;beq;ones(xdim,1);-zeros(xdim,1)];
[x1,fval1]=linprog(-f,Apoly2,bpoly2)
% 
% ylen=size(Apoly,1);
% [x1,fval1]=linprog(bpoly,-eye(ylen),zeros(ylen,1),Apoly',f);
% 
% intcon=1:xdim;
% x = intlinprog(-f,intcon,Apoly2,bpoly2);
