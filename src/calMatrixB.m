function matrixB = calMatrixB(element_X, element_Y)
% 这个函数完成单个结点的B矩阵的运算
% B矩阵 —— 位移到应变的转换矩阵（几何方程）
% 输入为单元的
%       X坐标  element_X
%       Y坐标  element_Y

% 输出为单元的
%       B矩阵,只需适应三角形单元
% B 为 3 * 6的矩阵

% 数据类型的规定在README.md中有说明
% 计算单元面积的函数定义在 
%     /src_matlab/util/calAera.m
%     使用 element_A = calAera(element_X, element_Y);
%     直接得到结果

A = [element_X, element_Y];

bi = - det([1, A(2, 2);...
            1, A(3, 2)]);
ci = det([1, A(2, 1);...
          1, A(3, 1)]);
bj = - det([1, A(3, 2);...
            1, A(1, 2)]);
cj = det([1, A(3, 1);...
          1, A(1, 1)]);
bm = - det([1, A(1, 2);...
            1, A(2, 2)]);
cm = det([1, A(1, 1);...
          1, A(2, 1)]);
element_A = calAera(element_X, element_Y);

matrixB = 1 / (2*element_A) * [bi,  0, bj,  0, bm,  0;...
                                0, ci,  0, cj,  0, cm;...
                              ci, bi, cj, bj, cm, bm];

