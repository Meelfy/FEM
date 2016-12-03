function element_strain = elementStrain(matrixB, element_displaycement, unit_topology_table)
% 该函数用于计算单元应变
% 输入为
% 	B矩阵 matrixB
% 	单元节点位移 element_d

% 可能用到的中间变量

% 输出为
% 	单元应变 element_strain
n = size(unit_topology_table,1);
element_strain = zeros(n,6);
for i = 1:n
    element_strain(i,:)' = matrixB * (element_displaycement(i,:)');
end

    