fun_resonance = @(E, m, IW ) 1./(E.^2 .* ((E - m).^2 + IW.^2./4 ));  
m = 135;
IW = 20;
E = linspace(1e-3,200,1000);
CS = fun_resonance(E, m, IW);
plot(E, CS);

xlabel("E [MeV]");
ylabel ("Cross section [a.u.]");
ylim([0 0.000001]);
title(["Resonance of " num2str(m) " MeV particle with " num2str(IW) " MeV interaction width" ]);
