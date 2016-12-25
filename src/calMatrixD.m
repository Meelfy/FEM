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

% 数据类型、对单元应力的规定在README.md中说明

% 平面应力问题cal_type=1,平面应变问题cal_type=2
E  = element_E;
mu = element_mu;
if cal_type == 2
    E  = E/(1-mu^2);
    mu = mu/(1-mu);
end
matrixD = E/(1-mu^2)*[1 mu 0; mu 1 0; 0 0 (1-mu)/2];

