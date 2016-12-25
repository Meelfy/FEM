有限元计算程序
--------------

本程序是基于**弹性力学与有限元**课程的要求，实现有限元程序的计算部分。本项目使用 MATLAB 编程，以期达到运行效率与开发效率兼顾的目的。项目成员如下：
- 张泽凡
- 黄鹤飞
- 王政荣
- 王艺杰
- 张家豪
- 梅杰

## 程序结构

    FEM/
    ├── doc
    │   ├── FEM原理说明.docx
    │   ├── nabook.pdf
    │   ├── painless-conjugate-gradient.pdf
    │   └── 集成.docx
    ├── img
    │   ├── WBS.jpg
    │   ├── 数据流程图-0.1.jpg
    │   ├── 数据流程图-0.1.vsdx
    │   └── 甘特图.png
    ├── input
    │   ├── sam1.0
    │   │   ├── boundaryCondition.dat
    │   │   ├── elementCoordinates.dat
    │   │   ├── elementTopology.dat
    │   │   ├── forceCondition.dat
    │   │   ├── materials.dat
    │   │   └── old.7z
    │   └── Sample
    │       ├── Readme.pdf
    │       ├── Sample.fem
    │       ├── Sample.mat
    │       ├── Sample.pqu
    │       └── Sample.uvw
    ├── LICENSE
    ├── main.m
    ├── output
    │   ├── element_displacement_big.dat
    │   ├── element_displacement.dat
    │   ├── element_stress_big.dat
    │   └── element_stress.dat
    ├── README.md
    └── src
        ├── calElementStiffnessMatrix.m
        ├── calMatrixB.m
        ├── calMatrixD.m
        ├── calWholeStiffnessMatrix.m
        ├── calWholeStiffnessMatrixSparse.m
        ├── elementDisplacement.m
        ├── elementStrain.m
        ├── elementStress.m
        ├── openKspeace.m
        ├── processConstraint.m
        ├── processConstraintSparse.m
        ├── processForce.m
        ├── processForceSparse.m
        ├── solveEquation2.m
        ├── solveEquation.m
        └── utils
            ├── calAera.m
            └── conjugateGradient.m

## 工作分解结构图

<div align="center">
    <img src="https://github.com/MajorChina/FEM/blob/master/img/WBS.jpg">
</div>

## 任务安排及进度

<div align="center">
    <img src="https://github.com/MajorChina/FEM/blob/master/img/甘特图.png">
</div>

## 数据流程图

<div align="center">
    <img src="https://github.com/MajorChina/FEM/blob/master/img/数据流程图-0.1.jpg">
</div>

## 编程规范

### 编码格式

统一采用 UTF-8 编码

### 用到的变量及其规定

#### 整体变量

结点个数

    n

单元个数

    m

全部结点坐标

    all_element_X  /  n * 1
    all_element_Y  /  n * 1

#### 输入文件格式

单元拓扑表

    unit_topology_table  / m * 3  
    所在行数即为单元的编号

约束

    bound / 约束个数 * 3
    代表： 点号 x/y(1/2) 位移大小

结点坐标

    coord / n * 2

外力条件

    P / n * 2
    n为结点个数，每一行为“x y”，行数对应结点号，x为x方向上力

单元材料
    
    materials / m * 2
    材料，输入为m行，m为单元个数，每一行为“e u”

#### 单元变量

单个单元的坐标使用两个列向量，依次为 i j m

    double element_X  / 三行，一列 3 * 1  
    double element_Y  / 三行，一列 3 * 1

单元刚度阵k

    element_k  /  6 * 6

B矩阵

    double matrixB  / 3 * 6的矩阵

整体刚度阵K的储存

    K 为一维数组 长度未知 下三角矩阵的值
    K_info 储存主对角元在K中的位置 1 * n

整体的位移

    whole_displacement  /  2n * 1


### 用到的函数文件及其规定
    
    calMatrixB.m                     / 计算 B 矩阵
    calMatrixD.m                     / 计算 D 矩阵
    openKspeace.m                    / 计算一维半带宽方法下的整体的劲
                                     / 度矩阵K中所包含的元素个数
    calArea.m                        / 返回三角形单元的面积
    calElementStiffnessMatrix.m      / 返回单元的劲度矩阵
    calWholeStiffnessMatrix.m        / 计算一维半带宽方法下的整体的劲度矩阵K
    calWholeStiffnessMatrixSparse.m  / 计算稀疏矩阵方法下的整体的劲度矩阵K
    elementStrain.m                  / 计算单元应变
    elementStress.m                  / 计算单元应力
    elementDisplacement.m            / 通过整体结点位移计算各个单元的节点位移
    processConstraint.m              / 对 K 进行处理，使其满足约束
    processConstraintSparse.m        / 函数对K进行处理，使其满足约束
                                     / 用于稀疏矩阵方法
    processForce.m                   / 对P进行处理，使其满足约束
    processForceSparse.m             / 函数对P进行处理，使其满足约束
                                     / 用于稀疏矩阵方法
    solveEquation.m                  / 直接法解整体结点平衡方程
    solveEquation2.m                 / 迭代法求解方程

### 文件命名

开头小写、驼峰命名法

    unitArea.m
    unitStiffnessMatrix.m

### 函数命名

开头小写、驼峰命名法

### 变量命名

变量 下划线链接，小写

    element_displacement
    whole_displcement

常量 全部大写

    E



License
-------
Copyright 2016

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; If not, see 
    
    http://www.gnu.org/licenses