function matrixD = calMatrixD(element_E, element_mu, cal_type)
% 这个函数完成单个结点的D矩阵的运算
% D矩阵——弹性柔度矩阵
% 输入为单元的
%       弹性模量 E
%       泊松比   mu
%       计算模式 cal_type
%            单元应力问题
%            单元应变问题
% 输出为单元的D矩阵，只需适应三角形单元

% 数据类型、对单元应力的规定
% 请在README.md中说明

% 请标明参考文献的出处