classdef motory < handle
    % Set propertie

    properties
        ports
        speed
    end

    properties (Access = private)
        motor
        button

    end

    methods
        function this = motory(ports)
            this.ports = ports;

            cube = legoev3('Usb');
            
            for id = 1:numel(ports)
                this.motor{id} = motor(cube,ports(id));
            end

            this.button = touchSensor(cube);
            
            


        end

        function start(this)
            for id = 1:numel(this.motor)
                start(this.motor{id})
            end
        end

        function stop(this)
            for id = 1:numel(this.motor)
                stop(this.motor{id})
            end
        end

        function this = setSpeed(this,newSpeed)
            for id = 1:numel(this.motor)
                this.motor{id}.Speed = newSpeed;
            end
        end


        function val = touch(this)
            val = readTouch(this.button);
        end


        % function delete(this) %destructor
        %     % stop(this)
            
        %     for id = 1:numel(this.motor)
        %         this.motor{id}.delete();
        %     end
        %     cube.delete();
            


        % end

    end
end
