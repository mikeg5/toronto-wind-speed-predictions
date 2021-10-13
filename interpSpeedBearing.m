function [CFDMeanSpeeds,CFDPeakSpeeds,CFDMeanBearings]=interpSpeedBearing(AOA,C,time,height,Tile_Name,xCoordinate,yCoordinate)
%This function will interpolate the velocity contour 

load('C:\windApp\Update Locations\Locations.mat');
n = find(strcmp({Locations.tileName},Tile_Name));
planeHeights = Locations(n).planeHeights(2,:);
allHeights = sort([planeHeights height]);

heightIndx = find(allHeights == height);
[minVal,closestIndx] = min(abs(height-planeHeights));
    
patchHeight = planeHeights(closestIndx);
lowerPatch = allHeights(heightIndx-1);
upperPatch = allHeights(heightIndx+1);
interpolationFactor = (height-lowerPatch)/(upperPatch-lowerPatch);
%interpolatedVel = lowerVel + interpolationFactor(upperVel-lowerVel)

%Define the current folder
Path=pwd;
%Define Tile Folder
Tile_Folder = strcat(Tile_Name,'_CSV');

%Define CSV File Name
if AOA(time) < 100
    %add leading zero
    patchFName = strcat(Tile_Name,'_',sprintf('%03d',AOA(time)),'_z',num2str(patchHeight),'.csv'); 
    lowerFName = strcat(Tile_Name,'_',sprintf('%03d',AOA(time)),'_z',num2str(lowerPatch),'.csv'); 
    upperFName = strcat(Tile_Name,'_',sprintf('%03d',AOA(time)),'_z',num2str(upperPatch),'.csv'); 
else 
    patchFName = strcat(Tile_Name,'_',num2str(AOA(time)),'_z',num2str(patchHeight),'.csv'); 
    lowerFName = strcat(Tile_Name,'_',num2str(AOA(time)),'_z',num2str(lowerPatch),'.csv'); 
    upperFName = strcat(Tile_Name,'_',num2str(AOA(time)),'_z',num2str(upperPatch),'.csv'); 
end

%%
%load lower patch data
cd('C:\CSV'); %Replace with Database location
cd(Tile_Folder)
ExcelData=[];
ExcelData = readmatrix(lowerFName); %reads csv file
lastrow = size(ExcelData,1); % number of rows in excel data sheet
lastcol = size(ExcelData,2); %number of columns in excel data sheet
rowbreak = find(all(isnan(ExcelData),2)); %finds the NaN row
lastnode = rowbreak-1; %row of last node
firstface = rowbreak+1; %row of first face
lowerVertices=ExcelData(1:lastnode,2:3);
lowerVelocity=ExcelData(1:lastnode,6).*C(time); %x,y coordinate of center of face
lowerTKE=ExcelData(1:lastnode,5).*C(time);
lowerVxy=ExcelData(1:lastnode,7:8).*C(time);
if patchHeight == lowerPatch
    F=ExcelData(firstface:lastrow,1:lastcol);
    Faces=F+1;
    Vertices=ExcelData(1:lastnode,2:3);
end
%load upper patch data
ExcelData = [];
ExcelData = readmatrix(upperFName); %reads csv file
lastrow = size(ExcelData,1); % number of rows in excel data sheet
lastcol = size(ExcelData,2); %number of columns in excel data sheet
rowbreak = find(all(isnan(ExcelData),2)); %finds the NaN row
lastnode = rowbreak-1; %row of last node
firstface = rowbreak+1; %row of first face
upperVelocity=ExcelData(1:lastnode,6).*C(time);
upperVertices=ExcelData(1:lastnode,2:3); %x,y coordinate of center of face
upperTKE=ExcelData(1:lastnode,5).*C(time);
upperVxy=ExcelData(1:lastnode,7:8).*C(time);
if patchHeight == upperPatch
    F=ExcelData(firstface:lastrow,1:lastcol);
    Faces=F+1;
    Vertices=ExcelData(1:lastnode,2:3);
end
cd(Path)

searchRadius = 1.5;
pointRadius = [(xCoordinate-searchRadius:0.25:xCoordinate+searchRadius)',(yCoordinate-searchRadius:0.25:yCoordinate+searchRadius)']; %take a radius of 2 around coordinate
lowerVelocitiesNearLocation = lowerVelocity(dsearchn(lowerVertices, pointRadius)); %find velocities within that sample radius
upperVelocitiesNearLocation = upperVelocity(dsearchn(upperVertices, pointRadius)); 
lowerVxyNearLocation = lowerVxy(dsearchn(lowerVertices, pointRadius),:); %find V_xy within the sample radius
upperVxyNearLocation = lowerVxy(dsearchn(upperVertices, pointRadius),:);
lowerBearingsNearLocation = round(wrapTo360(atan2d(-lowerVxyNearLocation(:,1),-lowerVxyNearLocation(:,2))));  %convert V_xy to the bearing angle
upperBearingsNearLocation = round(wrapTo360(atan2d(-upperVxyNearLocation(:,1),-upperVxyNearLocation(:,2))));
lowerTKENearLocation = lowerTKE(dsearchn(lowerVertices, pointRadius));
upperTKENearLocation = upperTKE(dsearchn(lowerVertices, pointRadius));

interpolatedVelocitiesNearLocation = lowerVelocitiesNearLocation + interpolationFactor*(upperVelocitiesNearLocation-lowerVelocitiesNearLocation);
interpolatedBearingsNearLocation = lowerBearingsNearLocation + interpolationFactor*(upperBearingsNearLocation-lowerBearingsNearLocation);
interpolatedTKENearLocation = lowerTKENearLocation + interpolationFactor*(upperTKENearLocation-lowerTKENearLocation);

CFDMaxSpeeds = max(interpolatedVelocitiesNearLocation);
CFDMeanSpeeds = mean(interpolatedVelocitiesNearLocation);
CFDMinSpeeds = min(interpolatedVelocitiesNearLocation);
CFDSpeedRange = max(interpolatedVelocitiesNearLocation) - min(interpolatedVelocitiesNearLocation);
CFDMeanBearings = round(median(interpolatedBearingsNearLocation));
CFDPeakSpeeds = 2.7*sqrt(2/3*mean(interpolatedTKENearLocation))+ mean(interpolatedVelocitiesNearLocation);

end
