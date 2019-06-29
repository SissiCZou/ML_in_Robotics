function [a1, a2] = estimate_xy(p1, input_v, input_w, output_x, output_y)

N = size(input_v,1);

big_X = ones(N,1);
big_Y = ones(N,1); 

for p = 1:p1
    temp = [input_v.^p input_w.^p (input_v.*input_w).^p];
    big_X = [big_X temp];
    big_Y = [big_Y temp];
end

a1 = ((big_X.')*(big_X))\(big_X.'*output_x); 

a2 = ((big_Y.')*(big_Y))\(big_Y.'*output_y); 

end
