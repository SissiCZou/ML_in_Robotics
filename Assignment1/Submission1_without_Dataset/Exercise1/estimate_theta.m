function a3 = estimate_theta(p1, input_v, input_w, output_theta)
%p1 = 5;
N = size(input_v,1);

big_theta = ones(N,1);
for p = 1:p1
    temp = [input_v.^p input_w.^p (input_v.*input_w).^p];
    big_theta = [big_theta temp];
end 
a3 = ((big_theta')*(big_theta))\(big_theta'*output_theta); 

end