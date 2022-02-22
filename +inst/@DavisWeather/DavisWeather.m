classdef DavisWeather

    properties(GetAccess = public, SetAccess = private) 
        InsideTemperature
        InsideHumidity
        Barometer
        OutsideTemperature
        OutsideHumidity
    end
    
    properties(Hidden)
        SerialResource
    end
    
end