%%
clc
clear all;

%%
% load the data
load('gesture_dataset.mat')
num_pos = size(gesture_l,1);
num_rep = size(gesture_l,2);
num_clus = size(init_cluster_l,1);

%%
% run functions defined below
plot(num_rep, gesture_o, gesture_l, gesture_x, init_cluster_l, init_cluster_o, init_cluster_x)

%%
%k-means, reference: http://www.christianherta.de/kmeans.php

% for 1-th data points, sort the color
data = reshape(gesture_o, [600,3]); % 60*3
dim_data = length(data(1,:)); %3
num_data = length(data(:,1)); %60


% no stopping at start
decrement = inf;
tolerance = 10e-6;
J_old = inf;
steps = 0;

while decrement > tolerance
    dist_min = zeros(num_data,1);
    labels = zeros(num_data,1);
    % E-step
    % assign each datapoint to the closest centroid
    for d = 1:num_data
        dist = zeros(num_clus,1);
        
        for c = 1:num_clus
            dist(c) = (data(d,:) - init_cluster_l(c,:))*(data(d,:) - init_cluster_l(c,:))';
        end 
        
        % assign the d-th data point
        [dist_min(d), labels(d)] = min(dist);
    end 
    % M-step
    for c = 1:num_clus
        init_cluster_l(c,:) = mean(data(labels == c, :));
    end
    % total distortion
    J = sum(dist_min);
    
    % dicrement of distortion
    decrement = J_old - J;
    J_old = J;
    steps = steps + 1;
end 
    





