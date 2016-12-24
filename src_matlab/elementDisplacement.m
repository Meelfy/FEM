function element_displacement = elmentDisplacement(whole_d, unit_topology_table)
% 该函数通过整体结点位移计算各个单元的节点位移
% 输入：
	% 单元拓扑表
	% 整体结点位移 whole_d

% 输出：
	% 各单元结点位移 element_displacement

n = size(unit_topology_table,1);
element_displacement = zeros(n,6);
for i = 1:n
    position = zeros(1, 6);
    for ii = 1:3
        position(ii*2 - 1) = unit_topology_table(i,ii)*2 - 1;
        position(ii*2)     = unit_topology_table(i,ii)*2;
    end
    for ii = 1:6
        element_displacement(i,ii) = whole_d(position(ii));
    end
end
element_displacement = element_displacement';
