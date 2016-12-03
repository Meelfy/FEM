function [K,K_info] = open_K_speace(unit_topology_table)
    n = max(max(unit_topology_table));
    K_info = zeros(1,2*n);
    K_info(1) = 1;
    K_info(2) = 3;
    for i = 2 : n
        all_line_idx = sum((unit_topology_table == i)')' > 0;
        min_of_A = min(min(unit_topology_table(all_line_idx, :)));
        nozero = i - min_of_A + 1;
        K_info(2*i-1) = K_info(2*i-2) + nozero*2-1;
        K_info(2*i) = K_info(2*i-1) + nozero*2;
    end
    K = zeros(1,K_info(2*n));