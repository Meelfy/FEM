function [K,K_info] = open_K_speace(unit_topology_table)
    m = max(max(unit_topology_table));
    K_info = zeros(1,2*m);
    K_info(1) = 1;
    k_info(2) = 3;
    for i = 2 : m
        all_line_idx = sum((unit_topology_table == i)')' > 0;
        min_of_A = min(min(unit_topology_table(all_line_idx, :)));
        nozero = i - min_of_A + 1;
        K_info(2*i-1) = K_info(2*i-2) + nozero*2;
        K_info(2*i) = K_info(2*i-1) + nozero*2 +1;
    end
    K = zeros(1,K_info(2*m));