import numpy as np
from numpy import zeros,eye,kron
import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import odeint  # for comparison
from numpy import kron,identity
from scipy.sparse import bmat

N = 2
k = 3

A0 = np.array([[0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],[-1, 0.5, 0, 0, 0, 0, 0.5, -0.5, 0, 0, 0, 0, 0, 0]])
A_list = [[]]
l = 0
# Find the first row of A
# ~ O(N^k-1) 
for i in range(k): 
  A_list[0].append((A0.T[l:l+N**(i+1)]).T)
  l += (N**i+1)
# Find the remainding row of A

for i in range(1,k):
  # zero matrices
  A_list.append([])
  for f in range(k):
    # Filled with 0 
    if f < i:
      A_list[-1].append(zeros((N**(i+1),N**(f+1))))
    else:
      # print((N**(i+1))/len(A_list[0][f-i]))
      A_list[-1].append(kron(A_list[0][f-i],eye(int((N**(i+1))/len(A_list[0][f-i])))) + kron(eye(int((N**(i+1))/len(A_list[i-1][f-1]))),A_list[i-1][f-1]))
for i in range(len(A_list)):
  A_list[i] = np.hstack(A_list[i])
A_list = np.vstack(A_list)

def implicit_euler_carleman():
    # Parameters
    dt = 0.0001  # Time step
    t0 = 0     # Initial time
    tf = 20    # Final time
    t_points = np.arange(t0, tf + dt, dt)
    
    # Initial condition
    u0 = np.array([0.1, 0, 0.01, 0, 0, 0, 0.001, 0, 0, 0, 0, 0, 0, 0])

    
    # Identity matrix
    I = np.eye(A_list.shape[0])
    
    # Preallocate solution array
    u = np.zeros((len(u0), len(t_points)))
    u[:, 0] = u0
    
    # Implicit Euler method
    for n in range(len(t_points) - 1):
        u[:, n + 1] = np.linalg.solve(I - dt * A_list, u[:, n])
    
    # Plot the results
    plt.figure()
    # plt.plot(t_points, u[0, :], 'r', label='u1')
    plt.plot(u[0, :], u[1, :], 'b')
    plt.xlabel('x0')
    plt.ylabel('x1')
    plt.title('Vanderpol Oscilator Carleman Linearization \n d/dt[x1,x2] = [x2, -x1 + mu(1-x1^2)x2] \n mu = 0.5, x1 = 0.1 and x2 =0')
    plt.grid(True)
    plt.show()

# Run the function
implicit_euler_carleman()
