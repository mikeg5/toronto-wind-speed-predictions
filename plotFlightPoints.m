function plotFlightPoints(flightPath,numPathDivisions,gx)

cla(gx);
iterFlightPath = (split(flightPath,","))';
flightPath=[];
for i = 1:length(iterFlightPath)
    flightPath(1,i) = str2num(iterFlightPath{1,i});
end 

%% Separate CSV into Lat, Long, and Elevation
for i = 1:length(flightPath)/3
    endRow=i*3;
    startRow=endRow-2;
    latLongElevPrior(i,1:3)=flightPath(1,startRow:endRow);
end 
flightPath = [];
flightPath = latLongElevPrior;
clear latLongElevPrior;

if numPathDivisions == 1
    geoplot(gx, flightPath(:,1), flightPath(:,2), '.g', 'MarkerSize', 20);
    return
end 

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

geoplot(gx, latLongElev(:,1), latLongElev(:,2), '.r', 'MarkerSize', 18);
geoplot(gx, flightPath(:,1), flightPath(:,2), '.g', 'MarkerSize', 20);
end 