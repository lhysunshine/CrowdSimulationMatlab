function data = GenerateAgentsInCycle(radius, steplength, center)
    data = [];
    for x=-radius : steplength : radius
        for y=-radius : steplength : radius
            if x*x + y*y <= radius * radius
                data = [data; x+center(1), y+center(2)];
            end
        end
    end
    %plot(data(:, 1), data(:, 2), 'r.');
    %hold on;
    %rectangle('Position',[center(1)-radius,center(2)-radius,2*radius,2*radius],'Curvature',[1,1]) 
end