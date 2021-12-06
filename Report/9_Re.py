import numpy as np
from scipy import integrate
from math import radians
import matplotlib.pyplot as plt
import sympy
import os 
os.chdir(r'I:\Xu\5008')

def f(t,y,args):
    w

t, g, m1, l1, m2, l2, a1, a2, w, k,H,W= sympy.symbols("t, g, m_1, l_1, m_2, l_2, a_1, a_2, w, k,H,W")
th1,th2 = sympy.symbols('theta1,theta2', cls = sympy.Function)

Izz1 = sympy.Eq((1/12)*m1*(H**2 + W**2)+m1*l1**2) 
Izz2 = sympy.Eq((1/12)*m2*(H**2 + W**2)+m2*l1**2)

c = sympy.Eq(w-a1*sympy.sin(th1(t)) + a2*sympy.sin(th2(t)))
d = sympy.Eq(a1 * sympy.cos(th1(t)) - a2*sympy.cos(th2(t)))

x = sympy.Eq(c**2 + d**2)

#alpha1 = sympy.Eq(sympy.atan2(d,c)+th1(t))
#alpha2 = sympy.Eq(sympy.atan2(d,c)+th2(t))

ode1 = sympy.Eq(th1(t).diff(t,t) + (1/Izz1)*(a1*k*x*sympy.cos(sympy.atan2(d,c)+th1(t))+m1*g*l1*sympy.sin(th1(t))))
ode2 = sympy.Eq(th2(t).diff(t,t) - (1/Izz2)*(a2*k*x*sympy.cos(sympy.atan2(d,c)+th2(t))-m2*g*l2*sympy.sin(th2(t))))


y1, y2, y3, y4 = sympy.symbols('y_1,y_2, y_3, y_4', cls = sympy.Function)
varchange ={th1(t).diff(t,t):y2(t).diff(t),
            th1(t):y1(t),
            th2(t).diff(t,t):y4(t).diff(t),
            th2(t):y3(t)}

ode1_vc = ode1.subs(varchange)
ode2_vc = ode2.subs(varchange)

ode3 = y1(t).diff(t) - y2(t)
ode4 = y3(t).diff(t) - y4(t)

y = sympy.Matrix([y1(t), y2(t), y3(t), y4(t)])
vcsol = sympy.solve((ode1_vc, ode2_vc, ode3, ode4),y.diff(t),dict = True)
f = y.diff(t).subs(vcsol[0])

params = {m1:0.176,l1:0.38,m2:0.176,l2:0.38,g:9.8,W:0.0709,H:0.1436,w:0.35,a1:0.03,a2:0.03,k:1.45}
f_np = sympy.lambdify((t,y),f.subs(params),'numpy')

jac = sympy.Matrix([[fj.diff(yi) for yi in y] for fj in f])
jac_np =sympy.lambdify((t,y),jac.subs(params),'numpy')

y0 = [radians(20),0,radians(20),0]
t = np.linspace(0,20,20000)
r = integrate.ode(f_np, jac_np).set_initial_value(y0,t[0])
dt = t[1] - t[0]
y = np.zeros(len(t),len(y0))
idx = 0
while r.successful() and r.t < t[-1]:
    y[idx,:] = r.y
    r.integrate(r.t+dt)
    idx += 1
    
theta1_np, theta2_np = y[:,0], y[:,2]






