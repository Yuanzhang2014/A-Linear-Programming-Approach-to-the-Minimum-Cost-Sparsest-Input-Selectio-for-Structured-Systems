%% The constraint matrix of the ILP in Example 1 which does not satisfy the total unimodular condition. 

a1=[1 0 1 0 1 0;0 1 0 0 0 0;0 0 0 1 0 1;1 1 0 1 0 0;0 0 1 0 0 0;0 0 0 0 1 1;0 0 0 0 0 0;0 0 0 0 0 0;-1 -1 -1 0 0 0];
a2=[1 0 0;0 1 0;0 0 0;0 0 0;0 0 0;0 1 0;1 0 0;0 0 0;0 0 1];
b=[ones(8,1);0];
a=[a1,a2];
k2=[1,2,3,4,5,6];k1=[1,3,4,6,9];
a=a(k1,k2);
n=6;
k=5;
nmax=1000;
for i=1:nmax
    k1=randperm(n-1,k);
    k2=randperm(n,k);
    f=det(a(k1,k2));
    if abs(f)>1
        disp(f)
        disp('found')
        break
    end
end
if i==nmax
    disp('not found')
end
    