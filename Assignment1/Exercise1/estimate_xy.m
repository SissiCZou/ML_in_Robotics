function [a1, a2] = estimate_xy(p1, input_v, input_w, output_x, output_y)

N = size(input_v,1);

temp1 = 0;
temp2 = 0;
temp3 = 0; 
temp4 = 0;

for p = 1:p1
    temp1 = temp1 + input_v.^p;
    temp2 = temp2 + input_w.^p;
    temp3 = temp3 + (input_v.*input_w).^p;
    temp4 = 3*(p-1)*(input_v.^p + input_w.^p + (input_v.*input_w).^p) + temp4;
end
    
big_X = [ones(N,1), temp1, temp2, temp3];
new_x = output_x - temp4; 
a1 = (inv((big_X.')*(big_X))*(big_X.'))*new_x; 
%predict_x = big_X*a1 + temp4;

big_Y = [ones(N,1), temp1, temp2, temp3];
new_y = output_y - temp4; 
a2 = (inv((big_Y.')*(big_Y))*(big_Y.'))*new_y; 
%predict_y = big_Y*a2 + temp4;
%error_position = (1/N)*sqrt(sum((predict_x - output_x).^2) + sum((predict_y - output_y).^2));

end
