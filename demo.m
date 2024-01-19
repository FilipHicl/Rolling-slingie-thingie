clc, clear


camera = "Newmine Camera";
image_analyzer = ImageAnalyzer(camera);

while true
    image_analyzer.analyze()
end
