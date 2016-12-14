function [u] = laplace_noise(X,epsilon)
%function to generate laplace noise
% Here X is the input data table
% u = output laplace noise
sigma = (max(X(1:end,1))-min(X(1:end,1)))/epsilon;
x = rand(10000,1);
j = find(x < 1/2);
k = find(x >= 1/2);
u(j) = (sigma/sqrt(2)).*log(2.*x(j));
u(k) = -(sigma/sqrt(2)).*log(2.*(1-x(k)));
u = reshape(u,10000,1);
u = mean(u);
end

