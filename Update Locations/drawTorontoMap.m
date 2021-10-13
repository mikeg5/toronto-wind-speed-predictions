close all; clear all; clc

load('Locations.mat');
S = shaperead('tiles.shp');
proj = projcrs(3857); %define the projection properties (EPSG Code = 3857 = Web Mercator)

for i=1:length(S)
    xx = S(i).X;
    yy = S(i).Y;
    map(i).tileName = S(i).Tile_Name;
    [map(i).lat map(i).long] = projinv(proj,xx,yy);
end

gx = geoaxes;
geobasemap(gx,'satellite')
for i=1:length(map)
    if Locations(i).xSketchup
        shape = polyshape(map(i).long,map(i).lat);
        %     [xCent yCent] = centroid(shape);
        hold on
        geoplot(gx,map(i).lat,map(i).long,'-w','LineWidth',2);
        %     t = text(yCent,xCent-0.002,map(i).tileName);
        %     t.Interpreter = 'none';
        %     t.FontSize = 4;
        %     t.Color = 'white';
        %     t.FontWeight = 'bold';
        %     t.BackgroundColor = 'black';
    end
end
