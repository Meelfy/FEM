function K = calWholeStiffnessMatrixSparse(coord, unit_topology_table, materials, cal_type)
% 这个函数计算稀疏矩阵方法下的整体的劲度矩阵K
% 输入：
%     节点坐标表
%     单元拓扑表
%     材料情况
%       计算模式 cal_type
%            单元应力问题
%            单元应变问题
% 输出：
%     整体刚度矩阵 K

% 节点个数
n = max(unit_topology_table(:));
% 初始化整体刚度矩阵
K = sparse(2*n, 2*n);
% 厚度
t = 1;
% 单元个数
m = size(unit_topology_table, 1);
for i = 1:m
    % 获取第 i 个单元的坐标
    element_X = coord(unit_topology_table(i, :)', 1);
    element_Y = coord(unit_topology_table(i, :)', 2);
    % 计算该单元的 B 和 D 矩阵
    matrixB = calMatrixB(element_X, element_Y);
    matrixD = calMatrixD(materials(i,1), materials(i,2), cal_type);
    % 计算单元劲度矩阵
    % Aera right
    element_k = calElementStiffnessMatrix(matrixB, matrixD,...
                                         t, calAera(element_X, element_Y));
    % 稀疏化
    element_k = sparse(element_k);

    % 定位向量
    position = zeros(1, 6);
    for j = 1:3
        position(j*2-1) = unit_topology_table(i,j)*2-1;
        position(j*2) = unit_topology_table(i,j)*2;
    end

    K(position, position) = K(position, position) + element_k;
end