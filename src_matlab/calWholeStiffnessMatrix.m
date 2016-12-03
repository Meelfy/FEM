function K = calWholeStiffnessMatrix(ke，position_v,K)
% 这个函数计算整体的劲度矩阵K
% 因为计算方法未定，输入部分的说明自行完成
% 输入：单元劲度阵
% 
% 输出：
%     整体刚度矩阵 K
%     K 为 n * n 的矩阵 的某种储存形式
%     如果K的储存不是矩阵，请使用cell储存
%     并给出每个cell的含义
%     之后参数的传递以 K 为准
for i = 1:6
    for j = 1:6
        K(position_v(i),position_v(j)) = K(position_v(i),position_v(j)) + ke(i,j);
    end
end