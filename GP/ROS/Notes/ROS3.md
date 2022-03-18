# Parameters server

## rosparam

```
rosparam list
rosparam get param_key
rosparam set param_key param_value
rosparam dump file_name
rosparam load file_name
rosparam delete param_key
```

YAML format: store param_key param_value pairs

## update set params

send a blank request. 

```
rosservice call /clear "{}"
```



## Robot coordinates

TF tree maintain the all of coordinates









# ROS Launch

```xml
<launch>
    <node pkg="turtlesim" name="sim1" type="turtlesim_node"/>
    <node pkg="turtlesim" name="sim2" type="turtlesim_node"/>
</launch>
```

<launch>

launch文件中的根元素采用这个 标签来定义

<node>

启动节点。 pkg表示节点所在的功能包名称，type表示节点的可执行文件名称，name表示节点运行时的名称。

output，respawn，required，ns，args

<param> 和<arg>， 前者表示存在参数服务器中的参数，后者表示launch文件内的局部变量。

```xml
<param name="foo" value="$(arg arg-name)"/>
<node name="node" pkg="package" type="type" args="$(arg arg-name)" />
```





<reamp>

```xml
<remap from="/turtlebot/cmd_vel" to="/cmd_vel">
```

重映射ROS计算图资源的命名



<include>

```xml
<include file="$(dirname)/other.launch"/>
```

包含其他的launch文件，类似CPP中的头文件包含















































