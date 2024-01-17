clc
clear


% Example usage of PIDController class
Kp = 1.0;
Ki = 0.5;
Kd = 0.1;
Setpoint = 10;
Dt = 0.1;

controller = PID(Kp, Ki, Kd,Setpoint, Dt);



% Simulation loop
for t = 0:Dt:10
    % Measure process variable (replace with actual measurement code)
    process_variable = rand(); 

    % Compute control action
    output = controller.computeOutput(process_variable);

    % Apply control (replace with actual control application code)
    % e.g., apply_control(output);

    % Wait for next time step
    pause(Dt);
end
