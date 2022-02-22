function F = getData(F)

S = F.SerialResource;

S.writeline("TEST") % Wake up!
S.flush % Clear the pervious output

write(S, "LOOP 1\n", 'string')

% Check the validity of the incoming packets
valid = 0;
while ~valid
    resp = read(S, 1, 'uint8'); % Read the first byte
    
    if resp == 6 % check if the first byte is 'acc' (ASCII)
        resp = read(S, 99, 'char');
        if resp(1) == 'L' & resp (2) == 'O' & resp(3) == 'O' % Check if first characters are "L-O-O"
            valid = 1;
        end
    end
    S.flush
end

resp = read(S, 99, 'uint8'); % The station uses a loop, so the 99 bytes will come again

clear S % Close the serial port, this is important, otherwise Matlab won't be able to open it again

inTemp = bin2dec(string(dec2bin(resp(11))) + string(dec2bin(resp(10)))); % Read and convert bits into ushort
F.InsideTemperature = (5/9)*((inTemp/10)-32);

F.InsideHumidity = resp(12);

barometer = bin2dec(string(dec2bin(resp(9))) + string(dec2bin(resp(8))));
F.Barometer = ((barometer/1000)/29.53);

end