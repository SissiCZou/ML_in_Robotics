%%
clc
clear all

%%
% load the data
load('gesture_dataset.mat')
num_pos = size(gesture_l,1);
num_rep = size(gesture_l,2);
%% plot
% why plot is not working???
figure(1);
for i = 1:num_pos
    gesture = gesture_l(i,1,:);
    gesture(:,:,1)
    gesture(:,:,2)
    plot(gesture(:,:,1), gesture(:,:,2))
    hold on;
end
%% a) K-means
