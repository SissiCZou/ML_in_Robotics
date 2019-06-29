function Exercise3_nubs()

% load the data
load('gesture_dataset.mat')
num_pos = size(gesture_l,1);
num_rep = size(gesture_l,2);

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



end

