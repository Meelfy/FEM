function P = getForceP(file_name, file_path)
% 该函数用于读取外力，文件file_name 和文件路径file_path 为输入
% 在input中，外力存储在IforceP.dat中

% 读入外力存至P中，以fx1 fy1 fx2 fy2...的形式
% 输出为一维向量P， 长度为2n 
