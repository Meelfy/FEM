function element_k = calElementStiffnessMatrix(matrixB, matrixD, t, A)
% 这个函数返回单元的劲度矩阵
% 仅适用与三角形单元
% 输入
%       B矩阵     matrixB
%       D矩阵     matrixD
%       厚度      t
%       单元面积   A
% 输出
%       单元刚度矩阵 element_k
%       为 6 * 6 矩阵


element_k = B' * D * B * t * A;