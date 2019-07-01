function [FOM] = Th_Main_so(u1, timegrid)
%{
Main program that handles the calculation of figure of merit, given the
pulses.
First order absorption process:
\frac{d\, \ki_{b}(t) }{dt} = - k_{a} \ki_{g}(t)
\ki_{g}(t = 0) = D ; (f = 1)
The solution is 
\ki_{g}(t) = D e^{-k_{a}t}
Multidose administration:
t_{0} \ge t \le t_{1} \ki_{g}(t) = \ki_{g,0}(t)
t_{1} \ge t \le t_{2} \ki_{g}(t) = \ki_{g,1}(t) + \ki_{g,0}(t)
\vdots
t_{n} \ge t \le t_{f} \ki_{g}(t) = \sum_{i=0}^{n}\ki_{g,i}(t)
where \ki_{g,i}(t) = D_{i} e^{-k_{a}(t-t_{i})} 
The dynamic is given by
\frac{d\,A(t)}{dt} = -CL*C(t) + k_{a} \ki_{g}(t)
 A(t=0) = 0

C(t)=A(t)/V
%}
%% Parameters From  "Population PK of Imatinib and the 
%%  role of \alpha_1-acid glycoprotein"  Widmer et al.
% the clearance
Cl = 17.8009;%[L/h]
% Volume of distribution
V  = 377; %[L]
% Initial State
C_min=0.7;%[mg/l]
%elimination cost
ke = Cl/V;%[1/h]
% absorption constant
ka = 0.437;%[1/h]
% bioavailability parameter
f  = 1.0;% From  "Population PK of Imatinib and the  role of \alpha_1-acid glycoprotein"  Widmer et al.
%and "Clinical Pharmacokinetics of Imatinib" Peng et al.
% Parameters for efficiency

C_target = 0.57;%1 [mg\L] From  TOPS study Guilhot et. al (Blood 2008) 1000 [ng/mL]
                   % 0.4936 Form Peng et al.
%% Control function
% ingested dose in [mg] (commercial dose is 100 mg)
D = u1;

%% Timegrid
%t_i    = timegrid;
% last time in the timegrid, i.e. t_{f}. t_{0} = 0.
t_gate = timegrid(end);

%% Definition of dose from the D function:
%THE ONLY PARAMETER TO CHANGE IN THE OPTIMIZATION IS THE NUMBER OF DOSES
% Here the doses will be equally separated given the total time ramp by
% RedCRAB. For instance if the total time ramp in RedCRAB is 120 hours and
% the doses are 6, Matlab will divide the time in 6 equidistanced steps, 
% and for each one calculates the corrispondent dose.

tot_dosi = 10;
% new discretize t_i, for the definition of the Absorption function
t_i = zeros(tot_dosi+1,1);
% initialization all t_i
t_step = (t_gate/tot_dosi);
for i=1:(tot_dosi+1)
  t_i(i) = t_step*(i-1);
end
% loop for the definition of doses
D_i = zeros(tot_dosi,1);
Int_t = @(t) Concentration(t, t_gate, D);
for i=1:tot_dosi
  D_i(i) = integral(Int_t, t_i(i), t_i(i+1), 'ArrayValued',true);
end
%% Plot Doses
x_i = zeros(tot_dosi,1);
for i=1:(tot_dosi)
  x_i(i) = t_step*(i-1);
end
%figure;
%subplot(3,1,1);
%scatter(x_i(:,1), D_i(:,1));
%% Print Doses
fileID = 
%% Absorption function
% Dimension of D_i
Nt = size(D_i,1);
absorption = @(t) 0.0;
% Definition of absorption function using the superposition principle
for i=(1:Nt)
    temp        = @(t) f*D_i(i)*heaviside(t-t_i(i))*exp(-ka*(t-t_i(i)) );
    absorption  = @(t) temp(t) + absorption(t);
end
%% Check absorption function
%subplot(3,1,2);
t_step = 0.5;
Nt = t_gate/t_step;
t_a = zeros(Nt,1);
for i=1:Nt
    t_a(i) = i*t_step;
end
y_a = arrayfun(absorption,t_a);
%plot(t_a(:,1),y_a(:,1));
%% Time propagation using ode45
% Definition of Ordinary differential equation
Ode1 = @(t,Y) -ke * Y + ka * absorption(t);
% Convergency options
options=odeset('RelTol',10^(-6),'AbsTol',10^(-6));
% Solve differential equation through ode45
% T1 is the column vector containing the evaluations points (not used in the code)
% A_p is the array containing the solution evaluated for each values of T1
[T1,A_p] = ode45(Ode1, [0,t_gate],0,options);
C_p = A_p/V;
%% Plot C_p 
%subplot(3,1,3);
%plot(T1(:,1), C_p(:,1));
%% Figure of merit
%{
The figure of merit is given by
Fom = W_{1}\sum_{i=1}^{n} D_{i} + W_{2}\int_{t_{0}}^{t_{f}}|E(C_{target}(t)) - E(C^{*}(t)) |^{2} dt 
where E(C(t)) is the efficiency defined as following:
E(C(t)) = \frac{C(t)}{K + C(t)}
%}
% weight functions
w1 = 0.0000;
w2 = 1.0;
w3 = 0.00; 
% First part of FOM
F1  = sum(D_i);
% Second part of FOM
Int_t = @(t) abs(E_target(t, t_gate, C_target) - E_control(t, t_gate, C_p) ).^2;
F2  = integral(Int_t, 0, t_gate, 'ArrayValued',true);
% Third part of FOM for the toxicity
Int_t2= @(t) Concentration(t, t_gate, C_p);
F3  = integral(Int_t2, 0, t_gate, 'ArrayValued',true);
%% Return to RedCRAB
FOM = w1*F1 + w2*F2 + w3*F3;

end
