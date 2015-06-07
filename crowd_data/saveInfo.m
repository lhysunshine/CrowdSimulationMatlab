function saveInfo (filename, init, goal)
    fid=fopen(filename, 'w');
    if(size(init, 1) ~= size(goal, 1))
        display('size of start and goal are not consistent.');
    end
    for i=1:size(init, 1)
        fprintf(fid, '%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t%.2f\t', init(i, 1), 10, init(i, 2), goal(i, 1), 10, goal(i, 2));
        fprintf(fid, '%d\t%d\t%d\t%d\t%.2f\t%d\t%.2f\t%.2f\n', 5, 10, 20, 20, 0.3, 2, 0, 0);
    end
    fclose(fid);
end