classdef DavisWeather

    properties(GetAccess = public, SetAccess = private) 
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
        SerialResource
    end
    
end