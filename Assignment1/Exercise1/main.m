%%
clc;
clear all;

%%
load('Data.mat');
input_v = Input(1,:)';
input_w = Input(2,:)';

output_x = Output(1,:)';
output_y = Output(2,:)';
output_theta = Output(3,:)';

%%
k = 4; % k-fold validation
[opt_a1, opt_a2, opt_a3, opt_poly1, opt_poly2] = findopt(input_v, input_w, output_x, output_y, output_theta, k);

%%
% store opt_a1, opt_a2, opt_a3 in par
par = cell(1,3);
par{1} = opt_a1;
par{2} = opt_a2;
par{3} = opt_a3;
save params par

%%
% run simulation robot

Simulate_robot(0,0.05);

Simulate_robot(1,0);

Simulate_robot(1,1.05);

Simulate_robot(-1,-0.05)



    