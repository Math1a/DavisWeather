%Start logging the weather station's data to a CSV table
%Parameters:
%D.DataPath: The folder in which the log files will be saved
%D.Period: The interval between each log
function F = logData(F)

% Check if logger is already running
try
    if isvalid(F.Logger)
        error("Already logging!")
    end
catch
    if exist(F.Logger, 'var')
        error("Already logging!")
    end
end

% Make the directory (if it dosen't exist), and create the csv file
mkdir(F.DataPath)
format = 'yyyy-mm-ddTHH:MM:SS';
file = strcat(F.DataPath,'/DavisData_', datestr(now, format), '.csv');
fid = fopen(file, 'w');
fprintf(fid, "InsideTemperature,InsideHumidity,Barometer,OutsideTemperature,OutsideHumidity,WindSpeed,WindDirection,Rain,SolarRadiation,Time\n");
fclose(fid);

F.FileName = file;

% Create the timer object that will call the 'savedata' function (to log the data)
t = timer; % Create a timer object
t.period = F.Period; % Set the period of the timer
%t.TasksToExecute = 7200; % Maximun number of loggings
t.ExecutionMode = 'fixedRate'; % Set execution mode
t.TimerFcn = @(~,~)savedata(F); % The command that will execute
start(t) % Start the timer

F.Logger = t;

end

% This function is called every F.period seconds, it will save the current
% sensor data to the csv table
function savedata(F)
% Get data and open the file
F.getData;
fid = fopen(F.FileName, 'a');
fprintf(fid, "%f,%d,%f,%f,%d,%f,%d,%f,%d,%s\n", ...
    F.InsideTemperature,F.InsideHumidity,F.Barometer, ...
    F.OutsideTemperature,F.OutsideHumidity,F.WindSpeed, ...
    F.WindDirection,F.Rain,F.SolarRadiation, ...
    datestr(now, 'yyyy-mm-dd HH:MM:SS'));
fclose(fid);
end