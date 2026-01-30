%main function

%build options
opt.dt = 0.01e-3; %temporal resolution
opt.T = 100e-3; %maximum waveform duration
opt.Tpause = 9e-3;
opt.Np = 8; %number of control points
opt.Gmax = 290; %max gradient amplitude
opt.Smax = 200; %max slew rate
opt.ub = [1e3*(opt.T-opt.Tpause)/2; ones(opt.Np,1)*opt.Gmax];
opt.lb = [1; -ones(opt.Np,1)*opt.Gmax]; 
opt.ax = axes;


Gam_coeff = [0 0]; %-1 maximise or 1 minimise or 0 ignore
Gam_target_coeff = [0 0]; %force specific Gamma or not
Gam_target = [0 0];%this is the specific Gamma

Vom_coeff = [1 -1]; %maximise minimise
Vom_target_coeff = [0 0]; %force specific Vomega
Vom_target = [0 0]; %this is the specific Vomega

opt.plot_rows = 2;
opt.plot_cols = 2;

G = zeros(numel(opt.Gam_coeff), numel(0:opt.dt:opt.T));

%run optimiser
for c = 1:numel(Gam_coeff)
 opt.Gam_coeff = Gam_coeff(c);
 opt.Gam_target_coeff = Gam_target_coeff(c);
 opt.Gam_target = Gam_target(c);

 opt.Vom_coeff = Vom_coeff(c);
 opt.Vom_target_coeff = Vom_target_coeff(c);
 opt.Vom_target = Vom_target(c);

 opt.u0 = initial_guess(opt);

u_opt = optimiser(opt);
g_opt = build_waveform(u_opt*1e-3, opt);
G(c,1:numel(g_opt)) = g_opt;
end


%plot results
opt.ax = myfig(opt.plot_rows, opt.plot_cols);
opt.T = (opt.dt)*(numel(g_opt)-1);
grid(opt.ax, 'off')
set(opt.ax, 'fontsize', 12)
for c = 1:numel(Gam_coeff)
tmp_g = G(c, :);

opt.plot_idx = c;

plot_waveform(tmp_g, opt);
tmp_q = msf_const_gamma*cumsum(tmp_g)*opt.dt;
[tmp_Qw, tmp_w] = qt_to_qw(tmp_q, opt.dt);

opt.plot_idx = opt.plot_idx + numel(Gam_coeff);

plot_power_spectrum(tmp_Qw, tmp_w, opt);

tmp_b = sum(tmp_q.^2)*opt.dt;
[gam, vom] = gwf_to_gamma_vomega(tmp_g,tmp_q, tmp_b,opt.dt)
end