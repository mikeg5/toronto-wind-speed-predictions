clear all; close all; clc;

%User Inputs 
% Lat = 43.652041;
% Long = -79.402233; 
Lat= 43.660416; 
Long= -79.398349;

%Import Location Data 
format long
load('Locations.mat');
proj = projcrs(3857); %define the projection type 

tileName = '50H_NORTH';
locationLats = Locations(strcmp({Locations.tileName},tileName)).latitudes;
locationLongs = Locations(strcmp({Locations.tileName},tileName)).longitudes;
latLongShape = polyshape(locationLongs,locationLats);
% [longLocationCentroid latLocationCentroid] = centroid(latLongShape);

xSketch = Locations(strcmp({Locations.tileName},tileName)).xSketchup;
ySketch = Locations(strcmp({Locations.tileName},tileName)).xSketchup;
sketchupShape = polyshape(xSketch,ySketch);
% [xSketchupCentroid ySketchupCentroid] = centroid(sketchupShape);

% transformLatLong2Sketchup = estimateGeometricTransform([locationLongs' locationLats'],[xSketch' ySketch'],'projective');
[xSketchupCoordinate ySketchupCoordinate] = transformPointsForward(Locations(strcmp({Locations.tileName},tileName)).transformLatLong2Sketchup,Long,Lat);
[x y] = transformPointsForward(Locations(strcmp({Locations.tileName},tileName)).transformLatLong2Sketchup,locationLongs,locationLats);

subplot(1,2,1)
hold on
plot(latLongShape,'FaceColor','blue','FaceAlpha',0.1,'EdgeColor','black','EdgeAlpha',0.5)
% plot(longLocationCentroid,latLocationCentroid,'ok'); 
plot(Long,Lat,'r*');
title('Lat/Long');
subplot(1,2,2)
hold on 
plot(sketchupShape,'FaceColor','red','FaceAlpha',0.1,'EdgeColor','black','EdgeAlpha',0.5);
% plot(xSketchupCentroid,ySketchupCentroid,'ok'); 
plot(xSketchupCoordinate,ySketchupCoordinate,'r*');
plot(x,y,'.k');
title('Sketchup');
