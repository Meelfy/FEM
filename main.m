% 本程序对有限元算法进行了计算
% 变量的定义见 README.md
clc;clear all;close all;
% Step 1： 数据读取
addpath(genpath(pwd));

input_path = 'input/sam1.0/';

% 边界条件，输入为n行，n为约束个数，每一行为“a b c”，a为结点编号，b为1或2，
% 分别表示x、y方向，c为位移量（未考虑弹性约束）
bound = dlmread([input_path, 'boundaryCondition.dat']);

% 结点坐标，输入为n行，n为结点个数，每一行为“x y”，即该行数对应结点数的坐标
coord = dlmread([input_path, 'elementCoordinates.dat']);

% 单元拓扑，输入为n行，n为单元个数，每一行为“i j m”，即对应的单元的结点编号
unit_topology_table = dlmread([input_path, 'elementTopology.dat']);

% 外力条件，输入为n行，n为结点个数，每一行为“x y”，行数对应结点号，x为x方向上力，y为y方向上的力
P = dlmread([input_path, 'forceCondition.dat']);
P = P';P = P(:);

% 材料，输入为n行，n为单元个数，每一行为“e u”， 行数对应单元号，e为E，u为'muj'
materials = dlmread([input_path, 'materials.dat']);

% 平面应力问题cal_type=1,平面应变问题cal_type=2
cal_type = 1;

% flag = 1;
flag = 2;
tol = 1e-5;

% Step 2： 整体刚度矩阵集成,输入单元劲度矩阵，相应单元的单元定位向量,未计算完的K
% Branch 1: 使用一维半带宽方法求解 
if flag == 1
    K = calWholeStiffnessMatrix(coord, unit_topology_table,...
                                materials,cal_type);
% Step 3： 根据约束对整体刚度矩阵进行处理
    K = processConstraint(K, bound);
    P = processForce(P, K, bound);
% Step 4： 求解结点平衡方程
    whole_displcement = solveEquation(K, P);
end


% Branch 2: 使用稀疏矩阵的方式储存，求解
if flag == 2
    K = calWholeStiffnessMatrixSparse(coord,...
                                      unit_topology_table,...
                                      materials,...
                                      cal_type);
    % Step 3： 根据约束对整体刚度矩阵进行处理
    K = processConstraintSparse(K, bound);
    % P 的处理一定要在 K之后，因为K已经被置为大数
    P = processForceSparse(P, K, bound);
    % Step 4： 求解结点平衡方程
    whole_displcement = solveEquation2(K, P, tol);
end

% Step 5： 求解单元节点位移
element_displacement = elementDisplacement(whole_displcement, unit_topology_table);
% Step 6： 求解单元应变与单元应力
m = size(unit_topology_table, 1);
element_strain = zeros(3, m);
element_stress = zeros(3, m);
for i = 1:m
    % 获取第 i 个单元的坐标
    element_X = coord(unit_topology_table(i, :)', 1);
    element_Y = coord(unit_topology_table(i, :)', 2);
    element_strain(:, i) = elementStrain(calMatrixB(element_X, element_Y),...
                                   element_displacement,...
                                   i);
    element_stress(:, i) = elementStress(calMatrixD(materials(i,1), ...
                                   materials(i,2), cal_type),...
                                   element_strain,...
                                   i);
end
dlmwrite('output/element_displacement.dat', element_displacement, 'delimiter', '\t');
dlmwrite('output/element_stress.dat', element_stress, 'delimiter', '\t');