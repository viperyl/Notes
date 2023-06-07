#include <opencv/cv.h>
#include <opencv/highgui.h>
#include <iostream>
#include "opencv2/core/core.hpp"
#include "opencv2/highgui/highgui.hpp"
#include "opencv2/opencv.hpp"
#include "vector"

using namespace cv;

int x_0, y_0, x_1, y_1, counter = 0;

//void euclideandistance(int event, int x, int y, int flags, void* img)
//{
//    Mat grayscale;
//    if (event == CV_EVENT_LBUTTONDOWN)
//    {
//        if(counter == 0)
//        {
//            std::cout << "first point" << std::endl;
//            std::cout << x << "   " << y << std::endl;
//            x_0 = x;
//            y_0 = y;
//            counter += 1;
//        }
//        else
//        {
//            std::cout << "second point" << std::endl;
//            std::cout << x << "   " << y << std::endl;
//            x_1 = x;
//            y_1 = y;
//            double distance = sqrt((x_1 - x_0) * (x_1 - x_0) + (y_1 - y_0) * (y_1 - y_0));
//            std::cout << distance << std::endl;
//        }
//    }
//    if (event == CV_EVENT_RBUTTONDOWN)
//    {
//        std::cout << "cleared" << std::endl;
//        counter = 0;
//    }
//}
//
//
//int main()
//{
//    Mat img;
//    int key;
//    bool keepProcessing = true;
//    const std::string  windowsName = "Opencv: Color Query";
//
//    img = imread("/home/yang/Documents/GitHub/Notes/MVR/Img/Castle.jpg");
//    if (!(img).empty())
//    {
//        namedWindow(windowsName, 0);
//        setMouseCallback(windowsName, (CvMouseCallback) euclideandistance, &img);
//        std::cout << "Image: (width x height) = (" << img.cols << " x " << img.rows << ")" << std::endl;
//        std::cout << "Colour channels = " << img.channels() << std::endl;
//        while (keepProcessing)
//        {
//            imshow(windowsName, img);
//            key = waitKey(20);
//            if(key == 'x')
//            {
//                std::cout << "Keyboard exit reguested" << " exiting now - bye!" << std::endl;
//                keepProcessing = false;
//            }
//        }
//        return 0;
//
//    }
//    return -1;
//}

int main()
{
    Mat img, gray;
    img = imread("/home/yang/Documents/GitHub/Notes/MVR/Img/Castle.jpg");
    cvtColor(img, gray, CV_BGR2GRAY);

    Mat bit8, bit6, bit4, bit2;
    bit8 = gray.clone();
    bit6 = gray.clone();
    bit4 = gray.clone();
    bit2 = gray.clone();
    for(int i=0; i<img.rows; i++)
        for(int j=0; j<img.cols; j++)
        {
            bit6.at<uchar>(i,j) = bit8.at<uchar>(i,j) >> 4;
            bit4.at<uchar>(i,j) = bit4.at<uchar>(i,j)/17;
            bit2.at<uchar>(i,j) = bit4.at<uchar>(i,j)/5;
        }
    std::vector<int> params;
    params.push_back(IMWRITE_PNG_COMPRESSION);

    imwrite("/home/yang/Documents/GitHub/Notes/MVR/Img/castleb8.png", bit8, params);
    imwrite("/home/yang/Documents/GitHub/Notes/MVR/Img/castleb6.png", bit6, params);
    imwrite("/home/yang/Documents/GitHub/Notes/MVR/Img/castleb4.png", bit4, params);
    imwrite("/home/yang/Documents/GitHub/Notes/MVR/Img/castleb2.png", bit2, params);

    return 0;
}


