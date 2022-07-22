Code for the article: Yuan Zhang, et.al,  A Linear Programming Approach to the Minimum Cost Sparsest Input Selectio for Structured Systems


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

function description for Not_TU_polytope_not_integral_Example_1.m:

This is the code of Example 1 in the revised version of Total Unimodularity and Strongly Polynomial Solvability of Constrained Minimum Input
Selections for Structural Controllability: an LP-based Method, under view in IEEE TAC. In this example, we provide an example showing that without Assumption 3, the defined polytope P_rel may not be integral. The involved M is $\Delta$-UM for some $\Delta>=3$.
