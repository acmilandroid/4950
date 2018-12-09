%%  shape_detection.m
%   Dowel Column Definitions:
%   1: row
%   2: column
%   3: color
%       (1 - red, 2 - green, 3 - blue, 4 - yellow)
%   4: shape
%       (1 - square, 2 - circle, 3 - triangle)
%   5: piece type 
%       (1 - king, 2 - queen, 3 - rook, 4 - bishop, 5 - knight, 6 - pawn)
%   6: team (1 or 2)

function dowel = shape_detection(topleft, bottomright, cam)
    
    sizex = bottomright(1)-topleft(1);
    sizey = bottomright(2)-topleft(2);
    
    pic = snapshot(cam);
    %pic = imread('im.jpg');
    se = strel('disk',1);
    
    pic = imcrop(pic,[topleft(1),topleft(2),sizey-1,sizex-1]);

    % remove shadows
     for i = 1:sizex
         for j = 1:sizey
            if pic(i,j,1) > 100 && pic(i,j,1) < 130 && pic(i,j,2) > 95 && pic(i,j,2) < 120 && pic(i,j,3) > 80 && pic(i,j,3) < 95
                pic(i,j,1) = 255;
                pic(i,j,2) = 255;
                pic(i,j,3) = 255;
            end
            if pic(i,j,1) < 70 && pic(i,j,2) < 60 && pic(i,j,3) < 70
                pic(i,j,1) = 255;
                pic(i,j,2) = 255;
                pic(i,j,3) = 255;
            end
            if pic(i,j,1) > 90 && pic(i,j,2) > 90 && pic(i,j,3) > 90
                pic(i,j,1) = 255;
                pic(i,j,2) = 255;
                pic(i,j,3) = 255;
            end
        end
     end
     
    % get red things
    sub_red = imsubtract(pic(:,:,1), rgb2gray(pic));
    bw_red = im2bw(sub_red, 0.21);
    bw_red = bwareaopen(bw_red,70);
    [~, num_red] = bwlabel(bw_red);
    
    sub_blue = pic;
    for i = 1:sizex
        for j = 1:sizey
            if pic(i,j,1) < 90 && pic(i,j,2) < 100 && pic(i,j,3) > 70
                sub_blue(i,j,1) = 255;
                sub_blue(i,j,2) = 255;
                sub_blue(i,j,3) = 255;
            else
                sub_blue(i,j,1) = 0;
                sub_blue(i,j,2) = 0;
                sub_blue(i,j,3) = 0;
            end
        end
    end
    bw_blue = im2bw(sub_blue,0.06);
    bw_blue = imerode(bw_blue, se);
    bw_blue = bwareaopen(bw_blue,70);
    [~, num_blue] = bwlabel(bw_blue);
    
    % get green things
    sub_green = pic;
    for i = 1:sizex
        for j = 1:sizey
            if pic(i,j,1) < 70 && pic(i,j,2) > 74 && pic(i,j,3) < 100
                sub_green(i,j,1) = 255;
                sub_green(i,j,2) = 255;
                sub_green(i,j,3) = 255;
            else
                sub_green(i,j,1) = 0;
                sub_green(i,j,2) = 0;
                sub_green(i,j,3) = 0;
            end
        end
    end
    bw_green = im2bw(sub_green,0.01);
    bw_green = bwareaopen(bw_green,70);
    bw_green = imdilate(bw_green, se); 
    bw_green = imerode(bw_green, se);
    [~, num_green] = bwlabel(bw_green);

    % get yellow things
    sub_yellow = pic;
    for i = 1:sizex
        for j = 1:sizey
            if pic(i,j,1) > 100 && pic(i,j,2) > 100 && pic(i,j,3) < 100
                sub_yellow(i,j,1) = 255;
                sub_yellow(i,j,2) = 255;
                sub_yellow(i,j,3) = 255;
            else
                sub_yellow(i,j,1) = 0;
                sub_yellow(i,j,2) = 0;
                sub_yellow(i,j,3) = 0;
            end
        end
    end
    bw_yellow = im2bw(sub_yellow,0.06);
    bw_yellow = imerode(bw_yellow, se);
    bw_yellow = bwareaopen(bw_yellow,70);
    [~, num_yellow] = bwlabel(bw_yellow);

    total_pieces = num_red + num_blue + num_green + num_yellow;

 
    % get region properties of each color
    props_red = regionprops(bw_red,'centroid','area');
    props_blue = regionprops(bw_blue,'centroid','area');
    props_green = regionprops(bw_green,'centroid','area');
    props_yellow = regionprops(bw_yellow,'centroid','area');

    % find shapes for each piece
    if num_red ~= 0
        for i = 1:num_red
            if props_red(i).Area < 230 %triangle
                props_red(i).shape = 3;
            elseif props_red(i).Area >= 500 %circle
                props_red(i).shape = 2;
            else %square
                props_red(i).shape = 1;
            end
        end
    end

    if num_green ~= 0
        for i = 1:num_green
            if props_green(i).Area < 230 %triangle
                props_green(i).shape = 3;
            elseif props_green(i).Area >= 500 %circle
                props_green(i).shape = 2;
            else %square
                props_green(i).shape = 1;
            end
        end
    end

    if num_blue ~= 0
        for i = 1:num_blue
            if props_blue(i).Area < 230 %triangle
                props_blue(i).shape = 3;
            elseif props_blue(i).Area >= 500 %circle
                props_blue(i).shape = 2;
            else %square
                props_blue(i).shape = 1;
            end
        end
    end

    if num_yellow ~= 0
        for i = 1:num_yellow
            if props_yellow(i).Area < 230 %triangle
                props_yellow(i).shape = 3;
            elseif props_yellow(i).Area >= 500 %circle
                props_yellow(i).shape = 2;
            else %square
                props_yellow(i).shape = 1;
            end
        end
    end

    dowel = zeros(total_pieces,6); %creates array for dowel data

    i = 0;
    j = 0;
    k = 0;
    l = 0;

    % assign dowels to array
    % dowel(:,1) is x value of centroid
    % dowel(:,2) is y value of centroid
    % dowel(:,3) is color of piece
    % dowel(:,4) is shape of piece
    % dowel(:,5) is type of piece
    % red = 1, green = 2, blue = 3, yellow = 4
    % square = 1, circle = 2, triangle = 3
    if num_red ~= 0
        for i = 1:num_red
            dowel(i,1) = props_red(i).Centroid(2);                  %centroid rows
            dowel(i,2) = props_red(i).Centroid(1);                  %centroid cols
            dowel(i,3) = 1;                                         %color
            dowel(i,4) = props_red(i).shape;                        %shape
        end
    end

    if num_green ~= 0
        for j = 1:num_green
            dowel(i+j,1) = props_green(j).Centroid(2);
            dowel(i+j,2) = props_green(j).Centroid(1);
            dowel(i+j,3) = 2;
            dowel(i+j,4) = props_green(j).shape;
        end
    end

    if num_blue ~= 0
        for k = 1:num_blue
            dowel(i+j+k,1) = props_blue(k).Centroid(2);
            dowel(i+j+k,2) = props_blue(k).Centroid(1);
            dowel(i+j+k,3) = 3;
            dowel(i+j+k,4) = props_blue(k).shape;
        end
    end

    if num_yellow ~= 0
        for l = 1:num_yellow
            dowel(i+j+k+l,1) = props_yellow(l).Centroid(2);
            dowel(i+j+k+l,2) = props_yellow(l).Centroid(1);
            dowel(i+j+k+l,3) = 4;
            dowel(i+j+k+l,4) = props_yellow(l).shape;
        end
    end
end


