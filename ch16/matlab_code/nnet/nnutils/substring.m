function str=substring(str,first,varargin)


% This is a workaround for a change to the Java interface.  Remove befor R12!

% Copyright 1992-2002 The MathWorks, Inc.
% $Revision: 1.4 $  $Date: 2002/03/25 16:55:09 $


if isempty(varargin)
  str=str(first+1:end);
else
  str=str(first+1:varargin{1}+1);
end
