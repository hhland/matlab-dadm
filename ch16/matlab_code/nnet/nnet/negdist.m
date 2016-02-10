function z = negdist(w,p)
%NEGDIST Negative distance weight function.
%
%  Syntax
%
%    Z = negdist(W,P)
%    df = negdist('deriv')
%
%  Description
%
%    NEGDIST is a weight function.  Weight functions apply
%    weights to an input to get weighted inputs.
%
%    NEGDIST(W,P) takes these inputs,
%      W - SxR weight matrix.
%      P - RxQ matrix of Q input (column) vectors.
%    and returns the SxQ matrix of negative vector distances.
%
%    NEGDIST('deriv') returns '' because NEGDIST does not have
%    a derivative function.
%
%  Examples
%
%    Here we define a random weight matrix W and input vector P
%    and calculate the corresponding weighted input Z.
%
%      W = rand(4,3);
%      P = rand(3,1);
%      Z = negdist(W,P)
%
%  Network Use
%
%    You can create a standard network that uses NEGDIST
%    by calling NEWC or NEWSOM.
%
%    To change a network so an input weight uses NEGDIST, set
%    NET.inputWeight{i,j}.weightFcn to 'negdist'.  For a layer weight
%    set NET.inputWeight{i,j}.weightFcn to 'negdist'.
%
%    In either case, call SIM to simulate the network with NEGDIST.
%    See NEWC or NEWSOM for simulation examples.
%
%  Algorithm
%
%    NEGDIST returns the negative Euclidean distance:
%
%      z = -sqrt(sum(w-p)^2)
%
%  See also SIM, DOTPROD, DIST

% Mark Beale, 11-31-97
% Copyright 1992-2002 The MathWorks, Inc.
% $Revision: 1.7 $

% FUNCTION INFO
if isstr(w)
  switch (w)
    case 'deriv',
      z = '';
    otherwise
      error('Unrecognized code.')
  end
  return
end

% CALCULATION
[s,r] = size(w);
[r2,q] = size(p);

if (r ~= r2), error('Matrix sizes do not match.'),end

z = zeros(s,q);

if r == 1
  for i=1:s
    x = w(i,:)'*ones(1,q);
    z(i,:) = -abs(x-p);
  end
else
  for i=1:s
    x = w(i,:)'*ones(1,q);
    z(i,:) = -sum((x-p).^ 2) .^ 0.5;
  end
end
