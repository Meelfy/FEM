% 本程序对有限元算法进行了计算
% 变量的定义见 README.md

% Step 1： 数据读取
addpath(genpath(pwd));

input_path = 'input/sam1.0/';

% 边界条件，输入为n行，n为约束个数，每一行为“a b”，a为结点编号，b为1或2，分别表示x、y方向的约束（位移为0）
bound = dlmread([input_path, 'boundaryCondition.dat']);

% 结点坐标，输入为n行，n为结点个数，每一行为“x y”，即该行数对应结点数的坐标
coord = dlmread([input_path, 'elementCoordinates.dat']);

% 单元拓扑，输入为n行，n为单元个数，每一行为“i j m”，即对应的单元的结点编号
unit_topology_table = dlmread([input_path, 'elementTopology.dat']);

% 外力条件，输入为n行，n为结点个数，每一行为“x y”，行数对应结点号，x为x方向上力，y为y方向上的力
P = dlmread([input_path, 'forceCondition.dat']);

% 材料，输入为n行，n为单元个数，每一行为“e u”， 行数对应单元号，e为E，u为'muj'
materials = dlmread([input_path, 'materials.dat']);

% Step 2： 所有单元 B，D矩阵的计算

% Step 3： 整体刚度矩阵集成,输入单元劲度矩阵，相应单元的单元定位向量,未计算完的K

% Step 4： 根据约束对整体刚度矩阵进行处理

% Step 5： 求解结点平衡方程

% Step 6： 求解单元节点位移

% Step 7： 求解单元应变与单元应力