clear
clc

% cube = legoev3('Usb');
% 
% motor = motor(cube,'A');
% 
% motor.Speed = 10;
% 
% start(motor)

ports =  'AB';

motory = motory(ports);





motory.setSpeed(100);

while true

    while ~motory.touch()
    end

    motory.start();
    
    while motory.touch()
    end

    motory.stop()

end