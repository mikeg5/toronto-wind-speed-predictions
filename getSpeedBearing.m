function [CFDMeanSpeeds,CFDPeakSpeeds,CFDMeanBearings]=getSpeedBearing(AOA,C,time,height,Tile_Name,xCoordinate,yCoordinate)
%This function will patch the velocity contour

%Define the current folder
Path=pwd;
load('C:\windApp\Update Locations\Locations.mat');

%Define Tile Folder
Tile_Folder = strcat(Tile_Name,'_CSV');
%Define CSV File Name
if AOA(time) < 100
    FName = strcat(Tile_Name,'_',sprintf('%03d',AOA(time)),'_z',num2str(height),'.csv'); %add leading zero
else
    FName = strcat(Tile_Name,'_',num2str(AOA(time)),'_z',num2str(height),'.csv');
end

%% PARSE THE EXCEL DATA
cd('C:\CSV'); %Replace with Database location
cd(Tile_Folder) %opens folder containing the selected tile csv files

ExcelData = readmatrix(FName); %reads csv file
lastrow = size(ExcelData,1); % number of rows in excel data sheet
lastcol = size(ExcelData,2); %number of columns in excel data sheet
rowbreak = find(all(isnan(ExcelData),2)); %finds the NaN row
lastnode = rowbreak-1; %node data (ie. coordinates, velocity...) is stored before the rowbreak
firstface = rowbreak+1; %face data (i.e how to connect the nodes) in after the rowbreak

F=ExcelData(firstface:lastrow,1:lastcol);
Faces=F+1;
Vertices=ExcelData(1:lastnode,2:3);

TKE=ExcelData(1:lastnode,5).*C(time);
Velocity=ExcelData(1:lastnode,6).*C(time);
V_xy=ExcelData(1:lastnode,7:8).*C(time);

searchRadius = 1.5;
pointRadius = [(xCoordinate-searchRadius:0.25:xCoordinate+searchRadius)',(yCoordinate-searchRadius:0.25:yCoordinate+searchRadius)']; %take a radius of 2 around coordinate
velocitiesNearLocation = Velocity(dsearchn(Vertices, pointRadius)); %find velocities within that sample radius
vxyNearLocation = V_xy(dsearchn(Vertices, pointRadius),:); %find V_xy within the sample radius
bearingsNearLocation = round(wrapTo360(atan2d(-vxyNearLocation(:,1),-vxyNearLocation(:,2)))); %convert V_xy to the bearing angle
TKENearLocation = TKE(dsearchn(Vertices, pointRadius));

CFDMaxSpeeds = max(velocitiesNearLocation);
CFDMeanSpeeds = mean(velocitiesNearLocation);
CFDMinSpeeds = min(velocitiesNearLocation);
CFDSpeedRange = max(velocitiesNearLocation) - min(velocitiesNearLocation);
CFDMeanBearings = median(bearingsNearLocation);
CFDPeakSpeeds = 2.7*sqrt(2/3*mean(TKENearLocation))+ mean(velocitiesNearLocation);

cd(Path) %original file directory
end