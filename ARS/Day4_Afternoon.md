# Realistic Path and motion planning

**Problem formulation**

 Staring and final position

Knowledge about the obtacle

1. The locations
2. The shapes
3. Static or dynamic

Mathematical model of the robot

Initial and final pose of the robot (velocity and heading)

Area map: The geometric representation of the robot’s enviroment in notations suitable for describing locations in the robot’s reference frame.

**Assumption**

Map is known; obstacles position are known, shapes can eb approxminated by regular polygon and they are static.

The robot motion is defined using kinematics model

Initial and desired pose are given.



# Rapidly-Exploring Random Tree (RRT)

## Generation of RRT

Input ($\Large x_{init}, K, \Delta T$)

$\Large \mathcal{T}.\text{init}(x_{init})$

for $\Large k$ = 1 to $\Large K$ do

​	$\Large x_{rand} \leftarrow$ RANDOM_STATE()

​	$\Large X_{near}\leftarrow$ NEAREST_NEIGHBOR($\Large x_{randn}, \mathcal{T}$)

​	$\Large u \leftarrow$ SELECT_INPUT($\Large x_{rand}, x_{near}$)

​	$\Large x_{new}\leftarrow$ NEW_STATE($\Large x_{near}, u, \Delta t$)

​	$\Large \mathcal{T}.\text{add vertex}(x_{new})$

​	$\Large \mathcal{T}.\text{add edge}(x_{near}, x_{new}, u)$

return $\Large \mathcal{T}$



