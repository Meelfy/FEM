function area = calAera(element_X, element_Y)
% 这个函数返回三角形单元的面积
    area = 0.5*det([ones(3, 1) element_X element_Y]);
    assert(area > 0, 'Area is not positive.\nPlease check the input!')
end