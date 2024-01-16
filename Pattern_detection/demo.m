clear
clc
close all

pattern = { imread("kruh.png"), ... 
            imread("hvezda.png"), ...
            imread("trojuhelnik.png"), ...
            imread("srdce.png")};

image = imread("test_image1.jpg");

% thing = PatternLocator(image,pattern1);


tic
total=length(pattern);
for id = 1:total
    thing(id) = PatternLocator(image,pattern{id});
end
toc


for id = 1:length(thing)

    thing.disp(thing(id));
end

