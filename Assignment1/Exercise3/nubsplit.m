function [center_data, labels]= nubsplit(gesture)
K = 7;
data = reshape(gesture, 600, 3);
num_data = size(data,1);
labels = ones(num_data,1);
% initial
center_data = zeros(K,3);
center_data(1,:) = mean(data);
cost = [];
v = [0.08, 0.05, 0.02];

for k = 1:K-1
    
    % distortion
    cost = zeros(k,1);
    for kk = 1:k
        for n = 1:num_data
            if labels(n)~=kk
                continue;
            end
            dist = (data(n,:) - center_data(kk,:))*(data(n,:) - center_data(kk,:))';
            cost(kk) = cost(kk) + dist
        end 
    end
    
    % choose a class with max cost
    [~, ind] = max(cost);
    
    
    %labels(k) = ind;
    % split the class into subclasses
    for d = 1: num_data
        if labels(d) ~= ind
            continue
        end
        dist1 = (data(d,:) - (center_data(ind,:) + v))*(data(d,:) - (center_data(ind,:) + v))';
        dist2 = (data(d,:) - (center_data(ind,:) - v))*(data(d,:) - (center_data(ind,:) - v))';
        if dist1 <= dist2
            labels(d) = ind;
        else
            labels(d) = k +1; 
        end
    end 
    
    % update center 
    center_data(ind,:) = mean(data(labels == ind,:));
    center_data(k+1,:) = mean(data(labels == k+1,:));
    
end