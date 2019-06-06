%D_func = @(t) piecewise(t<0, -1, t>0, 1);
syms D_func(t);
D_func(t) = piecewise(t<0, -1, t>0, 1);
fplot(D_func);
xvalues = linspace(-1,1,10);
yvalues = D_func(xvalues);
disp(yvalues);