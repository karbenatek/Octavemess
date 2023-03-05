#octave
n_pars = 3;
n_points = 20;
p_true = (rand(n_pars, 1) - 0.5).*2;
#p_true = [10, 2, 0];
x = linspace(0, 1, n_points);
x_smooth = linspace(0, 1, n_points*100);
y = polyval(p_true, x);
y_valid = y + (rand(1, n_points) - 0.5).*(max(y) - min(y))*0.2;
y = y + (rand(1, n_points) - 0.5).*(max(y) - min(y))*0.2;

y_true = polyval(p_true, x_smooth);
clf; figure(1, 'position', [0,0,1000,1200]);
subplot(3, 1, 1);

plot( x_smooth, y_true, 'g-','linewidth',2,
      x, y, 'r.', 'markersize', 20,
      x, y_valid, 'b.', 'markersize', 20
      );
ylim([min(y_true) - 0.2 max(y_true) + 0.2]);
subplot(3, 1, 2);
hold on;
chi2 = 0
chi2_valid = 0
for i_par = flip(0:(n_points-1))

  pars = polyfit(x, y, i_par);
  vals = polyval(pars, x);
  chi2 = [chi2 sum((vals - y).^2)];
  chi2_valid = [chi2_valid sum((vals - y_valid).^2)];
  if i_par <= n_pars-1
    plot(x_smooth, polyval(pars, x_smooth), 'b', 'linewidth',1.5);
  else if i_par == n_points-1
    plot(x_smooth, polyval(pars, x_smooth), 'r-','linewidth',2);
  else
    plot(x_smooth, polyval(pars, x_smooth), '--','linewidth',0.2);
  endif
  endif
endfor
chi2 = flip(chi2);
chi2_valid = flip(chi2_valid);
plot( x, y, 'r.', 'markersize', 20,
      x, y_valid, 'b.', 'markersize', 20
      );
ylim([min(y_true) - 0.2 max(y_true) + 0.2]);
hold off;
subplot(3, 1, 3);
hold on
plot(chi2,'g')
plot(chi2_valid, 'r')
hold off

