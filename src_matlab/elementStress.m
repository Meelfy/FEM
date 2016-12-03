  function element_stress = elementStress(matrixD, element_strain, unit_topology_table)
% 该函数用于计算单元应力
% 输入为
%   D矩阵 matriD
%   单元节点应变 element_strain

% 可能用到的中间变量

% 输出为
%   单元应力 element_stress
n = size(unit_topology_table,1);
element_stress = zeros(n,3);
for i = 1:n
    element_strain(i,:)' = matrixD * (element_strain(i,:)');
end
dlmwrite('output/elementstress.dat', element_stress);