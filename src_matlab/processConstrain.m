function K = processConstrain(K, bound)
% 这个函数对K进行处理，使其满足约束
% 输入：
%      整体劲度矩阵 K
%      其他可能用到的参数
%      请自行补充
% 输出：
%      处理后的 K
Ak = K{1}; % line
Ind = K{2}; % 2 * n

for i = 1 : size(bound,1);
elementNum = bound(i, 1);
XorY = bound(i, 2);
j = elementNum * 2 - 2 + XorY;
displacement = bound(i, 3);
if displacement == 0
	% K(i,j) 相当于 Ak(Ind(i) - (i - j))
	Ak(Ind(j)) = Ak(Ind(j)) * (1 / eps);
end 

K{1} = Ak; %赋值返回