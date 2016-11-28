function matrixB = calMatrixB(element_X, element_Y)
% 这个函数完成单个结点的B矩阵的运算
% B矩阵 —— 位移到应变的转换矩阵（几何方程）
% 输入为单元的
%       X坐标  element_X
%       Y坐标  element_Y

% 输出为单元的
%       B矩阵,只需适应三角形单元
% B 为 3 * 6的矩阵

% 数据类型的规定
% 请在README.md中说明

% 请标明参考文献的出处