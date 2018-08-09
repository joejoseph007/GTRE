%Setup is used to initialsie all the variables ready for the iterations. 
%   Detailed explanation goes here
 
%Initial Calculations of Constant Value Variables, Required Variables in
%Workspace are Dia, length, Pressure, oil,minor. 
 
Area =pi*Dia.^2./4;
AreaR=Area(2:7,1)./Area(1,1);
Major=64*oil(2,1)/oil(1,1).*length(1:3,1)./(Dia(1,1)^2);
Major(4:6,1)=64*oil(2,1)/oil(1,1).*length(4:6,1)./(Dia(5:7,1).^2);
Pressure(2,1)=Pressure(1,1)*(30.48/12)^2/0.4536;
Pressure(3,1)=Pressure(1,1)*(30.48/12)^2/0.4536*6895;
Pressure(5,1)=2*(Pressure(3,1)-Pressure(4,1))/oil(1,1);

minor=[160 1 ;500 0.7 ;200 1.1 ];
%intialising the Minor Loss Coefficient Variables
   
%Exit Minor Loss
K(1:3,1)=(minor(1,1)*oil(2,1)/oil(1,1))./Dia(2:4);
K(1:3,2)=minor(1,2);
 
%Branch Minor Loss
K(4:6,1)=(minor(2,1)*oil(2,1)/oil(1,1))./Dia(5:7);
K(4:6,2)=minor(2,2)*(1+0.0254/Dia(1));
 
%In line Minor Loss
K(7:8,1)=minor(3,1)*oil(2,1)/(oil(1,1)*Dia(1));
K(7:8,2)=minor(3,2)*(1+0.0254/Dia(1));
 
%initialising Velocities
Velocity(1:7,1)=5;  
%initialising done
 
Velocity0=zeros(7,1);

C(1:7,1:100)=0; 
i=1; %iteration counter
    
%iteration
while (abs(Velocity0-Velocity)>=0.000000001)
 
     Velocity0=Velocity;
 
     V = sym('V', [7 1]);
 
     f(1,1)=V(1)-AreaR(1)*V(5)- AreaR(2)*V(6)-AreaR(3)*V(7);
     f(2,1)=(1+K(4,2))*V(2)^2+K(4,1)*V(2)- V(1)^2;
     f(3,1)=(1+K(5,2))*V(3)^2+K(5,1)*V(3)-(V(1)-AreaR(1)*V(5))^2;   
     f(4,1)=(1+K(6,2))*V(4)^2+K(6,1)*V(4)-(V(1)-AreaR(1)*V(5)-AreaR(2)*V(6))^2;
     f(5,1)=(1+K(1,1)/V(5)+K(1,2))*V(5)^2+Major(1)*V(1)+Major(4)*V(2)-V(2)^2-Pressure(5);
     f(6,1)=(1+K(2,1)/V(6)+K(2,2))*V(6)^2+Major(1)*V(1)+Major(2)*(V(1)-AreaR(1)*V(5))...
         +Major(5)*V(3)+(K(7,1)/(V(1)-AreaR(1)*V(5))+K(7,2))*(V(1)-AreaR(1)*V(5))^2-V(3)^2-Pressure(5);
     
     f(7,1)=(1+K(3,1)/V(7)+K(3,2))*V(7)^2+Major(1)*V(1)+Major(2)*(V(1)-AreaR(1)*V(5))...
         +Major(3)*(V(1)-AreaR(1)*V(5)-AreaR(2)*V(6))+Major(6)*V(4)+(K(7,1)/(V(1)-AreaR(1)*V(5))...
         +K(7,2))*(V(1)-AreaR(1)*V(5))^2+(K(8,1)/(V(1)-AreaR(1)*V(5)-AreaR(2)*V(6))+K(8,2))*(V(1)-AreaR(1)*V(5)-AreaR(2)*V(6))^2-V(4)^2-Pressure(5);
 
     j=jacobian(f,V);
 
     F=subs(f,V,Velocity);
        J=subs(j,V,Velocity);
 
     Velocity=J\-F+Velocity0;
     C(:,i)=Velocity; 
     i=i+1;    
end    