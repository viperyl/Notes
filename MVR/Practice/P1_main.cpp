#include <iostream>
#include <vector>
#include "opencv2/core/core.hpp"
#include "opencv2/opencv.hpp"
#include "opencv2/highgui/highgui.hpp"
# define PI          3.141592653589793238462643383279502884L
using namespace cv;
// Day one code
int main() {
    Mat grayscale;
    Mat image = imread("/home/yang/Documents/GitHub/Cranfield_Robotics/MVR/Practice/Img/lena.bmp");
    cvtColor(image, grayscale, COLOR_BGR2GRAY);
    Mat flipped;
    flip(image, flipped, 0);
    Mat edge;
    Canny(image,edge, 180, 255);
    Mat gaussian;
    GaussianBlur(grayscale, gaussian, Size( 5, 5 ), 0, 0 );
    Mat resize_down;
    resize(image, resize_down, Size(200, 200), INTER_LINEAR);
    Mat resize_up;
    resize(image, resize_up, Size(4000, 2000), INTER_MAX);
    imshow("mytest",resize_down);
    waitKey(0);


    return 0;
}
