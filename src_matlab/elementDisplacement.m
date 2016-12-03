function element_displacement = elmentDisplacement(whole_d, element_x, elment_y)
% 该函数通过整体结点位移计算各个单元的节点位移
% 输入：
	% 单元的
	% X坐标 element_x
	% Y坐标 element_y 
	% 整体结点位移 whole_d
%可能用到的中间变量

% 输出：
	% 单元结点位移 element_displacement

% 此时单元节点位移已经可以整理后输出为成果，可以在此直接打印
% 注意打印格式
n = size(unit_topology_table,1);
element_displaycement = zeros(n,6);
for i = 1:n
    position = zeros(1, 6);
    for ii = 1:3
        position(ii*2 - 1) = unit_topology_table(i,ii)*2 - 1;
        position(ii*2) = unit_topology_table(i,ii)*2;
    end
    for ii = 1:6
        element_displaycement(i,ii) = whole_d(position(ii));
    end
end
dlmwrite('output/elementdisplaycement.dat', element_displaycement);