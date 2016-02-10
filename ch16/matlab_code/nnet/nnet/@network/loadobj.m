function net = loadobj(obj)
%LOADOBJ Load a network object.

% Copyright 1992-2002 The MathWorks, Inc.
% $Revision: 1.4 $ $Date: 2002/03/25 16:53:03 $

if isa(obj,'network')
  net = obj;
else
  net = updatenet(obj);
end
