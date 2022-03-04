# A-Linear-Programming-Approach-to-the-Minimum-Cost-Sparsest-Input-Selectio-for-Structured-Systems
Matlab Code for the article: Yuan Zhang, et.al,  A Linear Programming Approach to the Minimum Cost Sparsest Input Selectio for Structured Systems, arXiv e-prints (2021): arXiv-2108.


Function description for test_unimodular.m:

The constraint matrix of the ILP in Example 1 which does not satisfy the total unimodular condition. 

Function description for LP_test.m:

Input: [As,Bs] is the sparsity pattern of the structured systems; the input does not need to satisfy the source-SCC grouped input constraint.  

Output: the selected input links in the optimal solution. 

See the example of Yuan Zhang, et.al  A Linear Programming Approach to the Minimum Cost Sparsest Input Selectio for Structured Systems.


Function description for LP_test2.m:

Input: [As,Bs] is the sparsity pattern of the structured systems; k is the upper bound for input sparsity; the input does not need to satisfy the source-SCC grouped input constraint.  

Output: the selected input links in the optimal solution. 

See the example of Yuan Zhang, et.al  A Linear Programming Approach to the Minimum Cost Sparsest Input Selectio for Structured Systems.

Function description for findsourceSCC.m: 
input: the transpose of As; 

output: [C,r], C is the set of vertices of source strongly-connected components (SCC), and r is the number of source SCCs.  
