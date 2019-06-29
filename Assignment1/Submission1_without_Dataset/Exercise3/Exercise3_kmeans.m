function Exercise3_kmeans()

% load the data
load('gesture_dataset.mat')
num_pos = size(gesture_l,1);
num_rep = size(gesture_l,2);

%%
% run functions defined below
%dataplot(num_rep, gesture_o, gesture_l, gesture_x, init_cluster_l, init_cluster_o, init_cluster_x)

%%
% k-means
tic
labels_gesture_l = kmeansclus(gesture_l, init_cluster_l);
labels_gesture_o = kmeansclus(gesture_o, init_cluster_o);
labels_gesture_x = kmeansclus(gesture_x, init_cluster_x);
toc
%%
% plot a)
figure(1)
plotclus(gesture_l, labels_gesture_l);
title('Kmeans clustering for gesture l');
saveas(gcf, 'a11.png');
figure(2)
plotclus(gesture_o, labels_gesture_o);
title('Kmeans clustering for gesture o');
saveas(gcf, 'a12.png');
figure(3)
plotclus(gesture_x, labels_gesture_x);
title('Kmeans clustering for gesture x');
saveas(gcf, 'a13.png');

end