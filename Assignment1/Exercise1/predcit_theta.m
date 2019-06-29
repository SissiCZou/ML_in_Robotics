function pred_theta = predcit_theta(p1, input_v, input_w, a3)
%p1 = 5;
N = size(input_v,1);

big_theta = ones(N,1);

for p = 1:p1
    temp = [input_v.^p input_w.^p (input_v.*input_w).^p];
    big_theta = [big_theta temp];
end 
    
% predict theta 
pred_theta = big_theta*a3; 

end