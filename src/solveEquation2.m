function whole_displcement = solveEquation2(K, P, tol)
% 迭代法求解方程
% 输入： 
	% 处理后的整体刚度矩阵K，和
	% 外力P
% 共轭梯度法对方程进行求解
% 默认精度
    if nargin == 2
        tol = 1e-5;
    end

    [m, n] = size(K);
    [p, q] = size(P);

    % 初始化
    x = sparse(zeros(m,1));

    % 根据P初始化 r0 and d
    r0 = P;
    d  = P;
    % 计数器
    counter = 0;            

    % 如果成立，直接返回
    if sqrt(r0'*r0) < tol;
        return;
    else
        v       = K * d;
        % 计算步长
        w       = r0' * r0 / (d' * v);
        % 更新 x
        x       = x + w * d;
        % 计算剩余的
        r1      = r0 - w * v;
        counter = counter + 1;
    end

    while sqrt(r1'*r1) > tol
        P       = r1' * r1 / (r0' * r0);
        % 更新搜索方向
        d       = r1 + P * d;
        r0      = r1;
        v       = K * d;
        % 计算步长
        w       = r0' * r0 / (d' * v);
        x       = x + w * d;
        r1      = r0 - w * v;
        counter = counter + 1;
    end

    whole_displcement = x;