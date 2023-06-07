#include <opencv/cv.h>
#include <opencv/highgui.h>
#include <iostream>
#include "opencv2/core/core.hpp"
#include "opencv2/highgui/highgui.hpp"
#include "opencv2/opencv.hpp"

using namespace cv;
void colourQueryMouseCallBack(int event, int x, int y, int flags, void* img, int* xy, int* xx)
{
    // Black 0,0,0      White 255, 255, 255     Red 255,0,0     Green 0,255,0
    // Blue 0,0,255     Light Gray 211,211,211      Dark Gray 169,169,169
    // Yellow 255,255,224   Purple 230,230,250
    int color[3] = {211,211,211};
    int row = y;
    int col = x;
    if (event == CV_EVENT_LBUTTONDOWN)
    {
        std::cout << "Colour information at image location (" << x << ", " << y << "):";
        for (int channel = 0; channel < 3; channel++)
        {
            std::cout << (unsigned int) ((Mat*) img)->at<Vec3b>(row,col)[channel] << " ";
        }
        std::cout << std::endl;
    }
    else if (event == CV_EVENT_RBUTTONDOWN)
    {
        std::cout << "Colour information at image location (" << x << ", " << y << ") set to white.";
        for (int channel = 0; channel < 3; channel++)
        {
            ((Mat*) img)->at<Vec3b>(row,col)[channel] = color[channel];
        }
        std::cout << std::endl;
    }
}
void colour5x5QueryMouseCallBack(int event, int x, int y, int flags, void* img)
{
    int color[3] = {211,211,211};
    int row = y;
    int col = x;
    int top = max(y - 2, 0);
    int lef = max(x - 2, 0);
    int bot = min(y + 2, ((Mat*) img)->rows);
    int rig = min(x + 2, ((Mat*) img)->cols);

    if (event == CV_EVENT_LBUTTONDOWN)
    {
        std::cout << "Colour information at image location (" << x << ", " << y << "):";
        for (int channel = 0; channel < 3; channel++)
        {
            std::cout << (unsigned int) ((Mat*) img)->at<Vec3b>(row,col)[channel] << " ";
        }
        std::cout << std::endl;
    }
    else if (event == CV_EVENT_RBUTTONDOWN)
    {
        std::cout << "Colour information at image location (" << x << ", " << y << ") set to white.";
        for (int i = top; i < bot; i++)
            for (int j = lef; j < rig; j++)
                for (int channel = 0; channel < 3; channel++)
                {
                    ((Mat*) img)->at<Vec3b>(i,j)[channel] = color[channel];
                }

        std::cout << std::endl;
    }
}

void colour100x100QueryMouseCallBack(int event, int x, int y, int flags, void* img)
{
    int top = max(y - 50, 0);
    int lef = max(x - 50, 0);
    int bot = min(y + 50, ((Mat*) img)->rows);
    int rig = min(x + 50, ((Mat*) img)->cols);
    Mat subImg = ((Mat*)img)->clone();
    if (event == CV_EVENT_RBUTTONDOWN)
    {
        //Rect roi(top, lef, bot, rig);
        Rect roi(lef, top, rig-lef, bot-top);
        std::cout << min(100, rig-lef) << "  " << min(100,bot-top) << std::endl;
        Mat ssubImg = subImg(roi);
//        Mat aImg = Mat(*(Mat*)img, roi);
        namedWindow("SubImage", 0);
        imshow("SubImage", ssubImg);

    }
}
void grayscaleQueryMouseCallBack(int event, int x, int y, int flags, void* img)
{

    Mat grayscale;
    Mat subImg = ((Mat*)img)->clone();
    cvtColor(subImg, grayscale, CV_BGR2GRAY);
    if (event == CV_EVENT_RBUTTONDOWN)
    {
        //Rect roi(top, lef, bot, rig);
//        Mat aImg = Mat(*(Mat*)img, roi);
        namedWindow("SubImage", 0);
        imshow("SubImage", grayscale);

    }
}

void rectangleQueryMouseCallBack(int event, int x, int y, int flags, void* img)
{
    int row = y;
    int col = x;
    int top = max(y - 5, 0);
    int lef = max(x - 5, 0);
    int bot = min(y + 5, ((Mat*) img)->rows);
    int rig = min(x + 5, ((Mat*) img)->cols);
    if (event == CV_EVENT_RBUTTONDOWN)
    {
        rectangle(*(Mat *) img, Point(lef, top), Point(rig, bot), Scalar(0, 0, 255), 1, LINE_8);
    }
}



int main()
{
    Mat img;
    int key;
    bool keepProcessing = true;
    const std::string  windowsName = "Opencv: Color Query";

    img = imread("/home/yang/Documents/GitHub/Cranfield_Robotics/MVR/Practice/Img/road.jpg");
    if (!(img).empty())
    {
        namedWindow(windowsName, 0);
        setMouseCallback(windowsName, (CvMouseCallback) rectangleQueryMouseCallBack, &img);
        std::cout << "Image: (width x height) = (" << img.cols << " x " << img.rows << ")" << std::endl;
        std::cout << "Colour channels = " << img.channels() << std::endl;
        while (keepProcessing)
        {
            imshow(windowsName, img);
            key = waitKey(20);
            if(key == 'x')
            {
                std::cout << "Keyboard exit reguested" << " exiting now - bye!" << std::endl;
                keepProcessing = false; 
            }
        }
        return 0;

    }
    return -1;
}



