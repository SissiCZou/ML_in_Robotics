function par = Exercise1(k)
load('Data.mat');
input_v = Input(1,:)';
input_w = Input(2,:)';

output_x = Output(1,:)';
output_y = Output(2,:)';
output_theta = Output(3,:)';

%%
% k = 2; 
p = 6; 
[opt_a1, opt_a2, opt_a3, opt_poly1, opt_poly2] = findopt(input_v, input_w, output_x, output_y, output_theta, k,p);
%fprintf('The optimal p1 is %i and p2 %i from k-fold %i and p %i is \n', opt_poly1 , opt_poly2 , k, p);
%%
% use whole data set
optt_a3 = estimate_theta(opt_poly2, input_v, input_w, output_theta);
[optt_a1, optt_a2] = estimate_xy(opt_poly1, input_v, input_w, output_x, output_y);
%%
% store opt_a1, opt_a2, opt_a3 in par to the right opt. poly
par = cell(1,3);
par{1} = optt_a1;
par{2} = optt_a2;
par{3} = optt_a3;

end
% save params par
%%
% Simulate_robot(0.5, -0.03);

%%
% run simulation robot
% 
% Simulate_robot(0,0.05);
% saveas(gcf, 'sim1.png');
% Simulate_robot(1,0);
% saveas(gcf, 'sim2.png');
% Simulate_robot(1,0.05);
% saveas(gcf, 'sim3.png');
% Simulate_robot(-1,-0.05)
% saveas(gcf, 'sim4.png');



    