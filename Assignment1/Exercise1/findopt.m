function [opt_a1, opt_a2, opt_a3, opt_poly1, opt_poly2] = findopt(input_v, input_w, output_x, output_y, output_theta, k,p)

error_ori = [];
error_pos = [];

N = size(input_v,1);
% random get the index
%index = crossvalind('Kfold', N, k);
v = (1:k)'; 
index = repelem(v,N/k);
% loop for different polynomial p from 1 to 6
opt_a1 = cell(1,p);
opt_a2 = cell(1,p);
opt_a3 = cell(1,p);

for p1 = 1:p
     % initial error and a1, a2, a3
    error_o = 0;
    error_p = 0;
    a_theta = [];
    a_x = [];
    a_y = [];
    % cross validation to get 1/5 of the data
    for i = 1:k
        ind_test = find(index == i);
        train_ind = find(index ~= i);
        % training for parameters
        a3 = estimate_theta(p1, input_v(train_ind), input_w(train_ind), output_theta(train_ind));
        [a1, a2] = estimate_xy(p1, input_v(train_ind), input_w(train_ind), output_x(train_ind), output_y(train_ind));
        
        % store the estimated parameter a 
        a_theta = [a_theta a3];
        a_x = [a_x a1];
        a_y = [a_y a2];
        
        % use trained parameters and test data to compute the predicted
        pred_theta = predcit_theta(p1, input_v(ind_test), input_w(ind_test), a3);
        [pred_x, pred_y] = predict_xy(p1, input_v(ind_test), input_w(ind_test), a1, a2);
        
        % prediction error
        %temp_o = (output_theta(ind_test) - pred_theta)'*(output_theta(ind_test) - pred_theta);
        %temp_xy = ((output_x(ind_test) - pred_x)'*(output_x(ind_test) - pred_x) + (output_y(ind_test) - pred_y)'*(output_y(ind_test) - pred_y));
        n = size(input_v(ind_test),1);
        temp_o = sum(sqrt( ( output_theta(ind_test) - pred_theta).^2 ))/n;
        temp_xy = sum( sqrt( (output_x(ind_test) - pred_x).^2 + (output_y(ind_test) - pred_y).^2 ))/n;
        
        % calculate the test error and summerize them 
        error_o = error_o + temp_o;
        error_p = error_p + temp_xy;    
    end
    
    % store for each p an averaged mean estimated a from k-fold
    opt_a1{p1}= mean(a_theta,2);
    opt_a2{p1} = mean(a_x,2);
    opt_a3{p1} = mean(a_y,2);

    % store error for each p
    error_ori = [error_ori;sqrt(error_o)/N];
    error_pos = [error_pos;sqrt(error_p)/N];   
end 

opt_poly2 = find(error_ori == min(error_ori));
% find optimal p where the error is minimum
opt_poly1 = find(error_pos == min(error_pos));

end
