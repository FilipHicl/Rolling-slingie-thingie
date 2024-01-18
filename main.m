clc, clear


image_analyzer = ImageAnalyzer();

ports =  'AD';
motory = motory(ports);
motory.setSpeed(50);

Kp = 1.0;
Ki = 1;
Kd = 0;
Setpoint = 50;
Dt = 0.1;

controller = PID(Kp, Ki, Kd, Setpoint, Dt);


motory.start();
pause(2);

while ~motory.touch()

    vyska = image_analyzer.analyze();

    motory.setSpeed(controller.computeOutput(vyska));
    % pause(0.1);
    disp(controller.computeOutput(vyska))
end

motory.stop();
delete(image_analyzer);
