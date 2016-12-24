function [K,K_info] = open_K_space(unit_topology_table)
% 这个函数计算一维半带宽方法下的整体的劲度矩阵K中所包含的元素个数
% 在单元拓扑表中，没有在同一个单元中出现过的两节点之间的Kij为0
% 根据这个特点计算一维半带宽方法下的K矩阵中需要存储的元素个数并为K矩阵申请空间
% n为结点个数
    n         = max(max(unit_topology_table));
    K_info    = zeros(1,2*n);
    K_info(1) = 1;
    K_info(2) = 3;
    for i = 2 : n
        all_line_idx  = sum((unit_topology_table == i)')' > 0;
        min_of_A      = min(min(unit_topology_table(all_line_idx, :)));
        nozero        = i - min_of_A + 1;
        K_info(2*i-1) = K_info(2*i-2) + nozero*2-1;
        K_info(2*i)   = K_info(2*i-1) + nozero*2;
    end
    K = zeros(1,K_info(2*n));