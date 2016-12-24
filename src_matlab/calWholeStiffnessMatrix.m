function K = calWholeStiffnessMatrix(coord, unit_topology_table, materials,cal_type)
% 这个函数计算一维半带宽方法下的整体的劲度矩阵K
% 输入：
%     节点坐标表
%     单元拓扑表
%     材料情况
%       计算模式 cal_type
%            单元应力问题
%            单元应变问题
% 输出：
%     整体刚度矩阵 K
%     K 为cell
%     K{1，1}为转化为一维带状储存的K
%     K{1，2}为主对角元在一维矩阵中位置

%使用open_K_space（）函数计算带状矩阵K所需要的空间
    [K, K_info] = open_K_space(unit_topology_table);
    m           = size(unit_topology_table,1);
    t           = 1;
    for i = 1:m
        element_X = coord(unit_topology_table(i, :)',1);
        element_Y = coord(unit_topology_table(i, :)',2);
        matrixB   = calMatrixB(element_X, element_Y);
        matrixD   = calMatrixD(materials(i,1), materials(i,2), cal_type);
        element_k = calElementStiffnessMatrix(matrixB, matrixD, t,...
                                              calAera(element_X, element_Y));
        position  = zeros(1,6);
        for ii = 1:3
            position(ii*2-1) = unit_topology_table(i,ii)*2 - 1;
            position(ii*2)   = unit_topology_table(i,ii)*2;
        end
        for j = 1:6
            for jj = 1:6
                if position(j) >= position(jj)
                oned_x    = K_info(position(j)) - (position(j)-position(jj));
                K(oned_x) = K(oned_x) + element_k(j,jj);
                end
            end
        end
    end
    temp = K;
    clear K;
    K{1} = temp;
    K{2} = K_info;    
