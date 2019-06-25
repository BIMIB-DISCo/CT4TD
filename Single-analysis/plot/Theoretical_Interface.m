%% Theoretical interface for Spin_Echo sequence

input = 1;
%% Input file
namefile = 'SI.txt';
if input==1
    fileID = fopen(namefile,'r');
    C = textscan(fileID,'%f %f','EmptyValue',0);
    gridt = C{1,1};
    u1_n    = C{1,2};
end
% Flag for print all relevant functions
flagP = 'Y';
FOM = Main_so(u1_n, gridt, flagP);
disp(FOM);