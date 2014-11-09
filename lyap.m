function X = lyap(A, B, C, E)
%LYAP  Solve continuous-time Lyapunov equations.
%
%   LYAP() aims to mirror the functionality of the LYAP() fnuction in the MATLAB
%   Control Toolbox. It is written entirely in MATLAB and so is a little slower
%   than the implementation in the Control Toobox (which is essentially a
%   wrapper to LAPACK). However it is a little more flexible. For solving
%   completely generalised Lyaponov equations, see bartelsStewart.m.
%
%   X = LYAP(A,Q) solves the Lyapunov matrix equation:
%
%       A*X + X*A' + Q = 0
%
%   X = LYAP(A,B,C) solves the Sylvester equation:
%
%       A*X + X*B + C = 0
%
%   X = LYAP(A,Q,[],E) solves the generalized Lyapunov equation:
%
%       A*X*E' + E*X*A' + Q = 0.
%
%   Note that unlike the built-in MATLAB LYAP() routine there is no need for Q
%   to be symmetric in the final case.
%
% See also BARTELSSTEWART.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Developer note:
%   This is essentially a wrapper for bartelsStewart(). No attempt is made to
%   exploit the fact that these are not fully general Lyaponov equations.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ( nargin == 2 )
    % A*X + X*A' + B = 0
    IA = eye(size(A));
    X = bartelsStewart(A, IA, IA, conj(A), -B, false, false);
    
elseif ( nargin == 3 )
    % A*X + X*B + C = 0
    IA = eye(size(A));
    IB = eye(size(B));
    X = bartelsStewart(A, IA, IB.', B.', -C, false, false);
    
else
    % A*X*E' + E*X*A' + B = 0.
    X = bartelsStewart(A, E, E, A, -B, false, false);
    
end 

end