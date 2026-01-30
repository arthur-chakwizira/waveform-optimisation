function u0 = initial_guess(opt)
%Find initial guess 
opts = optimoptions('patternsearch', ...
    'Algorithm','classic', ...
    'Display','none', ...
    'MaxFunctionEvaluations',1e6, 'MeshTolerance', 1e-6, 'StepTolerance',1e-6, 'ConstraintTolerance', 1e-6);
fun = @(u) objective(u, opt);
%look for good guess
disp("Looking for good initial guess...")
RSS = inf;
Ntrials = 1;
for trial = 1:Ntrials
    tmp_u0 = opt.lb + (opt.ub-opt.lb).*rand(size(opt.lb));
    [~, tmp_RSS] = patternsearch(fun, tmp_u0, [],[],[],[], opt.lb, opt.ub, [], opts);
    if tmp_RSS < RSS; RSS = tmp_RSS; u0 = tmp_u0; end
    disp("Attempt " + num2str(trial) + " of " + num2str(Ntrials))
end
disp("Done.");

end