DIP-Filter
==========

Objective
----------
This project aims to implement the recognition of handwritten Arabic numerals using Geometric Invariant Moment

Design
----------

Tranning Template
- Firstly, attain the templates of 0-9 numbers for next step
```matlab
    [template map] = imread('train.bmp');
    template = ~template;
    
    template = bwmorph(template, 'thin', Inf);
    template = imdilate(template, ones(3,3));
    [template, num] = bwlabel(template);
    imshow(template);
    Tmp = regionprops(template, 'Image', 'Centroid');
```
![Hand Written Numerals](https://dl-web.dropbox.com/get/Public/weibao/StandardNumerals.png?w=f739d96d)
- handwritten Arabic numerals
![Hand Written Numerals](https://dl-web.dropbox.com/get/Public/weibao/HandWrittenNumerals.png?w=29fb9c6b)

Using Geometric Invariant Moment to modify images, attain templates and compare with standard templates
The process mainly uses three main functions, moment, eta and phi, with dilatation value to modify data
 
Result
-------
Because of time limit, the result is not perfect and there remains some mismatched numerals. But the rate of correction is up to 80%, so it is acceptable.
![Result Screen Shot](https://dl-web.dropbox.com/get/Public/weibao/ResultScreenShot.png?w=55e479e3)