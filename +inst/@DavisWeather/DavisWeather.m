classdef DavisWeather < handle % obs.LAST_Handle
    
    properties (GetAccess = public, SetAccess = private)
        InsideTemperature   % Temperature of the console in C
        InsideHumidity      % Humidity of the console in %
        Barometer           % Barometric pressure in Bar
        OutsideTemperature  % Outside temperature in C
        OutsideHumidity     % Outside humidity in %
        WindSpeed           % Current wind speed in km/h
        WindDirection       % Wind direction in angles, 360 is north
        Rain                % Rain rate in mm
        SolarRadiation      % Solar radiation in watt per meter squared
    end
    
    properties(Hidden)
        LastDataTaken       % The last time that the weather data was updated
        SerialResource
    end
    
    methods
        % constructor and destructor
        function F=DavisWeather()
            F.connect;
            F.LastDataTaken = 0;
        end
    end
    
    methods
        % getters and setters
        function d = get.InsideTemperature(F)
            if F.LastDataTaken < now - 1/1440 % updates every minute at most
            F.getData;
            end
            d = F.InsideTemperature;
        end
        function d = get.InsideHumidity(F)
            if F.LastDataTaken < now - 1/1440 % updates every minute at most
            F.getData
            end
            d = F.InsideHumidity;
        end
        function d = get.Barometer(F)
            if F.LastDataTaken < now - 1/1440 % updates every minute at most
            F.getData
            end
            d = F.Barometer;
        end
        function d = get.OutsideTemperature(F)
            if F.LastDataTaken < now - 1/1440 % updates every minute at most
            F.getData
            end
            d = F.OutsideTemperature;
        end
        function d = get.OutsideHumidity(F)
            if F.LastDataTaken < now - 1/1440 % updates every minute at most
            F.getData
            end
            d = F.OutsideHumidity;
        end
        function d = get.WindSpeed(F)
            if F.LastDataTaken < now - 1/1440 % updates every minute at most
            F.getData
            end
            d = F.WindSpeed;
        end
        function d = get.WindDirection(F)
            if F.LastDataTaken < now - 1/1440 % updates every minute at most
            F.getData
            end
            d = F.WindDirection;
        end
        function d = get.Rain(F)
            if F.LastDataTaken < now - 1/1440 % updates every minute at most
            F.getData
            end
            d = F.Rain;
        end
        function d = get.SolarRadiation(F)
            if F.LastDataTaken < now - 1/1440 % updates every minute at most
            F.getData
            end
            d = F.SolarRadiation;
        end
    end
    
end