function [E_c_target_t] = E_target(t, t_gate, C_target, K)
  %% Function that returns the Target efficiency
  % E_target is time independent
  E_c_target = @(x) C_target/(K + C_target) + 0.0*x;
  E_c_target_t = E_c_target(t);
end