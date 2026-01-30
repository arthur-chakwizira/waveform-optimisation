function [Qw, w] = qt_to_qw(qt, dt)
%computes encoding power spectrum for one waveform
%also returns the frequency grid

if ~isrow(qt); qt = qt'; end
len = numel(qt)*10;
qw = (fftshift(fft(qt, len)))*dt;

Qw = (abs(qw)).^2;

Nw = numel(qw);
df = 1/(Nw*dt);
if mod(Nw, 2) == 0; offset = 1; else; offset = 0; end
w = 2*pi*df*(-floor(Nw/2):floor(Nw/2)-offset); %omega
end