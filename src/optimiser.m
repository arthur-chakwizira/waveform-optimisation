
function u_opt = optimiser(opt)

opts = optimoptions('patternsearch', ...
    'Algorithm','classic', ...
    'Display','iter', ...
    'MaxFunctionEvaluations',1e6, 'MeshTolerance', 1e-12, 'StepTolerance',1e-12, 'ConstraintTolerance', 1e-12, 'MaxIterations', 1e4);

fun = @(u) objective(u, opt);

[u_opt, ~] = patternsearch(fun, opt.u0, ...
    [],[],[],[], opt.lb, opt.ub, [], opts);

% [u_opt] = simulannealbnd(fun,opt.u0,opt.lb,opt.ub);

end





