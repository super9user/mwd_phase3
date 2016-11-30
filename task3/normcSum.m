function y = normcSum(x)
if nargin < 1,error(message('nnet:Args:NotEnough')); end
wasMatrix = ~iscell(x);
x = nntype.data('format',x,'Data');

y = cell(size(x));
for i=1:numel(x)
  xi = x{i};
  rows = size(xi,1);
  n = 1 ./ (sum(xi));
  yi = xi .* n(ones(1,rows),:);
  yi(~isfinite(yi)) = 1;
  y{i} = yi;
end

if wasMatrix, y = y{1}; 
end