import numpy as np
from scipy.integrate import odeint 
from math import sin, cos, atan2, radians
import matplotlib.pyplot as plt
m1 = 0.2 # kg
m2 = 0.3 # kg
a1 = 0.02 # m
a2 = 0.04 # m
l1 = 0.1 # m
l2 = 0.13 # m
w = 0.6 # m 
H  = 0.1436 # m
W = 0.0709 # m
k = 1.45 # kg/m
m = 0.138 # kg
c = 2 * (k * m)**0.5
g = 9.8 # m/s2



#constants = l1, l2, m1, m2, a1, a2, g, H, W, c, w


def func(Z, t):
# l1, l2, m1, m2, a1, a2, g, H, W, c, w = consts
    th1 = Z[0]
    th2 = Z[1]
    
    C = w - a1 * sin(th1) + a2 * sin(th2)
    D = a1 * cos(th1) + a2 * cos(th2)
    
    alpha1 = atan2(D,C) + th1
    alpha2 = atan2(D,C) + th2
    
    x = (C**2  + D**2)**0.5
    
    Izz_1 = 1/12 * m1 * (H**2 + W**2) + m1 * l1**2
    Izz_2 = 1/12 * m2 * (H**2 + W**2) + m2 * l2**2
    
    dth1dt = -(1/Izz_1) * (a1 * k * x * cos(alpha1) + m1 * g * l1 * sin(th1))
    dth2dt = (1/Izz_2) * (a2 * k * x * cos(alpha2) - m2 * g * l2 * sin(th2))
   
    return [dth1dt, dth2dt]

X0 = [radians(20), radians(20)]
t = np.linspace(0,40, 8001)

sol = odeint (func,X0,t)

x = sol[:,0]
y = sol[:,1]

th_1 = np.zeros((1,8001))
th_2 = np.zeros((1,8001))
th_1[0][0] = radians(20)
th_2[0][0] = radians(20)
for i in range(1,8001):
    th_1[0][i] = th_1[0][i-1] + x[i-1]
    th_2[0][i] = th_2[0][i-1] + y[i-1]
    
plt.plot(th_2,th_1)







