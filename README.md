# Simple Hand Shape(Palm) Recognition
Recognizing hand shape in simple environment. This code is based on [A GUI Support System for a Sight Handicapped Person By Using Hand Shape Recognition](http://ieeexplore.ieee.org/document/976540) in Matlab. It is considered to recognize seven hand-shapes (classes).


### Preprocessing Image Steps

The proposed algorithm is shown in the following picture, which consists of three steps

![Algorithm](https://user-images.githubusercontent.com/15813546/31728332-e49f9e8e-b438-11e7-9433-3f9ba770e88f.png)

In order to detect skin, I assume to reduce the noise in image using median filter with size 5 by 5. In order to extract skin area,each pixel's channels is mapped to new space using equations (1) and (2). Then thresholds that are shown in equation (3) are used for separating skin/hand areas and binarizing the image. In case the condition for each pixel does not meet the condition in equation (3), it is considered background pixel with black color in image. Otherwise, The pixel is foreground/hand area with white color.

![eq.1](https://user-images.githubusercontent.com/15813546/31732892-de1a65f4-b446-11e7-915b-1c356bbd8c12.jpg)

![eq.2](https://user-images.githubusercontent.com/15813546/31732894-e0d6e22c-b446-11e7-8e59-5e7234e1d0a6.jpg)

![3q.3](https://user-images.githubusercontent.com/15813546/31733259-f6ba4006-b447-11e7-8f2c-8e1c4b18b990.jpg)

### Edge Detection

It is necessary to find edge pixels on palm to find shape of hand in presented algorithm in source code. For this purpose, center of gravity is computed using foreground pixels that are belong to hand region. Then euclidean distance among edge pixels and center of gravity is computed in order to find finger tips that are used for hand shape recognition.

### Recognition Method

In order to find finger tips in the image that is the result of edge detection, the edge pixel whose distance with center of gravity is maximum is considered as finger tips. The algorithm go on this comparison for each edge pixel to find all finger tips.

In addition to finding finger tips, it is needed to draw a line between center of gravity and finger tips in order to compute angle among lines for recognizing hand shape. For instance, there is a specific angle between thumb and index finger. Moreover, it is necessary to consider (draw) a line from the last column (pixel) in the first row of image to the center of gravity. This line is used for recognizing the presence of thumb in image.

Finally, there are 7 class of hand shapes in the project. These classes are shown in the following picture.
![classes](https://user-images.githubusercontent.com/15813546/31741263-799986a4-b460-11e7-9716-7e65335ff87d.jpg)

### Results

you can see in the following pictures the results of running the source. There are two messages that shows the angle of hand and hand shape (class number).

The result for the first class:

![class1](https://user-images.githubusercontent.com/15813546/31741525-66653b5e-b461-11e7-9462-248a387c2daa.jpg)

The result for the second class

![class2](https://user-images.githubusercontent.com/15813546/31741526-66a68118-b461-11e7-8321-9a9da298dadc.jpg)

The result for the third class

![class3](https://user-images.githubusercontent.com/15813546/31741527-66e2fea4-b461-11e7-9bf8-6b45faf8a2dc.jpg)

The result for the fourth class

![class4](https://user-images.githubusercontent.com/15813546/31741529-672b3e1c-b461-11e7-8733-2caafbf103ce.jpg)

The result for the fifth class

![class5](https://user-images.githubusercontent.com/15813546/31741530-676e46bc-b461-11e7-82bc-a8b94a0bad4c.jpg)

The result for the sixth class

![class6](https://user-images.githubusercontent.com/15813546/31741531-67c28772-b461-11e7-8c5d-9c4bbc1d70ed.jpg)

The result for the seventh class

![class7](https://user-images.githubusercontent.com/15813546/31741532-680be890-b461-11e7-9b64-bc36bad53b16.jpg)

### References

[1] R. Thilak kumar, S. Kumar Raja and A. G. Ramakrishnan. “ Eye Detection using Color Cues and Projection Functions” , IEEE ICIP 2002,pp337-340.

[2] Takuro Niidome, Rokuya Ishii . ” A GUI Support System for a Sight Handicapped Person By Using Hand Shape Recognition “,27th Annual Conference of the IEEE Industrial Electronics Society, 2001, vol.1, pp.535-538.
