function F = connect(F,Port, Baud)
%Initiate the connection to the arduino that is mounted on the telescope.
%
%Optional parameters:
%'Port' - The port where the Arduino is connected, auto detect by deafult.
%Example input: "/dev/ttyUSB0"
%'Baud' - The baud rate (bits per second) of the communication, deafult is
%115200.
%
clear S
found = 0;

if ~exist('Baud','var') || isempty(Baud)
    Baud = 19200;
end

if ~exist('Port','var') || isempty(Port)
    ports = serialportlist("available")'; % Check Avalible ports
    for i = 1:length(ports)
        try
            S = serialport(ports(i),Baud); % Set the port and the baud rate
            found = 1;
        catch
            continue
        end
    end
    if found ~= 1
        error("Weather Station could not be reached, check connection and serial port.")
    end
else
    S = serialport(Port,Baud); % Set the port and the baud rate
end

flush(S) % Clear the pervious output
F.SerialResource = S;
end
