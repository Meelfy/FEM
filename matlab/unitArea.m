function unit_A = unitArea(unit_x, unit_y)
% 本函数用于计算单元的面积
% unit_x与unit_y按照i、j、m的顺序储存，为列向量
    unit_A = 0.5 * det([ones(3, 1), unit_x, unit_y]);
end