# Simple Hand Shape(Palm) Recognition
Recognizing hand shape in simple environment
This code is based on [A GUI Support System for a Sight Handicapped Person By Using Hand Shape Recognition](http://ieeexplore.ieee.org/document/976540) in Matlab. It is considered to recognize seven hand-shapes.


### Preprocessing Image Steps

The proposed algorithm is shown in the following picture, which consists of three steps

![Algorithm](https://user-images.githubusercontent.com/15813546/31728332-e49f9e8e-b438-11e7-9433-3f9ba770e88f.png)

In order to detect skin, I assume to reduce the noise in image using median filter with size 5 by 5. In order to extract skin area,each pixel's channels is mapped to new space using equations (1) and (2). Then thresholds that are shown in equation (3) are used for separating skin/hand areas and binarizing the image. In case the condition for each pixel does not meet the condition in equation (3), it is considered background pixel with black color in image. Otherwise, The pixel is foreground/hand area with white color.

![eq.1](https://user-images.githubusercontent.com/15813546/31732892-de1a65f4-b446-11e7-915b-1c356bbd8c12.jpg)

![eq.2](https://user-images.githubusercontent.com/15813546/31732894-e0d6e22c-b446-11e7-8e59-5e7234e1d0a6.jpg)

![3q.3](https://user-images.githubusercontent.com/15813546/31732899-e2c0b978-b446-11e7-8a58-46477663276a.jpg)
