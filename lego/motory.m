classdef motory
    % Set propertie

    properties
        ports
        speed
    end

    properties (Access = private)
        motor

    end

    methods
        function this = motory(ports)
            this.ports = ports;

            cube = legoev3('Usb');
            
            for id = 1:numel(ports)
                this.motor{id} = motor(cube,ports(id));
            end
            


        end

        function start(this)
            for ig = numel(this.motor)
                this.motor{ig}.Speed = this.speed;
            end

            for id = numel(this.motor)
                start(this.motor{id})
            end
        end

        function stop(this)
            for id = numel(this.motor)
                stop(this.motor{id})
            end
        end
    end
end