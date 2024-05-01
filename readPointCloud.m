load("map_resolution1.mat");

% map_resol = 0.05; % Adjust resolution based on environment
% map_size_x = 200; % Adjust based on environment
% map_size_y = 200; % Adjust based on environment
% map_size_z = 2; % Adjust based on environment
% finalmap = robotics.OccupancyGrid(map_size_x,map_size_y,map_size_z);


for i = 1:length(map_resolution)
    ptCloud = map_resolution{i};
    % Initialize variables for map creation
    
    if i == 1
        global mapPoints;
        mapPoints = ptCloud;
    end

    [tform,movingReg,rmse] = pcregistericp(ptCloud,mapPoints);

    ptCloudTformed = pctransform(movingReg, tform);

    mapPoints = ptCloudTformed;

%     for j = 1:length(mapPoints.Location)
%         point_x = mapPoints.Location(j, 1);
%         point_y = mapPoints.Location(j, 2);
%     
%         % Convert point coordinates to map indices (adjust based on data structure)
%         map_index_x = floor((point_x - tform.Translation(1,1)- 0) / map_resol) + 1;
%         map_index_y = floor((point_y - tform.Translation(1,2)- 0) / map_resol) + 1;
% 
%         % Check for valid indices within map boundaries
%         if and ( and( map_index_x > 0,map_index_x <= 500) , ...
%                  and(map_index_y > 0 , map_index_y <= 500))
%             % Update occupancy based on sensor reading (likely 0 for free, 1 for occupied)
%             updateOccupancy(finalmap,[map_index_x map_index_y],1);
%         end
%     end
%     show(finalmap)

    figure(1)
    pcshow(mapPoints,AxesVisibility='on');
    title('Transformed Point Clouds');
    xlabel("X")
    ylabel("Y")
    zlabel("Z")
    drawnow

    figure(2)
    pcshow(movingReg,AxesVisibility='on');
    title('Original Point Clouds');
    xlabel("X")
    ylabel("Y")
    zlabel("Z")
    drawnow
    pause(1);
end