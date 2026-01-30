function plot_power_spectrum(Qw, w, opt)
ax = opt.ax(opt.plot_idx);
fill(ax, w, Qw, [0.7 0.7 0.7], 'LineWidth', 1, 'EdgeColor', 'r');
ylabel(ax, '|Q(\omega)|2')
xlabel(ax, '\omega [Hz]')
xlim(ax, [-1000 1000])
end