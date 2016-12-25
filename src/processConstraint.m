function K = processConstraint(K, bound)
% 这个函数对K进行处理，使其满足约束
% 用于一维半带宽方法
% 输入：
%      整体劲度矩阵 K
%      边界条件，格式参考README.MD
% 输出：
%      处理后的 K

% 一维半带宽整体劲度矩阵K
Ak  = K{1}; 

%  1 * 2n，n为结点个数
Ind = K{2}; 

for i = 1 : size(bound,1);
    element_num = bound(i, 1);
    x_or_y      = bound(i, 2);
    j           = element_num * 2 - 2 + x_or_y;
    
	% K(i,j) 相当于 Ak(Ind(i) - (i - j))
	Ak(Ind(j)) = Ak(Ind(j)) * (1 / eps);
end

%赋值返回
K{1} = Ak; 