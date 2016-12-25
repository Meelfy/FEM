function whole_displcement = solveEquation(K, P)
% 直接法解整体结点平衡方程
% 输入： 
    % 处理后的整体刚度矩阵K，和
    % 外力P
% 输出：
    % 整体结点位移whole_displcement
% 在readme.md中有此解决方案详细说明

% 一维半带宽矩阵K
Ak  = K{1}; 
%  1 * 2n，n为结点个数
Ind = K{2}; 

% 使用直接法计算
% L 是下三角矩阵
% 逐层计算L的值
% L 的结构与Ak相同
L    = 0 * Ak;
L(1) = Ak(1);

for i = 2:length(Ind)
    for j = i + 1 -(Ind(i) - Ind(i-1))  : i
        temp = 0;
        for k = 1:j-1
            if (i - k) < (Ind(i) - Ind(i-1)) && (j - k) < (Ind(j) - Ind(j-1))
                temp = temp + L(Ind(i) - (i - k)) * L(Ind(j) - (j - k)) / ...
                        L(Ind(k) - (k - k));
            else
            end
        end
        L(Ind(i) - (i - j)) = Ak(Ind(i) - (i - j)) - temp;
    end
end

Y(1) = P(1) / L(Ind(1) - (1 - 1));
for i = 2:length(Ind)
    temp = 0;
    for j = 1 : i -1
        if (i - j) < (Ind(i) - Ind(i-1))
        temp = temp + Y(j) * L(Ind(i) - (i - j)) / L(Ind(i));
        else
        end
    end
    Y(i) = P(i) / L(Ind(i)) - temp;
end

whole_displcement(length(Ind)) = Y(end);
for i = 1:length(Ind) - 1
    j = length(Ind) - i;

    temp = 0;
    for k = j + 1 : length(Ind)
        if (k - j) < (Ind(k) - Ind(k-1))
        temp = temp + L(Ind(k) - (k - j)) / L(Ind(j)) * whole_displcement(k);
        else
        end
    end 
    whole_displcement(j) = Y(j) - temp;
end

