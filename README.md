# Simple Hand Shape(Palm) Recognition
Recognizing hand shape in simple environment
This code is based on [A GUI Support System for a Sight Handicapped Person By Using Hand Shape Recognition](http://ieeexplore.ieee.org/document/976540) in Matlab. It is considered to recognize seven hand-shapes.


### Preprocessing Image Steps

The proposed algorithm is shown in the following picture, which consists of three steps

![Algorithm](https://user-images.githubusercontent.com/15813546/31728332-e49f9e8e-b438-11e7-9433-3f9ba770e88f.png)

In order to detect skin, I assume to reduce the noise in image using median filter with size 5 by 5. In order to extract skin area,each pixel's channels is mapped to new space using equations (1) and (2). Then thresholds that are shown in equation (3) are used for separating skin/hand areas and binarizing the image. In case the condition does not meet the criteria in a pixel, it is considered background pixel with black color in image.
