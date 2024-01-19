clc, clear





% PID setup
Kp = 1.0;
Ki = 1;
Kd = 0;
Setpoint = 50;
Dt = 0.1;

controller = PID(Kp, Ki, Kd, Setpoint, Dt);
%


% Camera setup
camera = "Newmine Camera";
% camera = "/dev/video0";
% camera = "Video Camera";

image_analyzer = ImageAnalyzer(camera);
%

% Motory setup
ports =  'AD';
motory = motory(ports);
motory.setSpeed(50);

motory.start();
%



pause(2);

while ~motory.touch()

    vyska = image_analyzer.analyze(camera);

    motory.setSpeed(controller.computeOutput(vyska));
    % pause(0.1);
    disp(controller.computeOutput(vyska))
end

motory.stop();
motory.delete();
image_analyzer.delete();
