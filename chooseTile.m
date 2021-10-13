function [Tile_Name, xCoordinate, yCoordinate] = chooseTile(Lat,Long)
% This function will take Lat & Long as input and return TileName, xCoord, yCoord

load('C:\windApp\Update Locations\Locations.mat');

Num_Tiles = size(Locations,2); %Determines the number of tiles defined in Locations.mat 

% %Uncomment this to draw tiles
% for i=1:Num_Tiles
%     hold on
%     Shape = polyshape(Locations(i).longitudes, Locations(i).latitudes); %Defines polygon for each tile based on lat and long coordinates
%     plot(Shape,'FaceColor','blue','FaceAlpha',0.1,'EdgeColor','black','EdgeAlpha',0.5)
%     [x y] = centroid(Shape);
%     T=text(x-0.0025,y,Locations(i).tileName); %add tile name to the centroid of the shape
%     set(T,'fontsize', 8);
%     set(T,'Interpreter','none');
% end 
% 
% plot(Long,Lat,'r*') %Plots the user input location as a red asterisk
% xlabel('Longitude')
% ylabel('Latitude')
% set(groot,{'DefaultAxesXColor','DefaultAxesYColor','DefaultAxesZColor'},{'k','k','k'});
% hold off 
  
for i=1:Num_Tiles
    %determines which tile the Lat,Long is in (1 = In or On Tile)
    [in on] = inpolygon(Lat,Long,Locations(i).latitudes,Locations(i).longitudes); 
    
    if in==1 || on==1
        Tile_Name = upper(Locations(i).tileName);
        TileID=i; %Number representing the chosen tile
        [xCoordinate yCoordinate] = transformPointsForward(Locations(TileID).transformLatLong2Sketchup,Long,Lat);
        break
    end 
end 

end