This MATLAB code represents a simulation of the electric field distribution over time using 
the Finite Difference Time Domain (FDTD) method. The purpose of writing such a code in MATLAB is 
to leverage its powerful matrix operations and visualization capabilities, which are ideal for 
computational electromagnetics. MATLAB’s intuitive programming environment and built-in 
functions allow for efficient manipulation of large data sets and matrices, which is essential for 
simulating electromagnetic wave propagation. 

The code sets up initial parameters for the grid size, time steps, and material properties like 
magnetic permeability and electrical permittivity. It then calculates the electric field at each point on 
the grid over time, applying the FDTD algorithm to model how the field evolves. The inclusion of a 
Gaussian source introduces an electromagnetic wave into the system, and the simulation tracks how 
this wave propagates through the grid. 

By using MATLAB, one can easily visualize the results through plots and animations, making it 
a valuable tool for understanding complex physical phenomena and for educational purposes. The 
ability to create a video of the electric field’s evolution over time is particularly useful for 
presentations or further analysis. 

Overall, MATLAB provides a comprehensive platform for modeling and visualizing 
electromagnetic fields, which is why it is a popular choice among engineers and researchers in the 
field of electromagnetics. 

second code Permittivity Has Been Changed 2.5 Inside of 50 cm Radius Circle

Third Part: (Permittivity Has Been Changed 3.1 Outside of 50 cm Radius Circle) 

The MATLAB code is a comprehensive tool for simulating the propagation of an electric field 
using the Finite Difference Time Domain (FDTD) method. The simulation dynamically updates the 
electric field at each point in a two-dimensional grid by considering the influence of neighboring 
points, adhering to the FDTD algorithm. A Gaussian pulse serves as the source term, which is updated 
at every time step to simulate its propagation through the medium. To mimic an open space, 
boundary conditions are set to zero at the grid’s edges. 

As the simulation progresses, it captures the evolution of the electric field in a video file 
named ‘electric_field.avi’, providing a visual representation of the wave’s behavior over time. 
Additionally, the code plots the source value over time at the grid’s center, depicting the changes in 
the Gaussian pulse. 

An essential aspect of the simulation is the calculation of the estimated wave velocity for 
different grid step sizes and its comparison with the theoretical speed of light. This comparison yields 
the relative error, which is then plotted to analyze the impact of grid resolution on simulation 
accuracy. The errors associated with each step size are plotted, and a spline interpolation is used to 
create a smooth curve that reveals the trend of errors relative to the step sizes. The resulting plot 
features the original data points marked as red circles and the interpolated error curve in blue, 
offering a clear visual analysis. 

The results from this simulation are particularly insightful, as they demonstrate how the 
choice of discretization step size influences the accuracy of the estimated wave velocity. Smaller step 
sizes typically result in reduced errors, providing a more precise resolution of the simulation grid. The 
error analysis plot is instrumental in identifying the optimal step size that offers a balance between 
computational efficiency and the accuracy of the simulation’s results. This balance is crucial for 
practical applications and further research in the field of electromagnetic wave propagation. 

![image](https://github.com/user-attachments/assets/4e16873b-5769-4f79-a73e-f794d46daeb3)

The sinusoidal source will produce a continuous wave that propagates through the 
simulation domain. This can be useful for studying steady-state conditions and wave interactions. 

The cosine-Gaussian pulse will create a localized wave packet with a specific frequency 
content. This is useful for studying the transient response and dispersion effects in the medium. 

By comparing the results from these different sources, you can gain insights into how the 
medium responds to various frequency contents and how the wave propagates over time. 

## Modified Figure (Permittivity Has Been Changed 2.5 Inside of 50 cm Radius Circle) 
### Key Aspects of the Simulation: 
- Grid Setup: A grid of size N x N is established, with each cell representing a physical space 
of dx by dy centimeters. 

- Medium Properties: The permittivity of free space (𝜀_0) is modified within a circular region 
of radius 50 grid cells to represent a medium with a relative permittivity (𝜀_r) of 2.5. 

- Wave Propagation: The electric field is updated at each time step using the FDTD algorithm, 
which accounts for the varying permittivity across the grid. This results in different wave 
speeds within the circular region compared to the rest of the grid. 

- Source Term: A Gaussian pulse is introduced at the center of the grid and updated at each 
time step to simulate the source of the electromagnetic wave. 

- Boundary Conditions: The electric field is set to zero at the boundaries of the grid to 
simulate an open space environment. 

- Visualization: The evolution of the electric field is captured in a video file 
(electric_field_2.avi), and the source term’s variation over time is plotted for 
analysis. 

### Observations from the Simulation: 
- Wave Speed Variation: As the wave propagates through the medium, it encounters the 
circular region with altered permittivity. This change in permittivity results in a change in 
wave speed, as indicated by the estimated wave velocity being different from the theoretical 
value in free space. 

- Impact on Wave Behavior: The transition of the wave into the region with higher 
permittivity would typically result in a slower wave speed, which could lead to refraction 
effects at the boundary and potential changes in the wave’s direction and shape. 

- Error Analysis: The error calculated in the code represents the discrepancy between the 
estimated wave velocity within the medium and the theoretical wave velocity in free space. 
This error quantifies the impact of the medium’s permittivity on the wave’s propagation 
speed. 

The simulation provides valuable insights into how electromagnetic waves interact with 
media of varying permittivity, which is crucial for understanding wave behavior in different materials 
and for designing devices that rely on wave propagation, such as antennas and sensors. The ability to 
visualize these interactions and quantify changes in wave speed is essential for advancing the field of 
electromagnetics. 

![image](https://github.com/user-attachments/assets/41588fbf-445b-455d-a303-769dbca41555)

## Modified Figure (Permittivity Has Been Changed 3.1 Outside of 50 cm Radius Circle) 
### Observations and Interpretation: 
- Wave Speed Contrast: In this simulation, the wave originates from the center, where the 
permittivity is that of free space, and as it travels outward, it encounters a medium with higher 
permittivity. This transition would typically result in a decrease in wave speed upon entering the 
higher permittivity region due to the wave’s longer interaction time with the medium’s 
molecules, which effectively slows down its propagation. 

- Wavefront Distortion: The change in wave speed at the boundary between the two regions can 
lead to distortion of the wavefront. This could manifest as a bending of the wavefronts, known as 
refraction, which changes the wave’s direction of travel. 

- Implications for Error Analysis: The error calculated in the code reflects the difference between 
the estimated wave velocity in the medium with higher permittivity and the theoretical wave 
velocity in free space. A smaller error suggests that the simulation’s estimated wave velocity is 
close to what is theoretically expected, indicating a well-modeled system. 

- Potential Applications: Understanding how waves interact with regions of varying permittivity is 
crucial in designing materials and devices for electromagnetic wave manipulation, such as lenses 
for focusing waves or cloaking devices that guide waves around an object. 

This simulation provides a unique perspective on wave behavior, demonstrating the effects of a 
medium with non-uniform permittivity on wave propagation. Such simulations are valuable for 
predicting wave behavior in complex environments and for developing new technologies in wave
based applications.

![image](https://github.com/user-attachments/assets/661d6403-d5ec-4c73-988f-e0dc3e24b215)
