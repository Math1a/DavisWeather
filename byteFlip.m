function [ushort] = byteFlip(bytes)

ushort = bin2dec(string(dec2bin(bytes(2), 8)) + string(dec2bin(bytes(1), 8)));

end
