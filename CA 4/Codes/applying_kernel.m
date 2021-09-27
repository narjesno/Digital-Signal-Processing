function paniced_data = applying_kernel(data, kernel)

 paniced_data(:, : ,1) = conv2( data(:, :, 1), kernel);
 paniced_data(:, : ,2) = conv2( data(:, :, 2), kernel);
 paniced_data(:, : ,3) = conv2( data(:, :, 3), kernel);

 paniced_data = uint8(abs(paniced_data));
 
 figure
 imshow(paniced_data);
 
end

