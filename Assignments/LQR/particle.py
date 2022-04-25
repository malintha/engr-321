from scipy.integrate import odeint
import numpy as N
import pylab as p 

def f(y, t):
    """this is the rhs of the ODE to integrate, i.e. dy/dt=f(y,t)"""
    z, v = y

    fdot = [v, 9.82]
    return fdot

y0 = [0, 0]             # initial value
a = 0              # integration limits for t
b = 2

t = N.arange(a, b, 0.01)  # values of t for
                          # which we require
                          # the solution y(t)
y= odeint(f, y0, t)  # actual computation of y(t)

print(y[:,1])
# plotting of results
p.plot(t, y[:,0],'b', label='velocity')
p.plot(t, y[:,1],'g', label='position')
p.xlabel('t')

p.show()
