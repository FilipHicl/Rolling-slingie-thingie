clc, clear

cam = webcam;

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
    'MaximumBlobArea', 6000);


while true
    img = cam.snapshot;
    
    [red_mask, masked_red] = createMaskRed(img);
    [green_mask, masked_green] = createMaskGreen(img);

    green_mask = imerode(green_mask, diskErode);
    green_mask = imdilate(green_mask, diskDilate);
    % green_mask = imopen(green_mask, disk);

    red_mask = imerode(red_mask, diskErode);
    red_mask = imdilate(red_mask, diskDilate);
    % red_mask = imopen(red_mask, disk);
    

    [redArea, redCentroid, redbbox] = step(hBlobAnalysis, red_mask);
    [greenArea, greenCentroid, greenbbox] = step(hBlobAnalysis, green_mask);
    
    outputImage = img;

    mask = green_mask+red_mask; 
    outputImage(repmat(~mask,[1 1 3])) = 0;

    try
        outputImage = insertShape(outputImage, 'rectangle', redbbox);
        outputImage = insertShape(outputImage, 'rectangle', greenbbox);

        outputImage = insertShape(outputImage, 'line', greenCentroid);
        outputImage = insertShape(outputImage, 'line', redCentroid);
    catch
    end
    
    step(videoPlayer, outputImage);
end
