// Generated by gencpp from file l_service/PersonRequest.msg
// DO NOT EDIT!


#ifndef L_SERVICE_MESSAGE_PERSONREQUEST_H
#define L_SERVICE_MESSAGE_PERSONREQUEST_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace l_service
{
template <class ContainerAllocator>
struct PersonRequest_
{
  typedef PersonRequest_<ContainerAllocator> Type;

  PersonRequest_()
    : name()
    , age(0)
    , sex(0)  {
    }
  PersonRequest_(const ContainerAllocator& _alloc)
    : name(_alloc)
    , age(0)
    , sex(0)  {
  (void)_alloc;
    }



   typedef std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other >  _name_type;
  _name_type name;

   typedef uint8_t _age_type;
  _age_type age;

   typedef uint8_t _sex_type;
  _sex_type sex;



// reducing the odds to have name collisions with Windows.h 
#if defined(_WIN32) && defined(unknown)
  #undef unknown
#endif
#if defined(_WIN32) && defined(male)
  #undef male
#endif
#if defined(_WIN32) && defined(feamle)
  #undef feamle
#endif

  enum {
    unknown = 0u,
    male = 1u,
    feamle = 2u,
  };


  typedef boost::shared_ptr< ::l_service::PersonRequest_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::l_service::PersonRequest_<ContainerAllocator> const> ConstPtr;

}; // struct PersonRequest_

typedef ::l_service::PersonRequest_<std::allocator<void> > PersonRequest;

typedef boost::shared_ptr< ::l_service::PersonRequest > PersonRequestPtr;
typedef boost::shared_ptr< ::l_service::PersonRequest const> PersonRequestConstPtr;

// constants requiring out of line definition

   

   

   



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::l_service::PersonRequest_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::l_service::PersonRequest_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::l_service::PersonRequest_<ContainerAllocator1> & lhs, const ::l_service::PersonRequest_<ContainerAllocator2> & rhs)
{
  return lhs.name == rhs.name &&
    lhs.age == rhs.age &&
    lhs.sex == rhs.sex;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::l_service::PersonRequest_<ContainerAllocator1> & lhs, const ::l_service::PersonRequest_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace l_service

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsFixedSize< ::l_service::PersonRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::l_service::PersonRequest_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::l_service::PersonRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::l_service::PersonRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::l_service::PersonRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::l_service::PersonRequest_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::l_service::PersonRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "21f83bfd0c41d3848cb08b07978b2e7e";
  }

  static const char* value(const ::l_service::PersonRequest_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x21f83bfd0c41d384ULL;
  static const uint64_t static_value2 = 0x8cb08b07978b2e7eULL;
};

template<class ContainerAllocator>
struct DataType< ::l_service::PersonRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "l_service/PersonRequest";
  }

  static const char* value(const ::l_service::PersonRequest_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::l_service::PersonRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "string name\n"
"uint8 age\n"
"uint8 sex\n"
"# request\n"
"uint8 unknown = 0\n"
"uint8 male = 1\n"
"uint8 feamle = 2\n"
;
  }

  static const char* value(const ::l_service::PersonRequest_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::l_service::PersonRequest_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.name);
      stream.next(m.age);
      stream.next(m.sex);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct PersonRequest_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::l_service::PersonRequest_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::l_service::PersonRequest_<ContainerAllocator>& v)
  {
    s << indent << "name: ";
    Printer<std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other > >::stream(s, indent + "  ", v.name);
    s << indent << "age: ";
    Printer<uint8_t>::stream(s, indent + "  ", v.age);
    s << indent << "sex: ";
    Printer<uint8_t>::stream(s, indent + "  ", v.sex);
  }
};

} // namespace message_operations
} // namespace ros

#endif // L_SERVICE_MESSAGE_PERSONREQUEST_H
