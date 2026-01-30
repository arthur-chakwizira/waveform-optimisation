function penalty = get_penalty(g, b, dt)
 penalty = 0;
if max(abs(diff(g)/dt)) > 200; penalty = 1e9; end
if b < 4e9; penalty = 1e9; end
end