%% Theoretical interface for Spin_Echo sequence

input = 1;
%% Input file
if input==1
    fileID = fopen('SI=1_Feval_no=1_FOM=10.926666823.txt');
    C = textscan(fileID,'%f %f','EmptyValue',0);
    gridt = C{1,1};
    u1_n    = C{1,2};
end
Fom = Main_so(u1_n,gridt);
disp(Fom);