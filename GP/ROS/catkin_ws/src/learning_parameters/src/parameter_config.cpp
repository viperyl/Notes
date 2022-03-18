
#include <string>
#include <ros/ros.h>
#include <std_srvs/Empty.h>


int main(int argc, char **argv)
{
    int red, green, blue;
    ros::init(argc, argv, "parameter_config");
    
    ros::NodeHandle node;
    
    ros::param::get("/turtlesim/background_r", red);
    ros::param::get("/turtlesim/background_b", blue);
    ros::param::get("/turtlesim/background_g", green);

    ROS_INFO("Get background color [%d, %d, %d]", red, green, blue);

    ros::param::set("/turtlesim/background_r", 255);
    ros::param::set("/turtlesim/background_g", 255);
    ros::param::set("/turtlesim/background_b", 255);

    ROS_INFO("Set background color [255, 255, 255]");

    ros::param::get("/turtlesim/background_r", red);
    ros::param::get("/turtlesim/background_b", blue);
    ros::param::get("/turtlesim/background_g", green);

    ROS_INFO("Re-get background color [%d, %d, %d]", red, green, blue);

    ros::service::waitForService("/clear");
    ros::ServiceClient clear_background = node.serviceClient<std_srvs::Empty>("/clear");
    std_srvs::Empty srv;
    clear_background.call(srv);

    sleep(1);

    return 0;
}
