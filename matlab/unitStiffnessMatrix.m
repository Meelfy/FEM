function unitStiffnessMatrix(unit_x, unit_y, unit_mu, unit_E, unit_t)
% 本函数用于生成单元的的劲度矩阵
% unit_x与unit_y按照i、j、m的顺序储存，为列向量
    
    % 如果没有输入厚度，默认厚度为1
    if nargin == 4
        unit_t = 1;
    end

    % 计算单元面积
    unit_A = unitArea(unit_x, unit_y);

    % 计算bi ci (i,j,m)
    % 对应关系i j m -- 1 2 3
    node_displacement = [ones(3, 1), unit_x, unit_y];
    for i = 1:3
        % bi 为 第i行第2列元素的代数余子式
        Hij = node_displacement;
        Hij(i, :) = [];
        Hij(:, 2) = [];
        unit_b(i) = (-1) ^ (i + 2) * det(Hij);

        % ci 为 第i行第3列元素的代数余子式
        Hij = node_displacement;
        Hij(i, :) = [];
        Hij(:, 3) = [];
        unit_c(i) = (-1) ^ (i + 3) * det(Hij);
    end

    % 计算单元劲度矩阵
    for i = 1:3
        for j = 1:3
            unit_k = unit_E * unit_t * 0.25 / (1 - unit_mu^2) ...
            /unit_A * [] %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


        % Hij=H;
        % Hij(i,:)=[];
        % Hij(:,j)=[];
        % A(i,j)=(-1)^(i+j)*det(Hij);