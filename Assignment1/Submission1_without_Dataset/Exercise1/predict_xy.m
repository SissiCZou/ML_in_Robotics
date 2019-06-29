function [pred_x, pred_y] = predict_xy(p1, input_v, input_w, a1, a2)

N = size(input_v,1);

big_X = ones(N,1);
big_Y = ones(N,1); 

for p = 1:p1
    temp = [input_v.^p input_w.^p (input_v.*input_w).^p];
    big_X = [big_X temp];
    big_Y = [big_Y temp];
end
%predict x, y
pred_x = big_X*a1;
pred_y = big_Y*a2;

end