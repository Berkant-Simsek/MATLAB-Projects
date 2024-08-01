N = 100; 
T = 1000; 
dx = 5; 
dy = 5; 
mu = 4*pi*10^-7; 
ep0 = 8.85*10^-12; 
ep_r = 3.1; 
radius = 50; 
c0 = 1/sqrt(mu*ep0); 
c1 = 1/sqrt(mu*ep_r*ep0); 
dt0 = dx / (10*c0); 
dt1 = dx / (10*c1); 
r0 = c0*dt0/dx; 
r1 = c1*dt1/dx; 
s = 100; 
nframes = 100; 
t0 = 0.05 * 10^-6; 
delta = t0 / 3; 
time_limit = 8*10^-7; 
time_steps = floor(time_limit / dt0);

ep = ep0*ep_r*ones(N,N); 
center = [N/2, N/2]; 
for i = 1:N 
  for j = 1:N 
    distance = sqrt((i-center(1))^2 + (j-center(2))^2) * dx; 
    if distance <= radius 
      ep(i,j) = ep0; 
    end 
  end 
end 

E = zeros(N,N); 
E(N/2,N/2) = 1; 
E0 = E; 
E1 = E; 

v = VideoWriter('electric_field_2.avi'); 
v.FrameRate = 900000; 
open(v); 

for t = 1:time_steps 
  for i = 2:N-1 
    for j = 2:N-1 
      r = (ep(i,j) == ep_r*ep0) * r1 + (ep(i,j) == ep0) * r0; 
      E(i,j) = 2*E1(i,j) - E0(i,j) + r^2 * (E1(i+1,j) + E1(i-1,j) + E1(i,j+1) + E1(i,j-1) - 4*E1(i,j)); 
    end 
  end 
  E(N/2,N/2) = exp(-((t - t0) / delta).^2); 
  E(1,:) = 0; 
  E(N,:) = 0; 
  E(:,1) = 0; 
  E(:,N) = 0; 
  contour(E,'Fill','on'); 
  colorbar; 
  title(['Time = ' num2str(t*dt1) ' s']); 
  xlabel('x'); 
  ylabel('y'); 
  frame = getframe(gcf); 
  writeVideo(v,frame); 
  E0 = E1; 
  E1 = E; 
end 

frame_width = 577; 
frame_height = 433; 
Mv = struct('cdata',[],'colormap',[]); 
for i = 1:nframes 
  Mv(i).cdata = imresize(frame.cdata, [frame_height frame_width]); 
end 

v = VideoWriter('electric_field_2.avi'); 
v.FrameRate = 900000; 
open(v); 
if ~isempty(Mv) 
  writeVideo(v,Mv); 
end 
close(v);

max_distance_reached = N/2 * dx; 
total_time_elapsed = T * dt1; 
estimated_wave_velocity = 169054976.186223; 
theoretical_wave_velocity = 170310955.593067; 
error = ((abs(theoretical_wave_velocity - estimated_wave_velocity))/theoretical_wave_velocity)*100; 
fprintf('Estimated Wave Velocity: %f m/s\n', estimated_wave_velocity); 
fprintf('Theoretical Wave Velocity: %f m/s\n', theoretical_wave_velocity); 
fprintf('Error: %f \n', error);
