function [gam, vom] = gwf_to_gamma_vomega(g,q,b,dt)
%Returns Gamma and Vomega given waveform
    N = numel(g);
    
    t = 0:dt:(N-1)*dt;
    
    if ~isequal(size(t), size(g)); t = t'; end
    
    vom = (1/b)*msf_const_gamma()^2*trapz(t, g.^2);
    
    q4 = (1/b^2)*correlate(q.^2, q.^2, dt);
    gam = 2*trapz(t, t.*q4);
end