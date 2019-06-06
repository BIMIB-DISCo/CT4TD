function [E_c_target_t] = E_target(t, t_gate, C_target)
  %% Function that returns the Target efficiency
  % E_target is time independent
  ec50 = 0.0;
  E_c_target = @(x) (C_target)/(ec50+C_target) + 0.0*x;
  E_c_target_t = E_c_target(t);
end