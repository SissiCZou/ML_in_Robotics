function labels = kmeansclus(gesture, init_cluster)
%k-means, reference: http://www.christianherta.de/kmeans.php
% for 1-th data points, sort the color
data = reshape(gesture,600,3); % 600*3
num_data = length(data(:,1)); %600
num_clus = size(init_cluster,1); % 7
center_clus = init_cluster; % should be updated
stop_decrement = 10e-6;
decrement = inf;
steps = 0;
cost_old = inf; 
while decrement > stop_decrement

    dist_min = zeros(num_data,1);
    labels = zeros(num_data,1);

    % E-step
    % assign each datapoint to the closest centroid
    for d = 1:num_data
        dist = zeros(num_clus,1);
        % euclidean distance
        for c = 1:num_clus
           dist(c) = (data(d,:)- center_clus(c,:))*(data(d,:)- center_clus(c,:))';
        end 
        % get min distance and assign cluster
        [dist_min(d), labels(d)] = min(dist);

    end 

    % M-step
    % update the mean of clusters
    for c = 1:num_clus
       center_clus(c,:) = mean(data(labels == c,:));
    end

    % total distortion
    cost = sum(dist_min);

    % decrement of distortion
    decrement = cost_old - cost;
    cost_old = cost;
    steps = steps + 1; 

end
end


