function F = getData(F)

S = F.SerialResource;

S.writeline("TEST") % Wake up!
S.flush % Clear the pervious output

S.writeline("LPS 1 1") % Request 1 LOOP packet

% Check the validity of the incoming packets
valid = 0;
while ~valid
    resp = read(S, 1, 'uint8'); % Read the first byte
    
    if resp == 6 % check if the first byte is 'acc' (ASCII)
        resp = read(S, 99, 'uint8');
        if resp(1) == 76 && resp (2) == 79 && resp(3) == 79 % Check if first characters are "L-O-O"
            valid = 1;
        end
    end
    S.flush
end

clear S % Close the serial port, this is important, otherwise Matlab won't be able to open it again

F.LastDataTaken      = now;
F.InsideTemperature  = (5/9)*(byteFlip(resp(10:11))/10 -32);
F.InsideHumidity     = resp(12);
F.Barometer          = (byteFlip(resp(8:9))/1000)/29.53;
F.OutsideTemperature = (5/9)*(byteFlip(resp(13:14))/10 -32);
F.OutsideHumidity    = resp(34);
F.WindSpeed          = resp(15) * 1.609344;
F.WindDirection      = byteFlip(resp(17:18));
F.Rain               = byteFlip(resp(42:43)) * 0.254;
F.SolarRadiation     = byteFlip(resp(45:46));

end