
function J = objective(u, opt)

Gam_coeff = opt.Gam_coeff;
Gam_target_coeff = opt.Gam_target_coeff;
Gam_target = opt.Gam_target;

Vom_coeff = opt.Vom_coeff;
Vom_target_coeff = opt.Vom_target_coeff;
Vom_target = opt.Vom_target;

%convert to SI
u = u*1e-3;

g = build_waveform(u, opt);

q  = msf_const_gamma*cumsum(g)*opt.dt;
b = sum(q.^2)*opt.dt + eps;

penalty = get_penalty(g, b, opt.dt);

% Vw = (1/(b+eps))*(msf_const_gamma^2)*sum(g.^2)*opt.dt; 

[Gam, Vom] = gwf_to_gamma_vomega(g,q,b,opt.dt);

% [Qw, w] = qt_to_qw(q, dt);
% Dw = compute_Dw(w, 50e-6, 2e-9, 200);
% phi2 = (1/(2*pi*b))*sum(Qw.*Dw)*(w(2)-w(1));

J = Gam*Gam_coeff + Gam_target_coeff*1e6*(Gam-Gam_target)^2 +...
    Vom*Vom_coeff + Vom_target_coeff*(Vom-Vom_target)^2 ...
    + penalty;%;
end