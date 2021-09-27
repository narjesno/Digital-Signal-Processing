%%
%spatial domain filtering
clc
clear
close all
bluish = [127, 247, 255]/256;
whitish = [229, 253, 255]/256;
%%
%kernels

sharpen = [0 -1 0; -1 5 -1;0 -1 0];

blur = [.0625 .125 .0625; .125 .25 .125;.0625 .125 .0625];

outline = [-1 -1 -1; -1 8 -1;-1 -1 -1];

gauss = [.0113 .0838 .0113; .0838 .6193 .0838;.0113 .1111 .0113];

avg_moving = [.1111 .1111  .1111;.1111 .1111  .1111;.1111 .1111  .1111];

line_H = [-1 -1 -1; 2 2 2;-1 -1 -1];

line_V = [-1 2 -1; -1 2 -1;-1 2 -1];

identity = [0 0 0; 0 1 0;0 0 0];

%%
%house
clc
close all

house = imread('data\house.jpg');

sharpend_house = applying_kernel(house, sharpen);
title("Sharpend House");

blured_house = applying_kernel(house, blur);
title("Blured House");

outlined_house = applying_kernel(house, outline);
title("Outlined House");

gaussed_house = applying_kernel(house, gauss);
title("Gaussed House");

moving_avged_house = applying_kernel(house, avg_moving);
title("Moving avged House");

H_lined_house = applying_kernel(house, line_H);
title("H lined House");

V_lined_house = applying_kernel(house, line_V);
title("V lined House");

identified_house = applying_kernel(house, identity);
title("Identified House");

%%
%kobe
clc
close all

kobe = imread('data\kobe.jpeg');
imshow(kobe);

downsampled_kobe = imresize(kobe, 0.2);
imshow(downsampled_kobe);
title("Downsampled");
figure
upsampled_kobe = imresize(downsampled_kobe,5, 'nearest');
imshow(upsampled_kobe);
title("Upsampled");

gaussed_kobe = applying_kernel(upsampled_kobe, gauss);
changed_kobe = applying_kernel(gaussed_kobe, avg_moving);
title("Upsampled-gaussed-avg moved");

%%
%paper
clc
close all

page = imread('data\page.jpg');
gray_page = rgb2gray(page);

V_lined_gpage = conv2( gray_page(:, :), line_V);
imshow(V_lined_gpage);
title("V lined Gray Paper");
figure

H_lined_gpage = conv2( gray_page(:, :), line_H);
imshow(H_lined_gpage);
title("H lined Gray Paper");

HKmedian = medfilt2(medfilt2(H_lined_gpage));
VKmedian = medfilt2(medfilt2(V_lined_gpage));


%%
clc
Hsum = sum(HKmedian, 2);

desired_Hmat = remove_unwanted_data(Hsum);
plot(desired_Hmat,'color', bluish);
grid on 

[y2_location, y2_max_peak, removed_max] = find_position(desired_Hmat);
[y1_location, y1_max_peak, removed_max] = find_position(removed_max);



%%
clc
Vsum = sum(VKmedian);

desired_Vmat = remove_unwanted_data(Vsum');
plot(desired_Vmat,'color', bluish);
grid on 

[x2_location, x2_max_peak, removed_max] = find_position(desired_Vmat);
[x1_location, x1_max_peak, removed_max] = find_position(removed_max);


%%
clc
close all

imshow(page)
hight = y2_location - y1_location;
width = x2_location - x1_location;

rectangle('Position',[x1_location y1_location width hight], 'FaceColor',whitish , 'EdgeColor', bluish,'LineWidth',2 )

