function [ FOM, Std ] = objectivefunwrap(pulses, timegrid)
%   objectivefun Evaluates the objective function to be extremized
%   Often, the dynamical system is integrated and an objective such as
%   state overlap and/ or fluence or some expectation value of an observable is calculated as
%   figure of merit (FOM) \pm Std. If not standard deviation (std) information is available, still
%   return the second argument 'Std' - just as 0.0

u1 = pulses(1,:);

x = size(u1);
%disp(x);
n_bin_pulses = x(2);
%disp(n_bin_pulses);
u1_n = zeros(n_bin_pulses,1);
for ii=(1:n_bin_pulses)
    u1_n(ii) = u1(1,ii);
end

Std = 0.0;

FOM = Main_so(u1_n, timegrid);


end

