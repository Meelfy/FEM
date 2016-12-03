function [K,K_info] = calWholeStiffnessMatrix(Coord, unit_topology_table, Materials,cal_type)
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
    open_K_speace(unit_topology_table);
    n = size(unit_topology_table,1);
    for i = 1:n
        matrixB = calMatrixB(element_X, element_Y);
        matrixD = calMatrixD(Materials(i,1), Materials(i,2), cal_type);
        element_k = calElementStiffnessMatrix(matrixB, matrixD, t, Area(element_X, element_Y));
