function [root, fx, ea, iter] = falsePosition(func, xl, xu, es, maxit, varargin)
%falsePosition finds the root of a function using false position method

%func = name of function
%xl,xu = lower and upper guesses
%es = desired relative error (default 0.0001%)
%maxit = max allowable iterations (default 50)

if nargin < 3, ('at least 3 input arguments required brah'); 
end
test = func(xl,varargin{:})*func(xu,varargin{:});
if test > 0, error ('no sign change brah'), 
end
if nargin < 4 || isempty(es) 
    es = 0.0001; 
end
if nargin < 5 || isempty(maxit) 
    maxit = 200; 
end

iter = 0; 
xr = xl; 
ea = 100;

while (1)
   xr_old = xr; xr = (xu - (func(xu)*(xl-xu))/(func(xl)-func(xu)));
   iter = iter +1;
   if xr ~= 0, ea = abs((xr-xr_old)/xr)*100; 
   end
   test = func(xl,varargin{:})*func(xr,varargin{:});
   if test < 0
       xu = xr;
   elseif test > 0 
       xl = xr;
   else
       ea = 0;
   end
   if ea <= es || iter >= maxit,break, end
end

root = xr; 
fx = func(xr,varargin{:});

end
