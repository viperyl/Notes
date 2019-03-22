import numpy as np
from scipy.integrate import odeint
from math import sin,cos,radians,atan2
import matplotlib.pyplot as plt

def cp(th,t):
    m1 = 0.174
    m2 = 0.174
    l1 = 0.38
    l2 = 0.38
    a1 = 0.30
    a2 = 0.30
    k = 1.45
    w = 0.35
    H = 0.1436
    W = 0.0709
    g = 9.8
    
    Izz1 = (1/12) * m1 * (H**2 + W**2) + m1 * l1**2
    Izz2 = (1/12) * m2 * (H**2 + W**2) + m2 * l2**2
    
    c = w - a1 * sin(th[0]) + a2 * sin(th[2])
    d = 0 + a2 * cos(th[0]) - a2 * cos(th[2])
    
    x = (c**2 + d**2)**0.5
    
    alpha1 = atan2(d,c) + th[0]
    alpha2 = atan2(d,c) + th[2]
    
    ddth1 = (-1/Izz1) * (a1 * k * x * cos(alpha1) + m1 * g * l1 * sin(th[0]))
    ddth2 = (1/Izz2) * (a2 * k * x * cos(alpha2) - m2 * g * l1 * sin(th[2]))
    return [th[1], ddth1, th[3], ddth2]

    
t = np.linspace(0,60,8000)
th0 = [radians(20), 0, radians(20), 0]
ths = odeint(cp, th0, t)
t = t.tolist()
#plt.plot(t,ths[:,0], color='blue',linewidth=2, markersize=12)
#plt.plot(t,ths[:,2], color='red' ,linewidth=2, markersize=12)
plt.plot(ths[:,0],ths[:,2], color='blue' ,linewidth=2, markersize=12)
