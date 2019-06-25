%%
clc
clear all

%%
% load the data
load('gesture_dataset.mat')
num_pos = size(gesture_l,1);
num_rep = size(gesture_l,2);

%%
% run functions defined below
dataplot(num_rep, gesture_o, gesture_l, gesture_x, init_cluster_l, init_cluster_o, init_cluster_x)


%%
% k-means
%tic
[steps_gesture_l, labels_gesture_l] = kmeansclus(gesture_l, init_cluster_l);
[steps_gesture_o, labels_gesture_o] = kmeansclus(gesture_o, init_cluster_o);
[steps_gesture_x, labels_gesture_x] = kmeansclus(gesture_x, init_cluster_x);
%toc
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

%%
% uniform-random binary split
tic
[clus_center_l, labels_gesture_l] = nubsplit(gesture_l);
[clus_center_o, labels_gesture_o] = nubsplit(gesture_o);
[clus_center_x, labels_gesture_x] = nubsplit(gesture_x);
toc
%%
% plot b)
figure(1)
plotclus(gesture_l, labels_gesture_l);
title('nubsplit clustering for gesture l');
saveas(gcf, 'b21.png');
figure(2)
plotclus(gesture_o, labels_gesture_o);
title('nubsplit clustering for gesture o');
saveas(gcf, 'b22.png');
figure(3)
plotclus(gesture_x, labels_gesture_x);
title('nubsplit clustering for gesture x');
saveas(gcf, 'b23.png');