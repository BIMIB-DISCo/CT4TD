function [C_t] = Concentration(t, t_gate, C)
%% Find the correct array indice for a generic time t
Nt     = size(C,1);
t_step = t_gate/Nt;
t_ind  = 1 + floor(t/t_step);
%% Return the correct value
C_t = C(t_ind);
end