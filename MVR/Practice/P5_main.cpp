#include <opencv/cv.h>
#include <opencv/highgui.h>
#include <iostream>
#include "opencv2/core/core.hpp"
#include "opencv2/highgui/highgui.hpp"
#include "opencv2/opencv.hpp"
#include "vector"

using namespace cv;

int main()
{
    Mat img;
    VideoCapture cap(0);
    if (!cap.isOpened())
    {
        std::cout << "where are your camera?" << std::endl;
        exit(0);
    }
    cap >> img;
    VideoWriter videoOptput("/home/yang/Documents/GitHub/Notes/MVR/Img/test.avi",
                            VideoWriter::fourcc('D', 'I', 'V', 'X'), 25, img.size(), true);
    if (!videoOptput.isOpened())
    {
        std::cout << "videowriter wrong" << std::endl;
        exit(0);
    }
    int nFrames = 500;

    Mat bwn;
    for (int i = 0; i < nFrames; i++)
    {
        cap >> img;
        bitwise_not(img, bwn);
        videoOptput << bwn;
    }
    return 0;
}


