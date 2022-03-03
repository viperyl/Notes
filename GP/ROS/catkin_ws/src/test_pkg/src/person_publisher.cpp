#include <ros/ros.h>
#include "test_pkg/Person.h"

int main(int argc, char **argv)
{
    ros::init(argc, argv, "person_publisher");
    ros::NodeHandle n;
    ros::Publisher person_info_pub = n.advertise<test_pkg::Person>("/person_info", 10);

    ros::Rate loop_rate(1);

    int count = 0;
    while (ros::ok())
    {
        test_pkg::Person person_msg;
        person_msg.name = "Tone";
        person_msg.age = 18;
        person_msg.sex = test_pkg::Person::male;

        person_info_pub.publish(person_msg);
        ROS_INFO("Publish Person Info: name:%s, age:%d, gender:%d", person_msg.name.c_str(), person_msg.age, person_msg.sex);
        loop_rate.sleep();
    }    
    return 0;


}
