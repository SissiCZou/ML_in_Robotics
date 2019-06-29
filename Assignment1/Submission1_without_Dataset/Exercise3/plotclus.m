function plotclus(gesture, labels_gesture)
data = reshape(gesture, 600, 3);
data = data(:,1:2);
num_data = size(data,1);
color = ['b', 'k', 'r', 'g', 'm', 'y', 'c'];
for i = 1:num_data
    scatter(data(i,1), data(i,2), color(labels_gesture(i,:)));
    hold on;
end
end