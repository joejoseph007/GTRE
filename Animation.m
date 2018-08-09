
Data_Input = xlsread('Book1.xlsx', 'Data Input');

% input from table given in the textbook (ref attached excel - Book1) 

DI=Data_Input;                

%defines the resolution of the curve ie, the greater the value of res the
%smaller the increment in the input angle

res=0.25;                        

%allocating memory for output. 
%Parameter 1 is defined by number of cases in input(ie =number of elements/number of col)
%Parameter 2 is defined by revolution of control link a and resolution 
%Parameter 3 is defined as follows:
%1 is theta 2
%2 is theta 3
%3 is theta 4
%4 is theta 5
%5 is other theta 3
%6 is other theta 4

DO=zeros(numel(DI)/length(DI),360*res,6);

%Initialising Variables
A=zeros(numel(DI)/length(DI),1);    %Same as textbook
B=zeros(numel(DI)/length(DI),1);    %Same as textbook
C=zeros(numel(DI)/length(DI),1);    %Same as textbook
D=zeros(numel(DI)/length(DI),1);    %Used in place of G in textbook
E=zeros(numel(DI)/length(DI),1);    %Used in place of H in textbook
F=zeros(numel(DI)/length(DI),1);    %Used in place of K in textbook

W=zeros(numel(DI)/length(DI),1);    %Used for root of theta 3 
X=zeros(numel(DI)/length(DI),1);    %Used for root of theta 4 
Y=zeros(numel(DI)/length(DI),1);    %Used for other root of theta 3 
Z=zeros(numel(DI)/length(DI),1);    %Used for other root of theta 4 

ax=zeros(numel(DI)/length(DI),360*res);     %X coordinate of point A
ay=zeros(numel(DI)/length(DI),360*res);     %Y coordinate of point A

bx1=zeros(numel(DI)/length(DI),360*res);    %X coordinate of point B
by1=zeros(numel(DI)/length(DI),360*res);    %Y coordinate of point B
bx2=zeros(numel(DI)/length(DI),360*res);    %X coordinate of point B'
by2=zeros(numel(DI)/length(DI),360*res);    %Y coordinate of point B'

cx=zeros(numel(DI)/length(DI),360*res);     %X coordinate of point C
cy=zeros(numel(DI)/length(DI),360*res);     %X coordinate of point C

dx=zeros(numel(DI)/length(DI),360*res);     %X coordinate of point O5 (as in textbook)
dy=zeros(numel(DI)/length(DI),360*res);     %X coordinate of point O5 (as in textbook)


for g=1:numel(DI)/length(DI)
   
for e=1:360*res

DO(g,e,1)=DI(g,8)+(e-1)/(1*res);            %output of theta 2
DO(g,e,4)=DO(g,e,1).*(DI(g,6))+DI(g,7);     %output of theta 5

%Angles
%refer to textbook for formula verification

A(g,1)=2*DI(g,3).*(DI(g,4).*cosd(DO(g,e,4))+DI(g,5)-DI(g,1).*cosd(DO(g,e,1)));
B(g,1)=2*DI(g,3).*(DI(g,4).*sind(DO(g,e,4))-DI(g,1).*sind(DO(g,e,1)));
C(g,1)=DI(g,1).^2-DI(g,2).^2+DI(g,3).^2+DI(g,4).^2+DI(g,5).^2+2*(DI(g,4).*cosd(DO(g,e,4))).*(DI(g,5)-DI(g,1).*cosd(DO(g,e,1)))-2*DI(g,5).*DI(g,1).*cosd(DO(g,e,1))-2*(DI(g,4).*sind(DO(g,e,4)).*DI(g,1).*sind(DO(g,e,1)));

D(g,1)=2*DI(g,2).*(DI(g,1).*cosd(DO(g,e,1))-DI(g,5)-DI(g,4).*cosd(DO(g,e,4)));
E(g,1)=2*DI(g,2).*(DI(g,1).*sind(DO(g,e,1))-DI(g,4).*sind(DO(g,e,4)));
F(g,1)=DI(g,1).^2+DI(g,2).^2-DI(g,3).^2+DI(g,4).^2+DI(g,5).^2-2*(DI(g,1).*cosd(DO(g,e,1))).*(DI(g,5)+DI(g,4).*cosd(DO(g,e,4)))+2*DI(g,4).*DI(g,5).*cosd(DO(g,e,4))-2*(DI(g,4).*sind(DO(g,e,4)).*DI(g,1).*sind(DO(g,e,1)));

W(g,1)=(-E(g,1)+(E(g,1).^2-(F(g,1).^2-D(g,1).^2)).^0.5)./((F(g,1)-D(g,1)));     %root of theta 3 
X(g,1)=(-B(g,1)-(B(g,1).^2-(C(g,1).^2-A(g,1).^2)).^0.5)./((C(g,1)-A(g,1)));     %root of theta 4

Y(g,1)=(-E(g,1)-(E(g,1).^2-(F(g,1).^2-D(g,1).^2)).^0.5)./((F(g,1)-D(g,1)));     %other root of theta 3
Z(g,1)=(-B(g,1)+(B(g,1).^2-(C(g,1).^2-A(g,1).^2)).^0.5)./((C(g,1)-A(g,1)));     %other root of theta 4

%Check for imaginary roots and elimination by substituting Not a number

if imag(X(g,1))~=0 
X(g,1)=NaN+0i;
end
if imag(Y(g,1))~=0
Y(g,1)=NaN+0i;
end
if imag(W(g,1))~=0
W(g,1)=NaN+0i;
end
if imag(Z(g,1))~=0
Z(g,1)=NaN+0i;
end

%Outputs of theta 3 and 4 

DO(g,e,2)=2*atand(W(g,1));      %theta 3
DO(g,e,3)=2*atand(X(g,1));      %theta 4
DO(g,e,5)=2*atand(Y(g,1));      %other theta 3
DO(g,e,6)=2*atand(Z(g,1));      %other theta 4

%X and Y coordinates of point of the links, A, B, C, O5 and O2 is assumed
%as origin (ref diagram in textbook)

ax(g,e)=DI(g,1)*cosd(DO(g,e,1));
ay(g,e)=DI(g,1)*sind(DO(g,e,1));

bx1(g,e)=DI(g,1)*cosd(DO(g,e,1))+DI(g,2)*cosd(DO(g,e,2));
by1(g,e)=DI(g,1)*sind(DO(g,e,1))+DI(g,2)*sind(DO(g,e,2));
bx2(g,e)=DI(g,1)*cosd(DO(g,e,1))+DI(g,2)*cosd(DO(g,e,5));
by2(g,e)=DI(g,1)*sind(DO(g,e,1))+DI(g,2)*sind(DO(g,e,5));

dx(g,e)=DI(g,5);
dy(g,e)=0;

cx(g,e)=DI(g,5)+DI(g,4)*cosd(DO(g,e,4));
cy(g,e)=DI(g,4)*sind(DO(g,e,4));

%PLOTTING STARTS

figure(g);

%this loop is for curve tracing 
if e>1
for k=1:(e-1)
plot([bx1(g,k);bx1(g,k+1)],[by1(g,k);by1(g,k+1)],'-b');     %curve 1 trace
hold on;
plot([bx2(g,k);bx2(g,k+1)], [by2(g,k);by2(g,k+1)],'-g');    %curve 2 trace

end
end

%display the discountinuity in curve and link constraint
if isnan(bx1(g,e))
text(20,20,'DISCONTINUITY')   
end

plot([0,ax(g,e)],[0,ay(g,e)],'-k','LineWidth',3);                   %link a

plot([ax(g,e),bx1(g,e)],[ay(g,e), by1(g,e)],'-.k','LineWidth',2);   %link b
plot([bx1(g,e),cx(g,e)],[by1(g,e),cy(g,e)],'-.k','LineWidth',2);    %link c

plot([ax(g,e),bx2(g,e)],[ay(g,e), by2(g,e)],'-.r','LineWidth',2);   %link b'
plot([bx2(g,e),cx(g,e)],[by2(g,e),cy(g,e)],'-.r','LineWidth',2);    %link c'

plot([cx(g,e),dx(g,e)],[cy(g,e), dy(g,e)],'-k','LineWidth',3);      %link d
plot([0,dx(g,e)],[0, dy(g,e)],'-k','LineWidth',0.1);                %link f
axis ([-500 500 -400 400]);                     

hold off;
end
axis equal,axis fill;
end


