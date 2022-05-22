# DavisWeather
A Matlab class for communicating with the Davis Vantage Pro2 (cabled)

The class uses the serial port (USB) to communicate with the weather station, it can read indoor as well as outdoor sensors.

The calculations and serial protocols are as mentioned in [This Datasheet](https://cdn.shopify.com/s/files/1/0515/5992/3873/files/VantageSerialProtocolDocs_v261.pdf?v=1614399559)

To set up the console, see [Console Manual](https://cdn.shopify.com/s/files/1/0515/5992/3873/files/07395.234_Manual_VP2__RevZ_web.pdf?v=1647548782)

## hOw Do I cOnNeCt ThE wEaThEr StAtIoN???
- If the weather station is connected to the EnviroMonitor Gateway (separate big white solar panel box), disconnect it. Connect the outside sensors to the console. The EnviroMonitor is unnecessary.
- The console requires 2 USB connections; one for data transmission, and the other for power.
- To initiate the connection, use:
```matlab
W = inst.DavisWeather
```
- This will automatically call the "connect" function, that searches the serial ports and tries to find the weather station.
- Make sure no other serial ports are open or being used by Matlab, as they may interfere and cause errors.
- The weather data is stored in the class properties. They will update each time the class is called ('W') no more than once a minute, and they will display all the relevant data.
- To force an update, use: 
```matlab
W.getData
```

**What weather data does the class display?**
```matlab
 InsideTemperature   % Temperature of the console in C
 InsideHumidity      % Humidity of the console in %
 Barometer           % Barometric pressure in Bar
 OutsideTemperature  % Outside temperature in C
 OutsideHumidity     % Outside humidity in %
 WindSpeed           % Current wind speed in km/h
 WindDirection       % Wind direction in angles, 360 is north
 Rain                % Rain rate in mm
 SolarRadiation      % Solar radiation in watt per meter squared
 ```




## This class is still incomplete. Known issues:
- [ ] CRC not yet implemented (Altough the console checks for it)
- [ ] Serial port should be either constant, or not have any other open serial devices
- [ ] The outdoor humidity and temperature sensors do not agree with the indoor ones! Sensors should be calibrated
