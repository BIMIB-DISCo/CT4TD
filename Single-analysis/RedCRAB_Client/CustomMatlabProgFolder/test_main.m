%% Just a Test
% Define D function
%% Absorption function
% Dimension of D
%D_func = @(t) piecewise(t<0, -1, t>0, 1);
% Definition of absorption function using the superposition principle
%for i=(1:Nt)
%    temp        = @(t) f*D_i(i)*heaviside(t-t_i(i))*exp(-ka*(t-t_i(i)) );
%    absorption  = @(t) temp(t) + absorption(t);
%end
% Get an array from the D function
%Nt = size(D,2);
%D        = [1;0;1;1;0;1];
D        = [0;0;0;0;0;0];
% Create a timegrid associated 
timegrid = [24;48;72;96;120;144];
Fom = Main_so(D,timegrid);
disp(Fom);