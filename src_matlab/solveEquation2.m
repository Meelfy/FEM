function delta = solveEquation2(K, P, Iter_Time, Iter_Acc)
% 直接法和间接法解整体结点平衡方程
% 输入： 
	% 处理后的整体刚度矩阵K，和
	% 外力P
	% 解决方式solving_way, 有两个值，分别为直接法：direction 和 迭代法：iteration

% 可能用到的中间变量 

% 根据解决方式不同，自行写两个解方程函数
% 直接法
% 迭代法

% 输出：
	% 整体结点位移whole_displaycement

% 在readme.md中说明此解决方案
% 迭代法参考文献
% Iter_Time = 1000;
% Iter_Acc = 1e-5;
% K = diag([2 1]);
% P = [1; 1];
N = length(P);
T = diag(K);
AT = sparse(1./ T);
M = eye(N) - diag(AT) * K;
sum(eig(M) > 1)
G = P .* AT;
delta = sparse(ones(N, 1));
for i = 1:Iter_Time
    deltatemp = delta;
    delta = M * deltatemp + G;
    if max(abs(delta - deltatemp)) < Iter_Acc
        break
    end
end
