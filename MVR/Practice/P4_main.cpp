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
    Mat img, gau, bwn, canny, gray, cur, absd, ori;
    std::string fName = "/home/yang/Documents/GitHub/Notes/MVR/Img/";
    std::string fName1;
    const std::string windowName = "OPENCV: live image display";
    bool keepProcessing = true;
    int key;
    namedWindow(windowName, 1);
    namedWindow("GaussianBlurred", 2);
    namedWindow("Bitwise not", 3);
    namedWindow("Canny",4);
    namedWindow("Abs difference", 5);
    VideoCapture cap(0);

    if (!cap.isOpened())
    {
        std::cout << "Error: could not grab a frame" << std::endl;
        exit(0);
    }
    cap >> img;
    Mat last = img.clone();
    time_t start, end;
    time(&start);
    double dif;
    int counter = 0;
    std::vector<int> params(1);
    params.push_back(IMWRITE_PNG_COMPRESSION);

    while (keepProcessing)
    {
        cap >> img;
        ori = img.clone();
        circle( ori, Point(img.cols/2, img.rows/2),50,Scalar( 0, 0, 255 ),1,LINE_8 );
        cur = img.clone();
        absdiff(last, cur, absd);
        GaussianBlur(img, gau, Size(7, 7), 0, 0);
        bitwise_not(img, bwn);
        cvtColor(img, gray, CV_BGR2GRAY);
        Canny(gray, canny, 180, 255, 3);
        imshow(windowName, ori);
        imshow("GaussianBlurred", gau);
        imshow("Bitwise not", bwn);
        imshow("Canny", canny);
        imshow("Abs difference", absd);

        last = img.clone();
        key = waitKey(20);
        time(&end);
        dif = difftime(end, start);
        if ((int)dif%30==0)
        {
            fName1 = fName + std::to_string(counter++) + ".png";
            imwrite(fName1, img, params);
        }
        if(key == 'c')
        {
            std::cout << "Keyboard exit reguested" << " exiting now - bye!" << std::endl;
            keepProcessing = false;
        }
    }
    return 0;

}


