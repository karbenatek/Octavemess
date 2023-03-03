f = 0.1:0.01:100;
N = 100;
A = 1;
T = 1;
H1 = 0;
for n = -N:N;
  H1 += exp(-i*2*pi.*f*n*T) - exp(-i*2*pi.*f*(n+0.5)*T);
endfor
H1 .*= -A./(pi*T.*f);
h1 = ifft(real(H1),100000);
subplot(1,2,1);
plot(f,H1,".-");
subplot(1,2,2);
plot(abs(h1),".-");
