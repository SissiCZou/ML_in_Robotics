function [min_val,min_ind] = Exercise2(max_d)
%%
% load the data 
train_images = loadMNISTImages('train-images.idx3-ubyte');
train_labels = loadMNISTLabels('train-labels.idx1-ubyte');
test_images = loadMNISTImages('t10k-images.idx3-ubyte');
test_labels = loadMNISTLabels('t10k-labels.idx1-ubyte');
n_train = size(train_images,2);
n_test = size(test_images,2);
%%
% mean and variance
% mean_images = transpose(mean(train_images')); % 784*1
mean_images = mean(train_images,2);
norm_images = train_images - mean_images;
var_images = cov((norm_images)');
[eig_vec, eig_val] = eig(var_images);
[~,ind] = sort(diag(eig_val),'descend');
eig_vec = eig_vec(:,ind);
% the ith column of the V matrix is the eigen vector corresponding to the ith eigenvlue
%%
% test images should be also nomralised
test_images = test_images - mean_images;
%%
% define variables
%max_d = 60;
num_class = 10;
im_mean = cell(1);
im_norm = cell(1);
im_var = cell(1);
conf_matrix = cell(max_d, 1);
err = zeros(max_d,1); 
%%
% PCA with fixed d and MLE classifier
for d = 1:max_d
    temp = eig_vec(:,1:d);
    likelihood = zeros(num_class, n_test);
    % for each class, MLE by gaussian
    for i = 1:num_class
        % PCA: project all train images from one class 
        project_images = temp'*norm_images(:, train_labels == (i-1)); % d* ?
        % mean, variance
        im_mean{i} = mean(project_images, 2); %d*d
        im_norm{i} = project_images - im_mean{i};
        im_var{i} = cov(im_norm{i}'); %d*d
        % PCA: for test images
        project_test = temp'*test_images;
        % likelihood
        likelihood(i,:) = mvnpdf(project_test', im_mean{i}', im_var{i});
    end
    
    % assign class to test images
    [~, predict_labels] = max(likelihood); %row vector
    predict_labels = (predict_labels -1)'; 
    % error of misclassification
    err(d) = sum(test_labels ~=  predict_labels);
    % confusion  matrix
    conf_matrix{d} = confusionmat(test_labels, predict_labels);
end
%%
err = 100*err/n_test; % in percentage
%%
figure(1);
plot(1:max_d, err);
title('Classification error');

% output the result
[min_val, min_ind] = min(err);
fprintf('The minimum error of test result is %.2f%% by d = %i\n',min_val, min_ind);
% plot confusion matrix
helperDisplayConfusionMatrix(conf_matrix{min_ind}); 
end
        
        
        
        