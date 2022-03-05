#include <iostream>
#include <fstream>

using namespace std;
// opencv part
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>

// Eigen part
#include <Eigen/Geometry>

// PCL part
#include <pcl-1.12/pcl/point_types.h>
#include <pcl-1.12/pcl/io/pcd_io.h>
#include <pcl-1.12/pcl/visualization/pcl_visualizer.h>

#include <boost/format.hpp>

#define MATRIX_SIZE 100

int main() {
    vector<cv::Mat> colorImgs, depthImgs;
    vector<Eigen::Isometry3d> poses;

    ifstream fin("/home/yang/Resource/slambook2-master/ch5/rgbd/pose.txt");
    if (!fin) {
        cerr << "cannot open pose.txt" << endl;
        return 1;
    }
    for (int i = 0; i < 5; i++)
    {
        boost::format fmt("/home/yang/Resource/slambook2-master/ch5/rgbd/%s/%d.%s");
        colorImgs.push_back(cv::imread((fmt%"color"%(i+1)%"png").str()));
        depthImgs.push_back(cv::imread((fmt%"depth"%(i+1)%"pgm").str(), -1));

        double data[7] = {0};
        for (auto& d: data)
            fin >> d;
        Eigen::Quaternion q(data[6], data[3], data[4], data[5]);
        Eigen::Isometry3d T(q);
        T.pretranslate(Eigen::Vector3d(data[0], data[1], data[2]));
        poses.push_back(T);
    }
    double cx = 325.0, cy = 235.0, fx = 518.0, fy = 519.0;
    double depthScale = 1000.0;

    cout << "Png to point cloud" << endl;
    // point cloud format XYZRGB
    typedef pcl::PointXYZRGB PointT;
    typedef pcl::PointCloud<PointT> PointCloud;

    // new a point cloud
    PointCloud::Ptr pointCloud(new PointCloud);
    for (int i=0; i<5; i++)
    {
        cout << "Convert " << i+1 << " th" << endl;
        cv::Mat color = colorImgs[i];
        cv::Mat depth = depthImgs[i];
        Eigen::Isometry3d T = poses[i];
        for (int v = 0; v < color.rows; v++)
            for (int u = 0; i < color.cols; u++)
            {
                unsigned int d = depth.ptr<unsigned short> (v)[u];
                if (d == 0) continue;
                Eigen::Vector3d point;
                point[2] = double(d)
            }
    }



    return 0;
}


//int main()
//{
//    Eigen::Matrix3d rotation_matrix = Eigen::Matrix3d::Identity();
//    Eigen::AngleAxisd rotation_vector (M_PI/4, Eigen::Vector3d(0,0,1));
//    cout << "Rotation matrix = \n" << rotation_vector.matrix() << endl;
//    rotation_matrix = rotation_vector.toRotationMatrix();
//    cout << "Rotation matrix = \n" << rotation_matrix << endl;
//
//    Eigen::Vector3d v(1,0,0);
//    Eigen::Vector3d v_rotated = rotation_vector * v;
//    cout << v.transpose() << ":  " << v_rotated.transpose() << endl;
//
//    v_rotated = rotation_matrix * v;
//    cout << "result: " << v_rotated.transpose() << endl;
//
//    Eigen::Vector3d euler_angles = rotation_matrix.eulerAngles(2, 1, 0);
//    cout << "Yaw pitch roll: " << euler_angles.transpose() << endl;
//
//
//
//    return 0;
//}

//int main() {
//    Eigen::Matrix<float, 2, 3> matrix_23;
//    Eigen::Vector3d v3d;
//    Eigen::Matrix3d matrix_33 = Eigen::Matrix3d::Zero();
//    Eigen::Matrix<double, Eigen::Dynamic, Eigen::Dynamic> matrix_dynamic;
//    Eigen::MatrixXd matrix_x;
//    matrix_23 << 2, 3 ,4 ,5 ,6, 7;
//    cout << matrix_23 << endl;
//    for (int i = 0; i < 1; i++)
//        for (int j = 0; j < 2; j++)
//            cout << matrix_23(i,j) << endl;
//
//    Eigen::Matrix<double, 2, 1> result = matrix_23.cast<double>() * v3d;
//    cout << result << endl;
//
//    matrix_33 = Eigen::Matrix3d::Random();
//    cout << matrix_33 << endl << endl;
//
//    cout << "transpose" << endl;
//    cout << matrix_33.transpose() << endl;
//    cout << "sum" << endl;
//    cout << matrix_33.sum() << endl;
//    cout << "trace" << endl;
//    cout << matrix_33.trace() << endl;
//    cout << "times" << endl;
//    cout << matrix_33 * 10 << endl;
//    cout << "inverse" << endl;
//    cout << matrix_33.inverse() << endl;
//    cout << "determinant" << endl;
//    cout << matrix_33.determinant() << endl;
//
//    Eigen::SelfAdjointEigenSolver<Eigen::Matrix3d> eigen_solver (matrix_33.transpose() * matrix_33);
//    cout << "Eigenvalue" << endl;
//    cout << eigen_solver.eigenvalues() << endl;
//    cout << "Eigenvector" << endl;
//    cout << eigen_solver.eigenvectors() << endl;
//
//    Eigen::Matrix<double, MATRIX_SIZE, MATRIX_SIZE> matrix_NN;
//    matrix_NN = Eigen::MatrixXd::Random(MATRIX_SIZE, MATRIX_SIZE);
//    Eigen::Matrix<double, MATRIX_SIZE, 1> v_Nd;
//    v_Nd = Eigen::MatrixXd::Random(MATRIX_SIZE, 1);
//    clock_t time_stt = clock();
//    Eigen::Matrix<double, MATRIX_SIZE, 1> x = matrix_NN.inverse() * v_Nd;
//    cout << "time use: " << 1000 * (clock() - time_stt)/(double)CLOCKS_PER_SEC << " ms" << endl;
//
//    time_stt = clock();
//    x = matrix_NN.colPivHouseholderQr().solve(v_Nd);
//    cout << "time use: " << 1000 * (clock() - time_stt)/(double)CLOCKS_PER_SEC << " ms" << endl;
//
//
//    v3d << 1, 2, 3;
//
//    return 0;
//}
