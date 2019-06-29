function dataplot(num_rep, gesture_o, gesture_l, gesture_x, init_cluster_l, init_cluster_o, init_cluster_x)
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
