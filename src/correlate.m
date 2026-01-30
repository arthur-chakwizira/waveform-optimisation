function AB = correlate(A,B,dt)
%calculates and returns discrete correlation between A and B
%assumes A and B are row/column vectors
% tic
if ~isrow(A)||~isrow(B); error("Input has wrong dimensions"); end %&Important! The faster xcorr method below only works if A and B are rows
n = numel(A);

% % 
AB  = xcorr(A,B)*dt; 
AB = AB(1:n);
AB = fliplr(AB);
% % toc
end