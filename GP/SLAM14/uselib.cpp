//
// Created by viper on 05/03/2022.
//
#include <iostream>
#include <fstream>
#include <boost/format.hpp>
using namespace std;

// Opencv Lib
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/features2d/features2d.hpp>
using namespace cv;

// Eigen part
//#include <Eigen/Geometry>

// PCL part
//#include <pcl-1.12/pcl/point_types.h>
//#include <pcl-1.12/pcl/io/pcd_io.h>
//#include <pcl-1.12/pcl/visualization/pcl_visualizer.h>
int feature_extraction() {
    // Load image
    Mat img_1 = imread("/home/viper/Resource/slambook2-master/ch7/1.png", IMREAD_COLOR);
    Mat img_2 = imread("/home/viper/Resource/slambook2-master/ch7/2.png", IMREAD_COLOR);

    // Initialization
    vector<KeyPoint> keypoints_1, keypoints_2;
    Mat descriptors_1, descriptors_2;
    Ptr<ORB> orb = ORB::create(500, 1.2f, 8, 31, 0, 2, ORB::HARRIS_SCORE, 31, 20);

    // Step1: Oriented FAST
    orb->detect(img_1, keypoints_1);
    orb->detect(img_2, keypoints_2);

    // Step2: BRIEF
    orb->compute(img_1, keypoints_1, descriptors_1);
    orb->compute(img_2, keypoints_2, descriptors_2);

    Mat outimg1;
    drawKeypoints(img_1, keypoints_1, outimg1, Scalar::all(-1), DrawMatchesFlags::DEFAULT);
    imshow("ORB feature point", outimg1);

    // Step3. Match by BRIEF and Hamming distacne
    vector<DMatch> matches;
    BFMatcher matcher(NORM_HAMMING);
    matcher.match(descriptors_1, descriptors_2, matches);

    // Step4 Filter match point
    double min_dist = 10000, max_dist = 0;
    for (int i = 0; i < descriptors_1.rows; i++) {
        double dist = matches[i].distance;
        if (min_dist > dist) min_dist = dist;
        if (max_dist < dist) max_dist = dist;
    }
    cout << "Max distance: " << max_dist << endl;
    cout << "Min distance: " << min_dist << endl;

    vector<DMatch> good_matches;
    for (int i = 0; i < descriptors_1.rows; i++)
    {
        if (matches[i].distance <= max(2*min_dist, 30.0))
        {
            good_matches.push_back(matches[i]);
        }
    }

    // Step5. Plot
    Mat img_match;
    Mat img_goodmatch;
    drawMatches(img_1, keypoints_1, img_2, keypoints_2, matches, img_match);
    drawMatches(img_1, keypoints_1, img_2, keypoints_2, good_matches, img_goodmatch);
    imshow("Matches point", img_match);
    imshow("Optimized Match point", img_goodmatch);
    waitKey(0);
    return 0;
}
