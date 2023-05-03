function I = Simpson(x,y)
% Numerically evaluates the integral of the vector of function values y
% with respect to x using Simpson's 1/3 rule, with trapezoidal rule for the
% last interval if there are an odd number of intervals.
% Inputs:
%   x: vector of equally spaced independent variable values
%   y: vector of function values corresponding to x
% Outputs:
%   I: numerical value of the integral

% Error check: same length of inputs
if length(x) ~= length(y)
    error('make x and y the same length')
end

% Error check: equally spaced x
dx = diff(x);
if any(abs(dx-dx(1)) > 1e-8)
    error('x should be spaced equally ')
end

n = length(x) - 1; % number of intervals
h = dx(1); % interval width

if mod(n, 2) == 0 % even number of intervals
    % Simpson's 1/3 rule
    I = (h/3) * (y(1) + 4*sum(y(2:2:end)) + 2*sum(y(3:2:end-2)) + y(end));
else % odd number of intervals
    % Trapezoidal rule for the last interval
    warning('Trap rule used on last interval');
    I = (h/2) .* (y(1) + 2.*sum(y(2:end-1)) + y(end));
end

end

