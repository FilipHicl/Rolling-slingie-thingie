clc, clear


image_analyzer = ImageAnalyzer("/dev/video0");
% image_analyzer = ImageAnalyzer("Laptop Camera");


zapnute = true;

while zapnute
    suradnica = image_analyzer.analyze();
end
