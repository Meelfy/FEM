function [K,K_info] = open_K_speace(unit_topology_table)
    m = max(max(unit_topology_table));
    K_info = zeros(1,m);
    K_info(1) = 1;
    for i = 2 : m
        all_line_idx = sum((unit_topology_table == i)')' > 0;
        min_of_A = min(min(unit_topology_table(all_line_idx, :)));
        nozero = i - min_of_A + 1;
        K_info(i) = K_info(i-1) + nozero;
    end
    K = zeros(1,K_info(m));