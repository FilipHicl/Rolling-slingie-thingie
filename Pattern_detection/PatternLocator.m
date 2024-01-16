classdef PatternLocator
    properties
        Image
        Pattern
        CorrelationMap
        MaxCorrelation
        MaxLocation
    end
    
    methods
        function obj = PatternLocator(imagePath, patternPath)
            % Constructor
            obj.Image = imread(imagePath);
            obj.Pattern = imread(patternPath);
            obj.CorrelationMap = normxcorr2(obj.Pattern, obj.Image);
            
            % Find the peak correlation location
            [obj.MaxCorrelation, maxIndex] = max(abs(obj.CorrelationMap(:)));
            [maxY, maxX] = ind2sub(size(obj.CorrelationMap), maxIndex);
            obj.MaxLocation = [maxX-size(obj.Pattern,2)+1, maxY-size(obj.Pattern,1)+1];
        end
        
        function displayResult(obj)
            % Display the result
            figure;
            subplot(2,2,1); imshow(obj.Image); title('Original Image');
            subplot(2,2,2); imshow(obj.Pattern); title('Pattern');
            
            subplot(2,2,3); surf(obj.CorrelationMap); title('Correlation Map');
            subplot(2,2,4); imshow(obj.Image);
            hold on;
            rectangle('Position', [obj.MaxLocation(1), obj.MaxLocation(2), size(obj.Pattern,2), size(obj.Pattern,1)],...
                      'EdgeColor', 'r', 'LineWidth', 2);
            title('Pattern Location');
            
            % Output the location
            disp(['Pattern located at position: X = ', num2str(obj.MaxLocation(1)), ', Y = ', num2str(obj.MaxLocation(2))]);
        end
    end
end