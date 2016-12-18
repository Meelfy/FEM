function K = calWholeStiffnessMatrix(coord, unit_topology_table, materials,cal_type)
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
    [K, K_info] = open_K_space(unit_topology_table);
    m = size(unit_topology_table,1);
    t = 1;
    for i = 1:m
        element_X = coord(unit_topology_table(i, :)',1);
        element_Y = coord(unit_topology_table(i, :)',2);
        matrixB = calMatrixB(element_X, element_Y);
        matrixD = calMatrixD(materials(i,1), materials(i,2), cal_type);
        element_k = calElementStiffnessMatrix(matrixB, matrixD, t, calAera(element_X, element_Y));
        position = zeros(1,6);
        for ii = 1:3
            position(ii*2-1) = unit_topology_table(i,ii)*2 - 1;
            position(ii*2) = unit_topology_table(i,ii)*2;
        end
        for j = 1:6
            for jj = 1:6
                if position(j) >= position(jj)
                oned_x = K_info(position(j)) - (position(j)-position(jj));
                K(oned_x) = K(oned_x) + element_k(j,jj);
                end
            end
        end
    end
    temp = K;
    clear K;
    K{1} = temp;
    K{2} = K_info;    
