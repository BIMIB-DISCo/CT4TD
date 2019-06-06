function [Abs] = Absorption(t, t_gate, Nt, D)
t_frac = t/t_gate;
t_ind  = 1 + floor(t_frac*(Nt-1));

Abs = @(t) 
Abs_t = Abs(t);
end