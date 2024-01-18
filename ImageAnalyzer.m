classdef ImageAnalyzer < handle

    properties
        zapnute

        cam
        video_player

        disk_erode
        disk_dilate
        hBlobAnalysis
    end

    methods
        function self = ImageAnalyzer()
            % self.cam = webcam("/dev/video0");
            % self.cam = webcam("Video Camera");
            self.cam = webcam("Newmine Camera");
            % toto zmeniť podľa potreby

            % self.cam.Resolution = '1250x720';
            % self.cam.Saturation = 64;
            % self.cam.ExposuseMode = 'manual';
            % self.cam.Exposure = 156;
            % self.cam.Contrast = 143;

            self.video_player = vision.VideoPlayer;

            self.disk_erode = strel('disk', 15);
            self.disk_dilate = strel('disk', 5);
            self.hBlobAnalysis = vision.BlobAnalysis(...
            'MinimumBlobArea', 600, ...
            'MaximumBlobArea', 100000);

        end

        function vyska = analyze(self)
            img = self.cam.snapshot();

            red_mask    = createMaskRed(   img);
            green_mask  = createMaskGreen( img);
            silver_mask = createMaskSilver(img);

            red_mask = imerode( red_mask, self.disk_erode);
            red_mask = imdilate(red_mask, self.disk_dilate);
            % red_mask = imopen(red_mask, self.disk);

            green_mask = imerode( green_mask, self.disk_erode);
            green_mask = imdilate(green_mask, self.disk_dilate);
            % green_mask = imopen(green_mask, self.disk);

            silver_mask = imerode( silver_mask, self.disk_erode);
            silver_mask = imdilate(silver_mask, self.disk_dilate);
            % silver_mask = imopen(silver_mask, self.disk);

            [~,    red_centroid,    red_bbox] = step(self.hBlobAnalysis,    red_mask);
            [~,  green_centroid,  green_bbox] = step(self.hBlobAnalysis,  green_mask);
            [~, silver_centroid, silver_bbox] = step(self.hBlobAnalysis, silver_mask);


            output_image = img;

            % mask = green_mask+red_mask + silver_mask; 
            % output_image(repmat(~mask,[1 1 3])) = 0;

            vyska = 50;

            try
                red_center    = (  red_centroid(1,:) +   red_centroid(2,:)) ./ 2;
                green_center  = (green_centroid(1,:) + green_centroid(2,:)) ./ 2;
                silver_center = silver_centroid;

                centers = [ red_center; silver_center; green_center ];

                distance_from_red_center   = sqrt((silver_center(1) -   red_center(1))^2 + (silver_center(2) -   red_center(2))^2);
                distance_from_green_center = sqrt((silver_center(1) - green_center(1))^2 + (silver_center(2) - green_center(2))^2);
                distance_of_centers        = sqrt((red_center(1)    - green_center(1))^2 + (red_center(2)    - green_center(2))^2);

                output_image = insertText(output_image, [20 20],  ['distance from top: ',    num2str(distance_from_red_center)  ]);
                output_image = insertText(output_image, [20 650], ['distance from bottom: ', num2str(distance_from_green_center)]);

                output_image = insertShape(output_image, 'rectangle',    red_bbox);
                output_image = insertShape(output_image, 'rectangle',  green_bbox);
                output_image = insertShape(output_image, 'rectangle', silver_bbox);


                output_image = insertShape(output_image, 'line', green_centroid);
                output_image = insertShape(output_image, 'line',   red_centroid);

                output_image = insertShape(output_image, 'line', centers);

                % toto je iba približné
                vyska = distance_from_green_center/distance_of_centers*100;
            catch
            end
                
            step(self.video_player, output_image);

        end
    end
end
