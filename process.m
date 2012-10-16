function process(path, filterType, D0, W0, processMethod)
% MAINWIN MATLAB code for mainWin.fig
    % for the fifth homwork of digital process 
    % this function is for a interface of GUI and function 'Filter' and
    % 'FColorConv';
    % 'Filter' can implement some filter conversions, e.g. ILBF, BLPF,
    % ELPF, IHPF, BHPF, EHPF, IBPF, IBSF, BBPF, BBSF;
    % 'FColorConv' can convert the image to false color; 
    % processMethod indicates for Filter or FColorConv; 
    if isempty(D0)
        D0 = 10;
    else
        D0 = str2num(D0);
    end
    
    if isempty(W0)
        W0 = 5;
    else
        W0 = str2num(W0);
    end
    [img, map] = imread(path);
    if(strcmp(processMethod,'Filter'))
        [resultImg]=Filter(img, filterType, D0, W0);
    elseif(strcmp(processMethod,'FColorConv'))
        [resultImg]=FColorConv(img, filterType, D0);
    end
    
    figure, imshow(resultImg), title(strcat(filterType,'±ä»»'));
end

function [resultImg] = Filter(sourceImg, filterType, D0, W0)
    %Fourier transform
    img = fft2(sourceImg); 
    %trans. to center 
    img = fftshift(img);
    
    [width, height] = size(sourceImg);
    resultImg = zeros(width, height);
    
    if(strcmp(filterType,'ILPF'))
        resultImg=ILPF(img, D0);
    elseif(strcmp(filterType,'BLPF'))
        resultImg=BLPF(img, D0);
    elseif(strcmp(filterType,'ELPF'))
        resultImg=ELPF(img, D0);
    elseif(strcmp(filterType,'IHPF'))
        resultImg=IHPF(img, D0);
    elseif(strcmp(filterType,'BHPF'))
        resultImg=BHPF(img, D0);
    elseif(strcmp(filterType,'EHPF'))
        resultImg=EHPF(img, D0);
    elseif(strcmp(filterType,'IBPF'))
        resultImg=IBPF(img, D0, W0);
    elseif(strcmp(filterType,'IBSF'))
        resultImg=IBSF(img, D0, W0);
    elseif(strcmp(filterType,'BBPF'))
        resultImg=BBPF(img, D0, W0);
    elseif(strcmp(filterType,'BBSF'))
        resultImg=BBSF(img, D0, W0);
    end
   resultImg = (uint8(resultImg));
end

function [resultImg] = ILPF(sourceImg, D0)
    %get filter model
    [width, height] = size(sourceImg);
    resultImg = zeros(width, height);
    filterFunc = zeros(width, height);
    center_x = width/2;
    center_y = height/2;
    
    for x = 1:width
        for y = 1:height
            u = abs( x - center_x);
            v = abs( y - center_y);
            
            D = sqrt(u^2 + v^2);
            if(D <= D0)
                filterFunc(x, y) = 1.0;
            else
                filterFunc(x, y) = 0;
            end
        end
    end
    
    resultImg = getFilterResult(sourceImg, filterFunc);
end

function [resultImg] = BLPF(sourceImg, D0)
    %get filter model
    [width, height] = size(sourceImg);
    resultImg = zeros(width, height);
    filterFunc = zeros(width, height);
    center_x = width/2;
    center_y = height/2;
    
    for x = 1:width
        for y = 1:width
            u = x - center_x;
            v = y - center_y;
            
            filterFunc(x, y) = 1 / (1 + ((u^2 + v^2) / D0^2));
        end
    end
    
    resultImg = getFilterResult(sourceImg, filterFunc);
end

function [resultImg] = ELPF(sourceImg, D0)
    %get filter model
    [width, height] = size(sourceImg);
    resultImg = zeros(width, height);
    filterFunc = zeros(width, height);
    center_x = width/2;
    center_y = height/2;
    
    for x = 1:width
        for y = 1:width
            u = x - center_x;
            v = y - center_y;
            
            filterFunc(x, y) = exp(-(u^2 + v^2) / D0^2);
        end
    end
    
    resultImg = getFilterResult(sourceImg, filterFunc);
end

function [resultImg] = IHPF(sourceImg, D0)
    %get filter model
    [width, height] = size(sourceImg);
    resultImg = zeros(width, height);
    filterFunc = zeros(width, height);
    center_x = width/2;
    center_y = height/2;
    
    for x = 1:width
        for y = 1:width
            u = abs( x - center_x);
            v = abs( y - center_y);
            
            D = sqrt(u^2 + v^2);
            if(D <= D0)
                filterFunc(x, y) = 0;
            else
                filterFunc(x, y) = 1.0;
            end
        end
    end
    
    resultImg = getFilterResult(sourceImg, filterFunc);
end

function [resultImg] = BHPF(sourceImg, D0)
    %get filter model
    [width, height] = size(sourceImg);
    resultImg = zeros(width, height);
    filterFunc = zeros(width, height);
    center_x = width/2;
    center_y = height/2;
    for x = 1:width
        for y = 1:width
            u = x - center_x;
            v = y - center_y;
            
            filterFunc(x, y) = 1 / (1 + (D0^2 / (u^2 + v^2)));
        end
    end
    
    resultImg = getFilterResult(sourceImg, filterFunc);
end

function [resultImg] = EHPF(sourceImg, D0)
    %get filter model
    [width, height] = size(sourceImg);
    resultImg = zeros(width, height);
    filterFunc = zeros(width, height);
    center_x = width/2;
    center_y = height/2;
    
    for x = 1:width
        for y = 1:width
            u = x - center_x;
            v = y - center_y;
            
            filterFunc(x, y) = exp(-(D0^2 / (u^2 + v^2)));
        end
    end
    
    resultImg = getFilterResult(sourceImg, filterFunc);
end

function [resultImg] = IBPF(sourceImg, D0, W0)
    %get filter model
    [width, height] = size(sourceImg);
    resultImg = zeros(width, height);
    filterFunc = zeros(width, height);
    center_x = width/2;
    center_y = height/2;
    
    for x = 1:width
        for y = 1:width
            u = abs( x - center_x);
            v = abs( y - center_y);
            
            D = sqrt(u^2 + v^2);
            F1 = D0 - W0/2;
            F2 = D0 + W0/2;
            if(D >= F1 && D <= F2)
                filterFunc(x, y) = 1.0;
            else
                filterFunc(x, y) = 0;
            end
        end
    end
    
    resultImg = getFilterResult(sourceImg, filterFunc);
end

function [resultImg] = IBSF(sourceImg, D0, W0)
    %get filter model
    [width, height] = size(sourceImg);
    resultImg = zeros(width, height);
    filterFunc = zeros(width, height);
    center_x = width/2;
    center_y = height/2;
    
    for x = 1:width
        for y = 1:width
            u = abs( x - center_x);
            v = abs( y - center_y);
            
            D = sqrt(u^2 + v^2);
            F1 = D0 - W0/2;
            F2 = D0 + W0/2;
            if(D >= F1 && D <= F2)
                filterFunc(x, y) = 0;
            else
                filterFunc(x, y) = 1.0;
            end
        end
    end
    
    resultImg = getFilterResult(sourceImg, filterFunc);
end

function [resultImg] = BBPF(sourceImg, D0, W0)
    %get filter model
    [width, height] = size(sourceImg);
    resultImg = zeros(width, height);
    filterFunc = zeros(width, height);
    center_x = width/2;
    center_y = height/2;
    
    for x = 1:width
        for y = 1:width
            u = abs( x - center_x);
            v = abs( y - center_y);
            
            D = sqrt(u^2 + v^2);
            filterFunc(x, y) = 1 / (1 + (((D^2 - D0^2)^2)/(D^2 * W0^2)));
        end
    end
    
    resultImg = getFilterResult(sourceImg, filterFunc);
end

function [resultImg] = BBSF(sourceImg, D0, W0)
    %get filter model
    [width, height] = size(sourceImg);
    resultImg = zeros(width, height);
    filterFunc = zeros(width, height);
    center_x = width/2;
    center_y = height/2;
    
    for x = 1:width
        for y = 1:width
            u = abs( x - center_x);
            v = abs( y - center_y);
            
            D = sqrt(u^2 + v^2);
            filterFunc(x, y) = 1 / (1 + ((D^2 * W0^2) / ((D^2 - D0^2)^2)));
        end
    end
    
    resultImg = getFilterResult(sourceImg, filterFunc);
end

function [resultImg] = getFilterResult(sourceImg, filterFunc)
   [width, height] = size(sourceImg);
   resultImg = zeros(width, height);
   
   for x = 1:width
       for y = 1:height
           resultImg(x, y) = sourceImg(x, y) * filterFunc(x, y);
       end
   end
   
   %inverse transform
    resultImg = real(ifft2(ifftshift(resultImg)));
end

function [resultImg] = FColorConv(sourceImg, filterType, D0)
    
    [width, height] = size(sourceImg);
    tempImg = zeros(width, height);
    
    if(strcmp(filterType,'BLPF'))
        tempImg=Filter(sourceImg, 'BLPF', D0, 0);
    elseif(strcmp(filterType,'BHPF'))
        tempImg=Filter(sourceImg, 'BHPF', D0, 0);
    end

    
    resultImg = zeros(width, height, 3); 
    red_weight = Filter(tempImg, 'BLPF', 5, 0);
    green_weight = Filter(tempImg, 'BHPF', 50, 0);
    blue_weight = Filter(tempImg, 'BBPF', 12, 16);

    for x = 1:width
        for y = 1:height
            resultImg(x, y, 1) = red_weight(x, y);
            resultImg(x, y, 2) = green_weight(x, y);
            resultImg(x, y, 3) = blue_weight(x, y);
        end
    end
end