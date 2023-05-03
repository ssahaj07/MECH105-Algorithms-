function [fX, fY, slope, intercept, Rsquared] = linearRegression(x,y)
%linearRegression Computes the linear regression of a data set
%   Compute the linear regression based on inputs:
%     1. x: x-values for our data set
%     2. y: y-values for our data set

if length(x)~=length(y)
    error('x and y arrays are not same size')
end

% X and Y Values Sorted

[Y, sortOrder] = sort(y);
X = x(sortOrder);

n = length(x);
S = floor((n+1)/4);
T = floor((3*n+3)/4);
Q1 = Y(S);
Q3 = Y(T);

IQR = Q3 - Q1;
threshold = 1.5.*IQR;

onesmatrix = logical(ones(1,n));
for j = 1:n
    if Y(j) < (Q1 - threshold) || Y(j) > (Q3 + threshold);
        onesmatrix(j) = 0;
    end
end

Y = Y(onesmatrix);
X = X(onesmatrix);

% Regression

n_new = length(y);
y_avg = mean(Y);
x_avg = mean(X);
SSx = sum((X-x_avg).^2);
SP = sum((X-x_avg).*(Y-y_avg));
slope = SP/SSx


intercept = y_avg - slope.*x_avg;
line = slope.*X + intercept;

f = @(x) intercept + slope.*x;

fX = X;
fY = Y;

% Rsquared
S_t = sum((fY-y_avg).^2);
S_r = sum((fY-line).^2);
Rsquared = 1 - (S_r/S_t)

end