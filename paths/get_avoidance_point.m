function [ avoid_id, avoid_dist, avoid_pos, is_succeed ] = get_avoidance_point( data, user_id, trial_id, crowd_radius, agent_radius, draw )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    path = data{user_id, trial_id}.path;
    angle_thresh = 0.02;
    speed_thresh = 0.01;
    startframe = 60;
    
    traj_len = size(path, 1);
    [angle, speed] = cart2pol(path(:, 4), path(:, 6));
    anglepolediff = diff(angle);
    speedpolediff = diff(speed);
    zerovelIDs = find(speed < 0.01);
    for i=1:size(zerovelIDs, 1)
        minID = max(1, zerovelIDs(i) - 5);
        maxID = min(traj_len - 1, zerovelIDs(i) + 5);
        anglepolediff(minID : maxID) = 0;        
        speedpolediff(minID : maxID) = 0;
    end
    
    
    % set a window to detect variance of data
    step_len = 5;
    window_size = 30;
    
    avoid_id = 0;
    for i= startframe : step_len : traj_len - 1 - window_size / 2
        endID = min(traj_len - 1, i + window_size / 2);
        startID = max(startframe, i - window_size / 2);
        variance = std(anglepolediff(startID : endID));
        avg_speed = mean(speed(startID : endID));
        if abs(variance) > angle_thresh && abs(avg_speed) > speed_thresh
            % found avoidance point
            avoid_id = i;
            break;
        end
    end
    dist = zeros(traj_len, 1);
    for i=startframe:traj_len
        diff_vec = [path(i, 1) - path(i, 7), path(i, 3) - path(i, 9)];
        dist(i) = sqrt(dot(diff_vec, diff_vec));
    end
    if(avoid_id > 0)
        avoid_dist = dist(avoid_id);
        avoid_pos = path(avoid_id, 1:3);
    else
        avoid_dist = -1;
        avoid_pos = zeros(1, 3);
    end
    min_dist = min(dist);
    if min_dist < crowd_radius + agent_radius
        is_succeed = 0;
    else
        is_succeed = 1;
    end
    
    if draw == 1 % display static path
        hpath = figure;
        display(['inter-person distance: ', int2str(data{user_id, trial_id}.ipdist), ' direction: ', int2str(data{user_id, trial_id}.theta)]);
        title('path');
        subplot(3,1,1);
        plot(path(:, 3), path(:, 1), 'r-');
        hold on;
        plot(avoid_pos(3), avoid_pos(1), 'k*');
        axis([-60, 40, -50, 20]);
        %axis equal;
        
        %[angle, speed] = cart2pol(path(:, 4), path(:, 6));
        %anglepolediff = diff(angle);
        subplot(3,1,2);
        hold on;
        plot(startframe:traj_len-1, anglepolediff(startframe:end), 'b-');
        if avoid_id > 0
            plot(avoid_id, anglepolediff(avoid_id), 'k*');
        end
        
        subplot(3,1,3);
        hold on;
        plot(startframe:traj_len, speed(startframe:end), 'b-');
        if avoid_id > 0
            plot(avoid_id, speed(avoid_id), 'k*');
        end
    end
end

