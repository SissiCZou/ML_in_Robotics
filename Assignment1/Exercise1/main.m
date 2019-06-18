load('Data.mat');
input_v = Input(1,:)';
input_w = Input(2,:)';

output_x = Output(1,:)';
output_y = Output(2,:)';
output_theta = Output(3,:)';

N = size(input_v,1);

%%
% estimate for theta
error_ori = [];
error_pos = [];
para_theta = [];
para_x = [];
para_y = [];

% loop for different polynomial p from 1 to 6
for p1 = 1:6
    [error_o, a3] = estimate_theta(p1, input_v, input_w, output_theta);
    [error_p, a1, a2] = estimate_xy(p1, input_v, input_w, output_x, output_y);
    error_ori = [error_ori;error_o];
    para_theta = [para_theta a3];
    error_pos = [error_pos;error_p];
    para_x = [para_x a1];
    para_y = [para_y a2];
    fprintf('The orientation error is %d and position error is %d at %i th iteration \n', error_o, error_p, p1);
   
end 

opt_poly2 = find(error_ori == min(error_ori));
opt_a3 = para_theta(:, opt_poly2);

opt_poly1 = find(error_pos == min(error_pos));
opt_a1 = para_x(:, opt_poly1);
opt_a2 = para_y(:, opt_poly1);
%%
% store opt_a1, opt_a2, opt_a3 in par
par = cell(1,3);
par{1} = opt_a1;
par{2} = opt_a2;
par{3} = opt_a3;
save params par
%% funtions to calculate estimated parameters if p is known

% for theta
function [error_orientation, a3] = estimate_theta(p1, input_v, input_w, output_theta)
%p1 = 5;
N = size(input_v,1);

temp1 = 0;
temp2 = 0;
temp3 = 0; 
temp4 = 0;

for p = 1:p1
    temp1 = temp1 + input_v.^p;
    temp2 = temp2 + input_w.^p;
    temp3 = temp3 + (input_v.*input_w).^p;
    temp4 = temp1+temp2+temp3;
end
    
big_theta = [ones(N,1), temp1, temp2, temp3];
new_theta = output_theta - temp4; 

a3 = (inv((big_theta.')*(big_theta))*(big_theta.'))*new_theta; 
predict_theta = big_theta*a3 + temp4;
error_orientation = (1/N)*sqrt(sum((predict_theta - output_theta).^2));

end




% for x, and y 
function [error_position, a1, a2] = estimate_xy(p1, input_v, input_w, output_x, output_y)

N = size(input_v,1);

temp1 = 0;
temp2 = 0;
temp3 = 0; 
temp4 = 0;

for p = 1:p1
    temp1 = temp1 + input_v.^p;
    temp2 = temp2 + input_w.^p;
    temp3 = temp3 + (input_v.*input_w).^p;
    temp4 = temp1+temp2+temp3;
end
    
big_X = [ones(N,1), temp1, temp2, temp3];
new_x = output_x - temp4; 
a1 = (inv((big_X.')*(big_X))*(big_X.'))*new_x; 
predict_x = big_X*a1 + temp4;

big_Y = [ones(N,1), temp1, temp2, temp3];
new_y = output_y - temp4; 
a2 = (inv((big_Y.')*(big_Y))*(big_Y.'))*new_y; 
predict_y = big_Y*a2 + temp4;

error_position = (1/N)*sqrt(sum((predict_x - output_x).^2) + sum((predict_y - output_y).^2));

end



    