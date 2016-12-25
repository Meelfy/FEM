function element_stress = elementStress(matrixD, element_strain, element_num)
% 该函数用于计算单元应力
% 输入为
%   D矩阵 matriD
%   单元节点应变 element_strain
%   单元编号element_num
% 输出为
%   单元应力 element_stress

element_stress = matrixD * element_strain(:, element_num);