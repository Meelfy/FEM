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

flag = 1;
% flag = 2;
% Iter_Time = 1000;
% Iter_Acc = 1e-5;

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
    P = processForceSparse(P, K, bound);
% Step 4： 求解结点平衡方程
    delta = solveEquation2(K, P, Iter_Time, Iter_Acc);
end

% Step 5： 求解单元节点位移
% Step 6： 求解单元应变与单元应力