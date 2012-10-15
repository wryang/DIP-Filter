DIP-Filter
==========

Objective
----------
This project aims to implement the recognition of handwritten Arabic numerals

Design
----------
Tranning Template
- Firstly, attain the template of 0-9 numbers for next step
```matlab
    [template map] = imread('train.bmp');
    template = ~template;
    
    template = bwmorph(template, 'thin', Inf);
    template = imdilate(template, ones(3,3));
    [template, num] = bwlabel(template);
    imshow(template);
    Tmp = regionprops(template, 'Image', 'Centroid');
```
- handwritten Arabic numerals手写阿拉伯数字 
采用实验图像，进行不变矩变化，并与得到的模板比较；

three main functions-moment, eta and phi-to modify data
主要利用了三个函数moment， eta， phi，并利用不同的扩张值，对数据进行调整；
 
Result
-------
Because of time limit, the result is not perfect and there remains some mismatched numerals. But the rate of correction is up to 80%, so it is acceptable.
 
