clear
clc

% cube = legoev3('Usb');
% 
% motor = motor(cube,'A');
% 
% motor.Speed = 10;
% 
% start(motor)

ports =  'AD';

motory = motory(ports);





motory.setSpeed(80);

while true

    while ~motory.touch()
    end

    motory.start();
    
    while motory.touch()
    end

    motory.stop()
pause(0.1);
end