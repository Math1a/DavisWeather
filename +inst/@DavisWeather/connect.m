function F = connect(F,Port, Baud)
%Initiate connection with the Davis weater station.
%
%Optional parameters:
%'Port' - The port where the weather station is connected, auto detect by deafult.
%Example input: "/dev/ttyUSB0"
%'Baud' - The baud rate (bits per second) of the communication, deafult is
%19200.
%
found = 0;

if ~exist('Baud','var') || isempty(Baud)
    Baud = 19200;
end

if ~exist('Port','var') || isempty(Port)
    ports = serialportlist("available")'; % Check Avalible ports
    for i = 1:length(ports)
        try
            S = serialport(ports(i),Baud); % Set the port and the baud rate
            S.writeline("TEST")
            pause(0.1)
            resp = S.read(8, 'string');
            if resp.contains("TEST")
                found = 1;
            else
                clear S
                error("Not a weather console! Try another port.")
            end
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

flush(S) % Clear the previous output
F.SerialResource = S;
end
