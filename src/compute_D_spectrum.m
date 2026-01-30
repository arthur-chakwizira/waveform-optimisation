function Dw = compute_D_spectrum(w, d, D0, num_k)
if nargin < 4
    num_k = 200;
end
R = d/2;

mu_k = my_besselzero(num_k);
Bk = 2*(R./mu_k).^2./(mu_k.^2 -1);
ak = (mu_k/R).^2;

Dw = zeros(size(w));
for c_w = 1:numel(w)
    ws = w(c_w);
    Dw(c_w) = sum(Bk.*ak.*D0*ws^2./(ak.^2*D0^2+ws^2), 'all');
%        Dw(c_w) = sum(Bk.*ak.*D_1*ws^2./(ak.^2*D_1^2+ws^2) - 1j*Bk.*ak.^2.*D_1^2*ws./(ak.^2*D_1^2+ws^2), 'all');
end

end