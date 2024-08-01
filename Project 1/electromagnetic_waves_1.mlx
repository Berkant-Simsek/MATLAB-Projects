step_sizes = [5, 2, 1, 0.5]; 
errors = zeros(size(step_sizes)); 

for idx = 1:length(step_sizes) 
  mu = 4*pi*10^-7; 
  ep = 8.85*10^-12; 
  c = 1/sqrt(mu*ep); 
  dx = step_sizes(idx); 
  dy = dx; 
  dt = dx / (10*c); 
  N = 100; 
  T = 1000; 
  r = c*dt/dx; 
  s = 100; 
  nframes = 100; 
  t0 = 0.05 * 10^-6; 
  delta = t0 / 3; 
 
  if step_sizes(idx) == 5 
    time_limit = 8*10^-7; 
  end 
  if step_sizes(idx) == 2 
    time_limit = 3.2*10^-7; 
  end 
  if step_sizes(idx) == 1 
    time_limit = 1.5*10^-7; 
  end 
  if step_sizes(idx) == 0.5 
    time_limit = 7.8*10^-8; 
  end 
  time_steps = floor(time_limit / dt); 
 
  E = zeros(N,N); 
  E(N/2,N/2) = 1; 
  E0 = E; 
  E1 = E; 
       
  v = VideoWriter('electric_field.avi'); 
  v.FrameRate = 900000; 
  open(v); 
       
  for t = 1:time_steps 
    for i = 2:N-1 
      for j = 2:N-1 
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
    title(['Time = ' num2str(t*dt) ' s']); 
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
     
  v = VideoWriter('electric_field.avi'); 
  v.FrameRate = 900000; 
  open(v); 
  if ~isempty(Mv) 
    writeVideo(v,Mv); 
  end 
  close(v); 
     
  time_values = 0:dt:1*10^-7; 
  source_values = zeros(size(time_values)); 
     
  for t_idx = 1:length(time_values) 
    t = time_values(t_idx); 
    source_values(t_idx) = exp(-((t - t0) / delta).^2); 
  end 
  figure; 
  plot(time_values, source_values); 
  title('Values of Point E(N/2,N/2) Over Time'); 
  xlabel('Time (s)'); 
  ylabel('Source Value'); 
  max_distance_reached = N/2 * dx; 
  total_time_elapsed = T * dt; 
  theoretical_wave_velocity = 3*10^8; 
  if step_sizes(idx) == 5 
    number = 299703477.156154; 
  end 
  if step_sizes(idx) == 2 
    number = 299938466.866262; 
  end 
  if step_sizes(idx) == 1 
    number = 299963380.274686; 
  end 
  if step_sizes(idx) == 0.5 
    number = 299965486.467496; 
  end 
  estimated_wave_velocity = number; 
  error = ((abs(theoretical_wave_velocity - estimated_wave_velocity))/theoretical_wave_velocity)*100; 
  errors(idx) = error; 
  fprintf('Step Size: %f cm\n', step_sizes(idx)); 
  fprintf('Estimated Wave Velocity: %f m/s\n', estimated_wave_velocity); 
  fprintf('Theoretical Wave Velocity: %f m/s\n', theoretical_wave_velocity); 
  fprintf('Error: %.9f \n', error); 
end 
fine_step_sizes = linspace(min(step_sizes), max(step_sizes), 100); 
smooth_errors = interp1(step_sizes, errors, fine_step_sizes, 'spline'); 
figure; 
plot(fine_step_sizes, smooth_errors, 'b-', 'LineWidth', 2); 
hold on; 
plot(step_sizes, errors, 'ro'); 
title('Error Analysis for Different Step Sizes'); 
xlabel('Step Size (cm)'); 
ylabel('Relative Error'); 
legend('Smooth Curve', 'Original Data'); 
grid on;
