classdef PIDController
    properties
        Kp % Proportional gain
        Ki % Integral gain
        Kd % Derivative gain
        Setpoint % Desired setpoint
        Integral % Integral term accumulator
        PreviousError % Error from previous step
        Dt % Time step
    end

    methods
        function obj = PIDController(Kp, Ki, Kd, Setpoint, Dt)
            % Constructor to initialize the PID controller
            obj.Kp = Kp;
            obj.Ki = Ki;
            obj.Kd = Kd;
            obj.Setpoint = Setpoint;
            obj.Dt = Dt;
            obj.Integral = 0;
            obj.PreviousError = 0;
        end

        function output = computeOutput(obj, process_variable)
            % Calculate error
            error = obj.Setpoint - process_variable;

            % Proportional term
            P = obj.Kp * error;

            % Integral term
            obj.Integral = obj.Integral + error * obj.Dt;
            I = obj.Ki * obj.Integral;

            % Derivative term
            derivative = (error - obj.PreviousError) / obj.Dt;
            D = obj.Kd * derivative;

            % Compute output
            output = P + I + D;

            % Update for next iteration
            obj.PreviousError = error;
        end
    end
end

