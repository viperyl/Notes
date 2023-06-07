from scipy.integrate import solve_ivp
import numpy as np
import matplotlib.pyplot as plt
from math import sin, cos, radians
import os
os.chdir(r'D:\New folder')

def derv_of_Z (Z,constants):
     L,  m, g, H, W, c = constants
     theta = Z[0]
     d_theta = Z[1]
     
     Izz = 1/12 * m * (H^2 + W^2) + m*L^2
     dd_theta = (L/Izz)*m*g*sin(theta) - (c/Izz)*d_theta
     d_Z = [d_theta,dd_theta]
     return d_Z

# Constant
L = 500e-3      # m
m = 174e-3      # kg
H = 143.6e-3    # m
W = 70.9e-3     # m
c = 0           # dampping factor#
g = 9.8
constants = L,  m, g, H, W, c

#tmax =
#sol = solve_ivp(lambda t,Z: derv_of_Z(Z, constants),[])
data = np.loadtxt('single_pen_data.csv', delimiter = ',', skiprows = 1)

t = data [:,0]
yexp = data[:,2]

plt.plot(t,yexp)
plt.show()




