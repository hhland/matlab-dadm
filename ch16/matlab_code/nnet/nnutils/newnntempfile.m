function [filename,name]=newnntempfile;
%NEWNNTEMPFILE Get new NNT temporary filename.

%   $Revision: 1.2 $  $Date: 2002/03/25 16:55:11 $
% Copyright 1992-2002 The MathWorks, Inc.
  
[p,name] = fileparts(tempname);
filename=fullfile(p,'matlab_nnet',[name '.m']);