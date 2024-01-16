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

motory.speed = 50; 

motory.start()

pause(1)

motory.stop()