import numpy as np
import matplotlib.pyplot as plt
from math import sin,cos,atan2,radians
from scipy.integrate import solve_ivp


def pen_1(Z):
    th1 = Z[0]
    th2 = Z[2]
    dth1 = Z[1]
    dth2 = Z[3]
    m1 = 0.174
    m2 = 0.174
    l1 = 0.38
    l2 = 0.38
    a1 = 0.30
    a2 = 0.30
    k = 1.4526
    w = 0.35
    H = 0.1436
    W = 0.0709
    g = 9.8
    Izz1 = (1/12) * m1 * (H**2 + W**2) + m1 * l1**2
    Izz2 = (1/12) * m2 * (H**2 + W**2) + m2 * l2**2
    c = w - a1 * sin(th1) + a2 * sin(th2)
    d = 0 + a1 * cos(th1) - a2 * cos(th2)
    x = (c**2 + d**2)**0.5
    alpha1 = atan2(d,c) + th1
    alpha2 = atan2(d,c) + th2
    ddth1 = (-1/Izz1) * (a1 * k * x * cos(alpha1) + m1 * g * l1 * sin(th1))
    ddth2 = (+1/Izz2) * (a2 * k * x * cos(alpha2) - m2 * g * l2 * sin(th2))
    
    Zd = [dth1,ddth1,dth2,ddth2]
    return Zd



#t = np.linspace(0,20,2001)
#Z0 = [radians(10),0]
#sol = solve_ivp(lambda t,Z: pen(Z),[0, 20],Z0, t_eval = t, rtol = 1e-6)
#
#data = sol.y
#plt. plot(t,data[1,:])

t = np.linspace(0,20,2001)
Z0 = [radians(20),0,radians(20),0]
sol = solve_ivp(lambda t,Z: pen_1(Z),[0, 20],Z0, t_eval = t, rtol = 1e-6)

data = sol.y

#plt.subplot(1,2,1)
#plt.plot(data[0,:],data[2,:])
#plt.subplot(1,2,2)
#plt.plot(t,data[0,:])
#plt.plot(t,data[2,:])


omega1 = data[1,:];
omega2 = data[3,:];

velo1 = omega1 * 0.38;
velo2 = omega2 * 0.38;

# font type
font1 = {'fontname':'Time New Roman'}

# set the figure output parameters

plt.plot(t, velo1, color = 'blue', linewidth = 2.0, linestyle = '-')
plt.plot(t, velo2, color = 'red', linewidth = 2.0, linestyle = '-')

plt.xlabel('Time (sec)',fontsize=18)
plt.ylabel('Acceleration (m/s^2)',fontsize=18)
plt.legend()























