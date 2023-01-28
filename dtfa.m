% dtfa.m program for finding the frequency response from
% experimental/simulation results
%com_par should contain Frequency vector(F),Starting
%time for each frequency(Tst), number of cycles for each
%frequency(Nc),and command vector (R)
%load simout OR Matab workspace should contain the simulation time vector
%'t' and simulation output, 'y' 

load com_par; 
Y=out.y;T=out.t;
Ts=T(5)-T(4);
for i=1:length(F)
% Tend(i)=Tst(i)+4/F(i); % for skipping first cycle of each frequency of the sweep
Tend(i)=Tst(i)+Nc(i)/F(i); % for using full cycle integration
Ns(i)=fix(Tst(i)/Ts);
Ne(i)=fix(Tend(i)/Ts);Ne(i)=min(Ne(i),max(length(T))-1); 
A=max(R(Ns(i):Ne(i)));P=0;Q=0;
ph(i)=2*pi*F(i)*Ns(i)*Ts; 
for k=Ns(i):Ne(i)

q(k)=A*cos(2*pi*F(i)*k*Ts-ph(i));
r(k)=A*sin(2*pi*F(i)*k*Ts-ph(i));
P=P+r(k)*Y(k)*Ts/A;
Q=Q+q(k)*Y(k)*Ts/A;end 
P=P/Nc(i);Q=Q/Nc(i); % assuming full cycles for integration
%P=P/4;Q=Q/4; % assuming 4 cycles for integration
gain(i)=10*log10((P^2+Q^2)*(2*F(i)/A)^2); phase(i)=180/pi*atan2(Q,P);
if phase(i)>0,phase(i)=phase(i)-360;end,end 
subplot(2,1,1)
semilogx(F,gain);xlabel('Frequency (Hz)');ylabel('Mag (dB)');
title('Frequency response extracted from data')
grid on 
subplot(2,1,2)
semilogx(F,phase);xlabel('Frequency (Hz)');ylabel('Phase (deg)')
grid on
