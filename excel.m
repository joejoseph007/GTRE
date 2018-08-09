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
V0(1:7,1)=5;
    
%initialising done
 
V1=ones(7,1)*1;
    
i=2; %iteration counter
C(1:7,1:100)=0;    
%iteration

 while (abs(V0-V1)>=0.000000001)
      V0=V1;
     
      V1(5)=(-K(1,1)+(K(1,1)^2-4*(Major(1)*V0(1)+Major(4)*V0(2)-V0(2)^2-Pressure(5))*(1+K(1,2)))^0.5)/(2*(1+K(1,2)));
      
      V1(6)=(-K(2,1)+(K(2,1)^2-4*(Major(1)*V0(1)+(Major(2)+K(7,1)+K(7,2)*(V0(1)-AreaR(1)*V1(5)))*(V0(1)-AreaR(1)*V1(5))+Major(5)*V0(3)-V0(3)^2-Pressure(5))*(1+K(2,2)))^0.5)/(2*(1+K(2,2)));
     
      V1(7)=(-K(3,1)+(K(3,1)^2-4*(Major(1)*V0(1)+(Major(2)+K(7,1)+K(7,2)*(V0(1)-AreaR(1)*V1(5)))*(V0(1)-AreaR(1)*V1(5))+(Major(3)+K(8,1)+K(8,2)*(V0(1)-AreaR(1)*V1(5)-AreaR(2)*V1(6)))*(V0(1)-AreaR(1)*V1(5)-AreaR(2)*V1(6))+Major(6)*V0(4)-V0(4)^2-Pressure(5))*(1+K(3,2)))^0.5)/(2*(1+K(3,2)));
 
     V1(1)=AreaR(1)*V1(5)+ AreaR(2)*V1(6)+AreaR(3)*V1(7);
     V1(2)=(-K(4,1)+(K(4,1)^2+4*V1(1)^2*(1+K(4,2)))^0.5)/(2*(1+K(4,2)));
     V1(3)=(-K(5,1)+(K(5,1)^2+4*(V1(1)-AreaR(1)*V1(5))^2*(1+K(5,2)))^0.5)/(2*(1+K(5,2)));
     V1(4)=(-K(6,1)+(K(6,1)^2+4*(V1(1)-AreaR(1)*V1(5)-AreaR(2)*V1(6))^2*(1+K(6,2)))^0.5)/(2*(1+K(6,2)));
    
     C(:,i-1)=V1;   
     i=i+1;

end 