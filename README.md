# MATLAB-Projects

## Project 1

### Simulation of EM Wave Propagation

Executive Summary
The main purpose of this simulation project is to numerically solve the time-domain 
electromagnetic wave equation. The EM wave propagation within a defined space of given 
properties is simulated. The finite-difference time-domain (FDTD) method is used to study EM wave 
propagation properties in two dimensions. 

Introduction
The general form of the EM wave equation is given (for the electric field) by,
![image](https://github.com/user-attachments/assets/33b47577-d4a7-49de-a765-5988b5a5a5d3)
A similar equation can be written for the magnetic field. For a charge-free non-conducting space, the 
equation reduces to (in rectangular coordinates), 
![image](https://github.com/user-attachments/assets/f10d9895-783c-44f4-9633-9ac902275e7b)
In general, the electric field is described by a vector of three-components as,
![image](https://github.com/user-attachments/assets/3349e2cb-f296-4c7f-b6ff-6f8fbf4a2682)
Here, a simplified case is considered, where the electric field has only on component (𝐸Z) varying 
only in x and y dimensions. Equation 2 becomes scalar, and is written as, 
![image](https://github.com/user-attachments/assets/e0611c72-d107-497a-87fd-4ce81457021e)
In this project, the Finite-Difference Time-Domain (FDTD) method will be used. The FDTD method is 
one of the most popular numerical methods in the field of computational electromagnetics [1, 2]. Its 
main advantages are (1) easy to formulate, (2) suitable for many structures (3) flexible for 
modifications and (4) robust. 
The FDTD-based simulation is performed in the following steps. 
  - Discretize the given structure (make a grid) using a suitable step size in both dimensions (Δx and Δy). The accuracy of the results improves with smaller step sizes.  
  - Approximate the partial derivatives in equation 4 by the following relations. 
![image](https://github.com/user-attachments/assets/c5c2f2ba-7067-479a-9c1d-4ac0367b7784)
where 𝑖 and 𝑗 are the indices along the x and the y-axis, respectively. The index 𝑛 is for time. 
Substituting equations 5, 6 and 7 in equation 4, and using ∆𝑥2 = ∆𝑦2 = ∆2 , we get 
![image](https://github.com/user-attachments/assets/4cf50767-3984-40fd-9cc0-9eeeb48710f3)
This is called the “update equation”. It represents the time evolution of the wave at any given space 
point. 
  - Implement the initial and boundary conditions and the material properties of the solution 
space.  
  - Execute the time domain algorithm (equation 8) over all points in the specified space 
(excluding the boundaries) from 𝑡 = 0 to any specified time duration (time marching).

Procedure 
- Consider the structure given in figure 1. The 2D space grid is generated covering the whole indicated space. 
![image](https://github.com/user-attachments/assets/4ee83954-869b-4a70-9497-2d90cd5a1fda)
- The boundary conditions are fixed at zero value throughout the simulation time. These 
conditions simulate a perfect mirror, where the EM wave is expected to reflect completely.  
- Implement the simulation algorithm for the inner point of the structure only. Apply a 
source (excitation signal) as an initial condition defined only at the center point. The applied 
signal is defined as a Gaussian pulse of the form, 
![image](https://github.com/user-attachments/assets/88f257f9-e14c-41ab-9daa-77867bfb4da7)
where 𝑡 is a time delay and 𝛿 is a parameter that controls the width of the pulse. 
- Find a suitable time step for the algorithm. A time step larger than a certain limit causes 
the algorithm to be unstable (diverges). As a rule, ∆𝑡 ≤ 0.5∆/𝑐, for 2D problems.  
- Run the algorithm for the required time duration, observe the wave propagation and 
make studies and analyses. 
