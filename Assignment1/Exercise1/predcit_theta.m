function pred_theta = predcit_theta(p1, input_v, input_w, a3)
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
    temp4 = 3*(p-1)*(input_v.^p + input_w.^p + (input_v.*input_w).^p) + temp4;
end
    
big_theta = [ones(N,1), temp1, temp2, temp3];
pred_theta = big_theta*a3 + temp4; % use test set to calculate predict

%error_orientation = (1/N)*sqrt(sum((predict_theta - output_theta).^2));

end