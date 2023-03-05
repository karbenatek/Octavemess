n_pars = 4;
n_points = 16;
p_true = (rand(n_pars, 1) - 0.5).*2; % generate random parameters

%p_true = [-2,-8,4,2]; %set parameters manually
%n_pars = length(p_true);

x_top = 10; % x scale
x = linspace(0, x_top, n_points);
x = rand(1,n_points).*x_top;
x_smooth = linspace(0, x_top, n_points*100);
y = polyval(p_true, x);
y = y + (rand(1, n_points) - 0.5).*(max(y) - min(y))*0.2;
x_valid = rand(1,n_points).*x_top;
y_valid = polyval(p_true, x_valid);
y_valid = y_valid + (rand(1, n_points) - 0.5).*(max(y) - min(y))*0.2;


y_true = polyval(p_true, x_smooth);
clf; figure(1);
subplot(3, 1, 1);

%plot( x_smooth, y_true, 'g-','linewidth',2, x, y, 'r.', 'markersize', 20,x_valid, y_valid, 'b.', 'markersize', 20);
hold on;
plot( x_smooth, y_true, 'k-', 'linewidth',2);

plot(x, y, 'r.', 'markersize', 20);
plot(x_valid, y_valid, 'b.', 'markersize', 20);

plotlimoffset = 0.5.*(max(y_true)- min(y_true));
plotlims = [min(y_true)-plotlimoffset max(y_true)+plotlimoffset];
ylim(plotlims);
hold off;

chi2 = []
chi2_valid = []

subplot(3, 1, 2);
hold on;
plot( x, y, 'r.', 'markersize', 20);
plot( x_valid, y_valid, 'b.', 'markersize', 20);

for i_par = 0:(n_points-2)

  pars = polyfit(x, y, i_par);
  vals = polyval(pars, x);

  chi2 = [chi2 sum((polyval(pars, x) - y).^2)];
  chi2_valid = [chi2_valid sum((polyval(pars, x_valid) - y_valid).^2)];

  if i_par < n_pars-1
    plot(x_smooth, polyval(pars, x_smooth), 'g', 'linewidth',1);
  elseif i_par == n_pars-1
    plot(x_smooth, polyval(pars, x_smooth), 'b', 'linewidth',2);
  elseif i_par == n_points-1
    plot(x_smooth, polyval(pars, x_smooth), 'r-','linewidth',1.5);
  else
    plot(x_smooth, polyval(pars, x_smooth), '--','linewidth',0.2);
  end
  

end
%chi2 = flip(chi2);
%chi2_valid = flip(chi2_valid);

ylim(plotlims);
hold off;
subplot(3, 1, 3);
hold on
plot(chi2,'r')
plot(chi2_valid, 'b')
hold off
ylim([0 max(chi2)])
