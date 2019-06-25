function [E_control_t] = E_control(t, t_gate, C1_1, K)
  %% Efficiency for the control field
  %Concentration
  C_control = Concentration(t,t_gate,C1_1);
  
  E_control_t = 0.95*C_control/(0.5*0.1234 + C_control);
end