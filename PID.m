classdef PID < handle
    properties
        Kp % Proportional gain
        Ki % Integral gain
        Kd % Derivative gain
        Dt % Time step
        Setpoint % Desired setpoint
    end


        

    properties (Access = private)
        PreviousError
    end

    properties (Access = protected)
        Integral % Integral term accumulator
    end

    methods
       function this = PID(Kp, Ki, Kd, Setpoint, Dt)
            % Constructor to initialize the PID controller
            this.Kp = Kp;
            this.Ki = Ki;
            this.Kd = Kd;
            this.Setpoint = Setpoint;
            this.Dt = Dt;
            this.Integral = 50;
            this.PreviousError = 0;
        end
        



        function [output,this] = computeOutput(this, process_variable)
            % Calculate error
            error = this.Setpoint - process_variable;

            % Proportional term
            P = this.Kp * error;

            % Integral term
            this.Integral = this.Integral + error * this.Dt;
            I = this.Ki * this.Integral;

            % Derivative term
            derivative = (error - this.PreviousError) ./ this.Dt;
            D = this.Kd * derivative;

            % Compute output
            output = P + I + D;

            % Update for next iteration
            this.PreviousError = error;
        end
    end
end


