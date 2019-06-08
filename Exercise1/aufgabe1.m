%%
% a) y = w*x
input_x = [-3,-1,0,2,4];
output_y = [-4,1,1,2,6];
n = size(input_x,2);
para = sum(input_x.*output_y)/sum(input_x.^2);
y_predict = para*input_x;
ssr = (1/n)*sum((output_y - y_predict).^2);

%%
% b) y = w_0 + w_1*x 
w_0 = (sum(output_y)*sum(input_x.^2) - sum(input_x)*sum(input_x.*output_y))...
    /(n*sum(input_x.^2) - (sum(input_x))^2);
w_1 = (n*(sum(input_x.*output_y)) - sum(input_x)*sum(output_y))...
    /(n*sum(input_x.^2) - (sum(input_x))^2);
y_predict1 = w_0 + w_1*input_x;
ssr1 = (1/n)*sum((y_predict1 - output_y).^2);
plot(input_x, output_y, '*',input_x,y_predict,'o', input_x, y_predict1,'+');
legend('original', 'predict', 'predict1');

%%
% gradient descent 
%big_X = [ones(n,1) input_x']
%opt = inv(big_X'*big_X)*big_X'*output_y';
w = 0;
for j = 1:2
    alpha = 0.1;
    f_x = w.*input_x;
    w = w- alpha*(1/n)*sum((f_x - output_y)'.*input_x);
    fprintf('%d is now after %i itereation \n', w, j);
end


