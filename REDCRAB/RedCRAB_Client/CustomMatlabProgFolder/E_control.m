function [E_control_t] = E_control(t, t_gate, C1_1)
  %% Efficiency for the control field
  %Concentration
  ec50 = 0.00;
  C_control = Concentration(t,t_gate,C1_1);
  
  E_control_t = C_control/(ec50 + C_control);
end