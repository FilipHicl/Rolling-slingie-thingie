clear
clc

% cube = legoev3('Usb');
% 
% motor = motor(cube,'A');
% 
% motor.Speed = 10;
% 
% start(motor)

ports =  ['A','B'];

motory = motory(ports);



motory.start()

motory.setSpeed(50);

% pause(1)

% motory.stop()