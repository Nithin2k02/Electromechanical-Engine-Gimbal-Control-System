
% par2.m	Compensator design for Electromechanical system
% system parameter values
KT=0.181;KB=0.181;Jm=1.1694e-4;JL=12.753;N=1/398;
%N=Nm/NL, the inverse gear ratio 
Bm=2.943e-4;BL=58.86;Ra=8.6;Kp=0.36;KTG=0.1;
% Closed loop specifications 
wb=5*2*pi; 
% -3 db Bandwidth = 5 Hz 
zt=0.6;
% Damping factor
% Controller design equations
wn=wb/sqrt((1-2*zt^2)+sqrt(4*zt^4-4*zt^2+2)); J=Jm+N^2*JL;B=Bm+KT*KB/Ra+N^2*BL;K=KT/Ra;B1=Bm+N^2*BL;
K1=wn^2*J/(Kp*K); K2=(2*zt*wn*J-B)/(K*KTG);
Ki=K1/5;Kd=K2*KTG/Kp; % PID controller gains,(K1,Ki,Kd)
% Nonlinear elements
Tfr=0.06; % Coulomb friction w.r.t motor shaft in N-m 
thm_lmt=4*398*pi/180; % this corresponds to the gimbal deflection limit of 4 deg
Vs=28; % Power supply voltage limit of motor drive
TDm=0.1*KT*Vs/Ra;


