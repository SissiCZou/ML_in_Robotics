function [a1, a2, a3, opt_poly1, opt_poly2] = findopt(input_v, input_w, output_x, output_y, output_theta, k)

error_ori = [];
error_pos = [];

N = size(input_v,1);
% random get the index
%index = crossvalind('Kfold', N, k);
v = (1:k)'; 
index = repelem(v,N/k);
% loop for different polynomial p from 1 to 6
for p1 = 1:6
     % initial error and a1, a2, a3
    error_o = 0;
    error_p = 0;
    % cross validation to get 1/5 of the data
    for i = 1:k
        ind_test = find(index == i);
        train_ind = find(index ~= i);
        % training for parameters
        a3 = estimate_theta(p1, input_v(train_ind), input_w(train_ind), output_theta(train_ind));
        [a1, a2] = estimate_xy(p1, input_v(train_ind), input_w(train_ind), output_x(train_ind), output_y(train_ind));
        
        % use trained parameters and test data to compute the predicted
        pred_theta = predcit_theta(p1, input_v(ind_test), input_w(ind_test), a3);
        [pred_x, pred_y] = predict_xy(p1, input_v(ind_test), input_w(ind_test), a1, a2);
        
        % prediction error
        %n = size(ind_test,1);
        temp_o = sqrt((output_theta(ind_test) - pred_theta)'*(output_theta(ind_test) - pred_theta));
        temp_xy = sqrt(((output_x(ind_test) - pred_x)'*(output_x(ind_test) - pred_x) + (output_y(ind_test) - pred_y)'*(output_y(ind_test) - pred_y)));
        error_o = error_o + temp_o;
        error_p = error_p + temp_xy;    
    end 
    % store error for each p
    error_ori = [error_ori;error_o];
    error_pos = [error_pos;error_p];   
end 

opt_poly2 = find(error_ori == min(error_ori));
% find optimal p where the error is minimum
opt_poly1 = find(error_pos == min(error_pos));

end
