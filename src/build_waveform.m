function g = build_waveform(u, opt)

Tpre = u(1);
t_pause = opt.Tpause;

%x contains control points N x, N-1 
x = linspace(0, Tpre, opt.Np+2);
y = [0; u(2:end); 0];

tgrid = (0:opt.dt:opt.T);
g = zeros(size(tgrid));

% Pre-180
idx_pre = tgrid <= Tpre;
tpre = tgrid(idx_pre);
gpre = interp1(x,y, tpre, 'pchip');
g(idx_pre) = gpre;

% Post-180 (time-reversed)
idx_post = (tgrid >= (Tpre + t_pause)) & (tgrid <= (2*Tpre + t_pause));
offset = numel(gpre)-sum(idx_post); 
last_true = find(idx_post, 1, 'last');
if offset > 0; idx_post(last_true+1:last_true+offset) = true; end
if offset < 0; idx_post(last_true:-1:last_true+offset+1) = false; end

g(idx_post) = -flip(gpre);

end