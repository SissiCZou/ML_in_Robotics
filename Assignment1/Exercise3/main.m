%%
clc
clear all

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
data = squeeze(gesture_o(:,1,:)); % 60*3
dim_data = length(data(1,:)); %3
num_data = length(data(:,1)); %60

%init centriods randomly

min_data = min(data);
max_data = max(data);
diff_data = max_data - min_data; 
% every row is a centriod
centriod = ones(num_clus, dim_data).*rand(num_clus, dim_data);
for i = 1:1:num_clus
    centriod(i,:) = centriod(i,:).*diff_data;
    centriod(i,:) = centriod(i,:) + min_data;
end 

% no stopping at start
pos_diff = 1.0;

while pos_diff > 0:
    
    % E-step
    assign = [];
    
    % assign each datapoint to the closest centroid
    for d = 1:num_data
        min_diff = data(d,:) - centriod(1,:);
        min_diff = min_diff*min_diff'; % distance^2
        cur_assign = 1;
        
        for c = 2:num_clus
            diff2c = (data(d,:) - centriod(c,:));
            diff2c = diff2c*diff2c';
            if min_diff >= diff2c
                cur_assign = c;
                min_diff = diff2c;
            end
        end 
        
        % assign the d-th data point
        assign = [assign; cur_assign];
    end 
    % when to stop
%% plot
% why plot is not working???
function plot(num_rep, gesture_o, gesture_l, gesture_x, init_cluster_l, init_cluster_o, init_cluster_x)
    figure(1);
    color = ['b+', 'k+', 'r+', 'g+', 'm+', 'y+', 'c+'];
    subplot(1,3,1);
    for i = 1:num_rep
        plot3(gesture_l(:,i,1), gesture_l(:,i,2), gesture_l(:,i,3));
        hold on;
    end
    hold on;
    for i = 1:7
        scatter3(init_cluster_l(i,1), init_cluster_l(i,2), init_cluster_l(i,3), color(i), 'LineWidth', 2);
    end
    title('gesture l');
    hold off;

    subplot(1,3,2);
    for i = 1:num_rep
        plot3(gesture_o(:,i,1), gesture_o(:,i,2), gesture_o(:,i,3));
        hold on;
    end
    hold on;
    for i = 1:7
        scatter3(init_cluster_o(i,1), init_cluster_o(i,2), init_cluster_o(i,3), color(i), 'LineWidth', 2);
    end
    title('gesture o');

    subplot(1,3,3);
    for i = 1:num_rep
        plot3(gesture_x(:,i,1), gesture_x(:,i,2), gesture_x(:,i,3));
        hold on;
    end
    hold on;
    for i = 1:7
        scatter3(init_cluster_x(i,1), init_cluster_x(i,2), init_cluster_x(i,3), color(i), 'LineWidth', 2);
    end
    title('gesture x');
end

%% 
% distance to the reference points





