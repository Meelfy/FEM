function element_strain = elementStrain(matrixB, element_displacement, element_num)
% 该函数用于计算单元应变
% 输入为
% 	B矩阵 matrixB
% 	单元节点位移 element_d

% 可能用到的中间变量

% 输出为
% 	单元应变 element_strain
element_strain = matrixB * element_displacement(:, element_num);
    