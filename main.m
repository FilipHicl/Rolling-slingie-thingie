clc, clear

cam = webcam("Laptop Camera");
% cam = webcam("/dev/video2");
% toto zmeniť podľa potreby

% cam.Resolution = '1250x720';
% cam.Saturation = 64;
% cam.ExposuseMode = 'manual';
% cam.Exposure = 156;
% cam.Contrast = 143;


videoPlayer = vision.VideoPlayer;


diskErode = strel('disk', 15);
diskDilate = strel('disk', 5);
hBlobAnalysis = vision.BlobAnalysis(...
    'MinimumBlobArea', 600, ...
    'MaximumBlobArea', 100000);


while true
    img = cam.snapshot;

    [red_mask, masked_red] = createMaskRed(img);
    [green_mask, masked_green] = createMaskGreen(img);
    [silver_mask, silver_green] = createMaskSilver(img);

    red_mask = imerode(red_mask, diskErode);
    red_mask = imdilate(red_mask, diskDilate);
    % red_mask = imopen(red_mask, disk);
    
    green_mask = imerode(green_mask, diskErode);
    green_mask = imdilate(green_mask, diskDilate);
    % green_mask = imopen(green_mask, disk);

    silver_mask = imerode(silver_mask, diskErode);
    silver_mask = imdilate(silver_mask, diskDilate);
    % silver_mask = imopen(silver_mask, disk);

    [redArea, redCentroid, redbbox] = step(hBlobAnalysis, red_mask);
    [greenArea, greenCentroid, greenbbox] = step(hBlobAnalysis, green_mask);
    [silverArea, silverCentroid, silverbbox] = step(hBlobAnalysis, silver_mask);

    
    outputImage = img;

    mask = green_mask+red_mask + silver_mask; 
    outputImage(repmat(~mask,[1 1 3])) = 0;

    try
        red_center = (redCentroid(1,:)+redCentroid(2,:)) ./ 2;
        green_center = (greenCentroid(1,:)+greenCentroid(2,:)) ./ 2;
        silver_center = silverCentroid;

        centers = [ red_center; silver_center; green_center ];

        distance_from_red_center = sqrt((silver_center(1)-red_center(1))^2+(silver_center(2)-red_center(2))^2);
        distance_from_green_center = sqrt((silver_center(1)-green_center(1))^2+(silver_center(2)-green_center(2))^2);

        outputImage = insertText(outputImage, [20 20], ['red: ', num2str(distance_from_red_center)]);
        outputImage = insertText(outputImage, [20 650], ['green: ', num2str(distance_from_green_center)]);

        outputImage = insertShape(outputImage, 'rectangle', redbbox);
        outputImage = insertShape(outputImage, 'rectangle', greenbbox);
        outputImage = insertShape(outputImage, 'rectangle', silverbbox);


        outputImage = insertShape(outputImage, 'line', greenCentroid);
        outputImage = insertShape(outputImage, 'line', redCentroid);

        outputImage = insertShape(outputImage, 'line', centers);
    catch
    end
    
    step(videoPlayer, outputImage);
end
