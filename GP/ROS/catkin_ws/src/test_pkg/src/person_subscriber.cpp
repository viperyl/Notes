#include <ros/ros.h>
#include "test_pkg/Person.h"

void personInfoCallback(const test_pkg::Person::ConstPtr& msg)
{
    ROS_INFO("Subscribe Peson Info: name:%s, age:%d, sex:%d", msg->name.c_str(), msg->age, msg->sex);
}

int main(int argc, char **argv)
{
    ros::init(argc, argv, "person_subscriber");
    ros::NodeHandle n;
    ros::Subscriber person_info_sub = n.subscribe("/person_info", 10, personInfoCallback);
    ros::spin();
    return 0;
}
