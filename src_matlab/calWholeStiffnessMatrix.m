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
    [K, K_info] = open_K_speace(unit_topology_table);
    n = size(unit_topology_table,1);
    t = 1;
    for i = 1:n
        element_X = Coord(unit_topology_table(i)',1);
        element_Y = Coord(unit_topology_table(i)',2);
        matrixB = calMatrixB(element_X, element_Y);
        matrixD = calMatrixD(Materials(i,1), Materials(i,2), cal_type);
        element_k = calElementStiffnessMatrix(matrixB, matrixD, t, Area(element_X, element_Y));
        position = zeros(1,6);
        for ii = 1:3
            position(ii*2-1) = unit_topology_table(i)*2-1;
            position(ii*2) = unit_topology_table(i)*2;
        end
        for j = 1:6
            for jj = 1:6
                oned_x = K_info(position(j)) - (position(j)-position(jj));
                K(oned_x) = K(oned_x) + element_k(j,jj);
            end
        end
    end
    
