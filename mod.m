%sweep_mod.m
% modified by Ameya for adjusting mismatch during zero crossings clc;
clear all; Ts=0.001; tc(1)=0; I=1;
freq1=[0.1:0.1:0.9]; freq2=[1:1:9]; freq3=[10:5:100];
freq=[freq1 freq2 freq3]; 
A=4*398*pi/180;
tlast=0;
for j=1:length(freq)
    tp=1/freq(j); 
    Nj=tp/Ts;
if freq(j)<1,Nc(j)=1;
elseif freq(j)<10
Nc(j)=3;
else
    Nc(j)=5;
 
end
Ist(j)=I;
for i=I:fix(Nc(j)*Nj)+I
% Tst(j)=(I-1+fix((Nc(j)-4)*Nj))*Ts; %For skipping first cycle
Tst(j)=Ist(j)*Ts; % For integrating full cycle
F(j)=freq(j);
rc(i)=A*sin(2*pi*freq(j)*(tc(i)-tlast)); 
tc(i+1)=tc(i)+Ts;
end
tlast=tc(i);
I=i;
end
R=rc(1:i);
T=tc(1:i);
plot(T,R);
grid on;
save com_par F Tst Nc T R
