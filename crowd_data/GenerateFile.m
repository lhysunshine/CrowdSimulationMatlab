initcenter = zeros(8, 2);
goalcenter = zeros(8, 2);
rhos = [1, 2, 4];
theta = 0:size(initcenter, 1)-1;
theta = theta / size(initcenter, 1) * 2 * pi;
for i=1:size(initcenter, 1)
    initcenter(i, :) = ([cos(theta(i)), sin(theta(i)); -sin(theta(i)), cos(theta(i))] * [0; -40])';
    goalcenter(i, :) = ([cos(theta(i)), sin(theta(i)); -sin(theta(i)), cos(theta(i))] * [0; 20])';
    %plot(initcenter(i, 1), initcenter(i, 2), 'r.');
    %hold on;
    %plot(goalcenter(i, 1), goalcenter(i, 2), 'bo');
    %pause;
end
for i=1:size(initcenter, 1)
    for j=1:length(rhos)
        init = GenerateAgentsInCycle(8, rhos(j), initcenter(i, :));
        goal = GenerateAgentsInCycle(8, rhos(j), goalcenter(i, :));
        filename = ['crowd_', int2str(j), '_', int2str(i), '.txt'];
        saveInfo(filename, init, goal);
    end
end
