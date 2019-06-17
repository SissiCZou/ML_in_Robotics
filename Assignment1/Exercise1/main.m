load('Data.mat');
input_v = Input(1,:);
input_w = Input(2,:);
N = size(input_v,2);

%%
% estimate for theta
output_theta = Output(3,:);

% ohne cross-validation
big_theta = []; 
for i = 1: N
    p = i;
    predict_theta = [1, sum(input_v(1:p)), sum(input_w(1:p)),...
        sum(input_v(1:p).*input_w(1:p)), ...
        sum(3*(p-1)*( input_v(1:p) + input_w(1:p) + input_v(1:p).*input_w(1:p) ))];
    big_theta = [big_theta;predict_theta];
   
end 

    