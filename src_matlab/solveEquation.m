function whole_displcement = solveEquation(K, P)
% 直接法和间接法解整体结点平衡方程
% 输入： 
    % 处理后的整体刚度矩阵K，和
    % 外力P
    % 解决方式solving_way, 有两个值，分别为直接法：direction 和 迭代法：iteration

% 可能用到的中间变量 

% 根据解决方式不同，自行写两个解方程函数
% 直接法

% 输出：
    % 整体结点位移whole_displcement

% 在readme.md中说明此解决方案
% 迭代法参考文献

Ak = K{1}; % line
Ind = K{2}; % 2 * n

% 使用直接法计算
% L 是下三角矩阵
% 逐层计算L的值
% L 的结构与Ak相同
L = 0 * Ak;

L(1) = Ak(1);
% K(i,j) 相当于 Ak(Ind(i) - (i - j))
% L(i,j) 相当于 L(Ind(i) - (i - j))
for i = 2:length(Ind)
    for j = Ind(i) - Ind(i-1) : i
        temp = 0;
        for k = 1:j-1
            temp = temp + L(Ind(i) - (i - k)) * L(Ind(j) - (j - k)) / ...
                    L(Ind(k) - (k - k));
        end
        L(Ind(i) - (i - j)) = Ak(Ind(i) - (i - j)) - temp;
    end
end

Y(1) = P(1) / L(Ind(1) - (1 - 1));
for i = 2:length(Ind)
    temp = 0;
    for j = 1 : i - 1
        temp = temp + Y(j) * L(Ind(i) - (i - j)) / L(Ind(i));
    end
    Y(i) = P(i) - temp;
end

whole_displcement(length(Ind)) = Y(end);
for i = 1:length(Ind) - 1
    j = length(Ind) - i;

    temp = 0;
    for k = j + 1 : length(Ind)
        temp = temp + L(Ind(k) - (k - j)) / L(Ind(j)) * whole_displcement(k);
    end 
    whole_displcement(j) = Y(j) - temp;
end