function P = processForce(P, K, K_info, bound)
% 这个函数对P进行处理，使其满足约束
% 输入：
%      外力荷载P
% 输出：
%      处理后的P
Ak = K{1}; % line
Ind = K{2}; % 2 * n


for i = 1 : size(bound,1);
	elementNum = bound(i, 1);
	XorY = bound(i, 2);
	j = elementNum * 2 - 2 + XorY;
	displacement = bound(i, 3);
	% K(i,j) 相当于 Ak(Ind(i) - (i - j))
	P(j) = Ak(Ind(j)) * (1 / eps) * displacement;
end 