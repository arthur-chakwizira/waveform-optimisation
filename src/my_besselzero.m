function kernels = my_besselzero(n)
%computes kernels of J'_1(mu) = 0
%the prime means derivative

num_m = n; %number of roots
mu = 1:0.01:n*5; %define kernel domain
nu = 1; %order of Bessel functions
J = besselj(nu, mu); %evaluate Bessel function
J = my_diff(J, mu); %take derivative

kernels = zeros(1,num_m);
c_k = 0;
for i = 1:numel(J)-1
    if c_k == n; break; end
    if sign(J(i)) ~= sign(J(i+1))
        if sign(J(i+1)) == 0
        elseif sign(J(i)) == 0
            c_k = c_k+1;
            kernels(c_k) = mu(i);
        else
            c_k = c_k+1;
            kernels(c_k) = mean([mu(i), mu(i+1)]);
        end
    end
end

end
