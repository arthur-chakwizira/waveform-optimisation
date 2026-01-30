function plot_waveform(g, opt)
tgrid  = 0:opt.dt:opt.T;
ax = opt.ax(opt.plot_idx);
fill(ax, tgrid*1e3, g*1e3, [0.7 0.7 0.7], 'LineWidth', 1, 'EdgeColor', 'k');
ylabel(ax, 'Gradient [mT/m]')
xlabel(ax, 'Time [ms]')
end