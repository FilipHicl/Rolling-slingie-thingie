clc, clear


image_analyzer = ImageAnalyzer();

ports =  'AD';
motory = motory(ports);
motory.setSpeed(80);

Kp = 1.0;
Ki = 1;
Kd = 0;
Setpoint = 50;
Dt = 0.1;

controller = PID(Kp, Ki, Kd, Setpoint, Dt);


motory.start();

while ~motory.touch()

    vyska = image_analyzer.analyze();

    motory.setSpeed(controller.computeOutput(vyska));
    % pause(0.1);
end

motory.stop();
delete(image_analyzer);
