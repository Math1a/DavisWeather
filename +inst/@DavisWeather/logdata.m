function F = logdata(F)

mkdir(F.DataPath)
format = 'yyyy-mm-ddTHH:MM:SSZ';
file = strcat(F.DataPath,'/DavisData_', datestr(now, format), '.csv');
fid = fopen(file, 'w');
fprintf(fid, "InsideTemperature,InsideHumidity,Barometer,OutsideTemperature,OutsideHumidity,WindSpeed,WindDirection,Rain,SolarRadiation");
fclose(fid);

F.FileName = file;

t = timer; % Create a timer object
t. period = 60; % Set the period of the timer
%t.TasksToExecute = 7200; % Maximun number of loggings
t.ExecutionMode = 'fixedRate'; % Set execution mode
t.StartFcn = @(~,~)savedata(F); % The command that will execute (first time)
t.TimerFcn = @(~,~)savedata(F); % The command that will execute
start(t) % Start the timer

F.Logger = t;

end

function savedata(F)
    fid = fopen(F.FileName);
    fprintf(fid, "%d,%d,%d,%d,%d,%d,%d,%d,%d/n", ...
        F.InsideTemperature,F.InsideHumidity,F.Barometer, ...
        F.OutsideTemperature,F.OutsideHumidity,F.WindSpeed, ...
        F.WindDirection,F.Rain,F.SolarRadiation);
    fclose(fid);
end