function [CFDMeanSpeeds,CFDPeakSpeeds,CFDMeanBearings,relativeDistances,latLongElev] = flightPathWindPrediction(flightPath,numPathDivisions,date,time,isAM,gx)
% Date=char(datetime('now','format','yyyy-MM-dd')); % Date Placeholder (Format: YYYY-MM-DD)
% Date = '2021-01-27';
%flightPath = [43.65446663461646, -79.37821737591074, 20; 43.654071848602314, -79.37996048324418, 20; 43.65908688013625, -79.38209400465043, 20; 43.657576276224084, -79.38940228974872, 20];
%time = 1;
timeConversionLookup = containers.Map({'12AM','1AM','2AM','3AM','4AM','5AM','6AM','7AM','8AM','9AM','10AM','11AM','12PM','1PM','2PM','3PM','4PM','5PM','6PM','7PM','8PM','9PM','10PM','11PM'},[1:24]);

%% Draw Processing Bar
fig = findall(0,'Type','figure');
processingBar = uiprogressdlg(fig,'Title','Processing','Indeterminate','on');
drawnow

%% Convert Time using lookup table 
if isAM
    timeLookup = strcat(num2str(time),'AM');
    time = timeConversionLookup(timeLookup);
else
    timeLookup = strcat(num2str(time),'PM');
    time = timeConversionLookup(timeLookup);
end

%% Separate CSV into Lat, Long, and Elevation
iterFlightPath = (split(flightPath,","))';
flightPath=[];
for i = 1:length(iterFlightPath)
    flightPath(1,i) = str2num(iterFlightPath{1,i});
end 

for i = 1:length(flightPath)/3
    endRow=i*3;
    startRow=endRow-2;
    latLongElevPrior(i,1:3)=flightPath(1,startRow:endRow);
end 
flightPath = [];
flightPath = latLongElevPrior;
clear latLongElevPrior;

%% Calculate Intermediate Points
steps = (0:numPathDivisions-1)./numPathDivisions;
for i=1:size(flightPath,1)-1
    startRow = 1+(i-1)*numPathDivisions;
    endRow = startRow+(numPathDivisions-1);
    format long
    elevDiff = flightPath(i+1,3) - flightPath(i,3);
    distLong = flightPath(i+1,2) - flightPath(i,2);
    coefficients = polyfit([flightPath(i,2), flightPath(i+1,2)], [flightPath(i,1), flightPath(i+1,1)], 1);
    m = coefficients(1);
    b = coefficients(2);
    intermediateLongitudes = flightPath(i,2).*ones(numPathDivisions,1) + distLong.*steps';
    intermediateLatitudes = m.*intermediateLongitudes + b;
    intermediateElevations = flightPath(i,3).*ones(numPathDivisions,1) + elevDiff.*steps';
    latLongElev(startRow:endRow,:) = [intermediateLatitudes,intermediateLongitudes,intermediateElevations];
end
latLongElev(end+1,:) = flightPath(end,:);
startPoint = latLongElev(1,:);
relativeDistances = normalize(sqrt(sum((latLongElev(:,1:2) - startPoint(:,1:2)).^2,2)),'range');

%% Get Wind Speeds
path=pwd;
[AOA, C] = getWindData(date);

load('C:\windApp\Update Locations\Locations.mat');

for i = 1:length(latLongElev)
    height = latLongElev(i,3);
    [Tile_Name, xCoordinate, yCoordinate] = chooseTile(latLongElev(i,1),latLongElev(i,2));
    n = find(strcmp({Locations.tileName},Tile_Name)); %Row of the tile in Locations Matrix
    if ismember(height,Locations(n).planeHeights)
        %if the CSV file is available do not interpolate
        [meanSpd,peakSpd,bearing]=getSpeedBearing(AOA,C,time,height,Tile_Name,xCoordinate,yCoordinate);
    else
        %if the CSV file is NOT available then interpolate
        [meanSpd,peakSpd,bearing]=interpSpeedBearing(AOA,C,time,height,Tile_Name,xCoordinate,yCoordinate);
    end
    
    CFDMeanSpeeds(i,1) = meanSpd;
    CFDPeakSpeeds(i,1) = peakSpd;
    CFDMeanBearings(i,1) = bearing;
    close(processingBar)
    if i == 1
        cla(gx)
    end
    hold (gx,'on')
    geoplot(gx, latLongElev(i,1), latLongElev(i,2), '.r', 'MarkerSize', 20);
    drawnow;
end
end 
