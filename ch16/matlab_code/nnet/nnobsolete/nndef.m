function y=nndef(x,d)
%NNDEF Replace missing and NaN values with defaults.
%  
%  This function is obselete.

nntobsf('trainwb','Use TRAINB to train your network.')


% NNDEF(X,D)
%   X - Row vector of proposed values.
%   D - Row vector of default values.
% Returns X with all non-finite and missing values with
%   the corresponding values in D.
%
% EXAMPLE: x = [1 2 NaN 4 5];
%          d = [10 20 30 40 50 60];
%          y = nndef(x,d)

% Mark Beale, 12-15-93
% Copyright 1992-2002 The MathWorks, Inc.
% $Revision: 1.14 $  $Date: 2002/03/25 16:54:01 $

y = d;
% i = find(finite(x(1:min(length(x),length(y)))));
% %%%%%%%%%%%%%%%%%%%%% use the fllowing line to replace -- fansy
% 2014/12/29
i = find(isfinite(x(1:min(length(x),length(y)))));
y(i) = x(i);
