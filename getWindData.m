function [AOA, C, V_61_Airport] = getWindBearingAndScalingFactors(Date)
% This function will take Date as Input and Return AOA & Scaling Factors(C)

%Initialization
Today_Date=char(datetime('now','format','yyyy-MM-dd')); %Today's Date
Key=['2f63cdf63f754e36f4ad63a68dd38595']; % add your personnel key for Dark Sky API
Coordinates=['43.6285,-79.397911'];       % Latitude and Longitude of Reference Site (Billy Bishop)
Comm=['https://api.darksky.net/forecast/' Key '/' Coordinates ',' Date 'T00:00:00?units=si&exclude=daily,currently,precipIntensity,precipProbability,precipType,temperature,apparentTemperature,dewPoint,humidity,cloudCover,uvIndex,visibility,ozone,summary,icon'];

%READ TODAY'S DATA OR GET DATA FOR ANOTHER DATE
% if strcmp(Date,Today_Date)==1
%     fileID=fopen('Todays_Data.txt','r'); %opens text file 
%     formatSpec = '%c'; %reads text file as character array
%     str=fscanf(fileID,formatSpec); %write info in text file to 'str' variable
%     fclose(fileID);
% else
% [str,status] = urlread(Comm); %reads Dark Sky API string for specified date 
% end
[str,status] = urlread(Comm); 

% EXTRACTS WIND DATA FROM DARK SKY API STRING (Wind Speeds at 10m at Billy Bishop)
k1 = strfind(str,'"windSpeed":');                    %finds the character number of the beginning of the string 'windSpeed' 
k2 = strfind(str,'"windBearing":');
k3 = strfind(str,'"cloudCover":');

PickUP=[k1'+12 k1'+16, k2'+14 k3'-2]; %Index for character # between strings
sz = size(PickUP,1);                  %determines the number of rows in PickUP 

Wind_Speed = zeros(sz,1);             %Pre-Allocates a size for Wind Speed Column Matrix
Wind_Bearing = zeros(sz,1);

for i=1:sz
    Wind_Speed(i) = str2double(str(PickUP(i,1):PickUP(i,2))); %Converts string to a double and stores in Wind Speed Matrix 
    n=1;
    while isnan(Wind_Speed(i))
      Wind_Speed(i) = str2double(str(PickUP(i,1):PickUP(i,2)-n));
      n=n+1;  
    end
    Wind_Bearing(i) = str2double(str(PickUP(i,3):PickUP(i,4)));
end
    
AOA = roundn(Wind_Bearing,1);  %Rounds Wind Bearing to nearest 10 degree Angle
AOA(AOA==360) = 0; %Replace all 360-degree cases with 0-degree

Case = AOA./10 + 1;   %Case corresponding to the Angle to choose gamma 

% CALCULATES SCALING FACTORS FOR WIND SPEED
gamma = [2.4443	2.3191	2.0319	1.9983	2.2387	1.8998	2.0219	1.9241	1.8236	1.8108	1.9957	2.3676	2.3166	2.0399	2.6418	2.2295	2.3341	1.6455	1.9088	1.8195	1.8212	1.8476	1.8144	1.8733	1.8006	1.6048	1.8609	2.0319	2.2624	2.2482	2.3207	2.1214	2.4886	2.6807	2.9442	2.8508];
gamma61 = [1.58247	1.55826	1.56883	1.57363	1.54586	1.54447	1.51865	1.44775	1.44297	1.44663	1.49218	1.64042	1.53760	1.35960	1.51936	1.47935	1.51630	1.29960	1.43327	1.41265	1.41330	1.42114	1.37495	1.40591	1.43166	1.26683	1.39522	1.47351	1.52934	1.56490	1.56063	1.55998	1.67865	1.71416	1.72110	1.72480];

V_500_Assumed = 20; %Assumed V in ESDU sheet @500M is 20m/s

V_500_Airport = Wind_Speed.*(gamma(Case))'; %Wind Speed at 500m at Airport at requested Time 
V_61_Airport = Wind_Speed.*(gamma61(Case))'; %Wind Speed at 61m at Airport to compare to TAO 

C = V_500_Airport./V_500_Assumed; %Scaling Factors
end