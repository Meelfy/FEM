function P = processForceSparse(P, K, bound)
% 这个函数对P进行处理，使其满足约束
% 用于稀疏矩阵方法
% 输入：
%      外力荷载P
% 输出：
%      处理后的P
P = sparse(P);

for i = 1 : size(bound, 1)
    elementNum   = bound(i, 1);
    XorY         = bound(i, 2);
    j            = elementNum * 2 - 2 + XorY;
    displacement = bound(i, 3);
    P(j)         = K(j, j) * displacement;
end