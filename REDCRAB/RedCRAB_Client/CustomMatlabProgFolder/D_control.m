function [D_control_t] = D_control(t, t_gate, C1_1, C_t)
  %% Efficiency for the control field
  %Concentration
  C_control = Concentration(t,t_gate,C1_1);
  
  if C_control <= C_t
      D_control_t = 10.0;
  else
      D_control_t = abs(C_control - C_t);
  end
end