function [SCC,r]=findsourceSCC(As) % As is the adjancy matrix, As_ij\ne 0 means the edge from i to j
G=sparse(As);
[S, C] = graphconncomp(G);
r=0;
C1=unique(C);
SCC=cell(1);
for i=1:S
   ind=find(C==C1(i));
   if sum(sum(As(:,ind)))-sum(sum(As(ind,ind)))==0
        r=r+1;
       SCC{r}=ind;
   end
end