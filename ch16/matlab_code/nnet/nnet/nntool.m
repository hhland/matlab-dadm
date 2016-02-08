function nntool
%NNTOOL Neural Network Toolbox graphical user interface.
%
%  Syntax
%
%    nntool
%
%  Description
%
%    NNTOOL opens the Network/Data Manager window which allows
%    you to import, create, use, and export neural networks
%    and data.

% Copyright 1992-2002 The MathWorks, Inc.
% $Revision: 1.13 $  $Date: 2002/03/25 16:52:33 $

% make sure we are on a platform that has the desktop
jc=javachk('mwt','NNTOOL');
if ~isempty(jc)
    disp(jc)
    return
end

% NNTGUI access port
nntgui = com.mathworks.toolbox.nnet.NNTGUI('dummy');

% Open manager
launchNNManager(nntgui);
