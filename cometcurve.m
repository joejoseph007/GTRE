
Data_Input = xlsread('Book1.xlsx', 'Data Input');
DI=Data_Input;

res=10;
DO=zeros(numel(DI)/length(DI),360*res,6);

A=zeros(numel(DI)/length(DI),1);
B=zeros(numel(DI)/length(DI),1);
C=zeros(numel(DI)/length(DI),1);
D=zeros(numel(DI)/length(DI),1);
E=zeros(numel(DI)/length(DI),1);
F=zeros(numel(DI)/length(DI),1);
W=zeros(numel(DI)/length(DI),1);
X=zeros(numel(DI)/length(DI),1);
Y=zeros(numel(DI)/length(DI),1);
Z=zeros(numel(DI)/length(DI),1);

bx1=zeros(numel(DI)/length(DI),360*res);
by1=zeros(numel(DI)/length(DI),360*res);
bx2=zeros(numel(DI)/length(DI),360*res);
by2=zeros(numel(DI)/length(DI),360*res);

for g=1:numel(DI)/length(DI)
    
for e=0:360*res
    
DO(g,e+1,1)=DI(g,8)+e/(1*res);
DO(g,e+1,4)=DO(g,e+1,1).*(DI(g,6))+DI(g,7);
%Angle

%DO(g,5)=DI(g,8).*(DI(g,6))+DI(g,7);

A(g,1)=2*DI(g,3).*(DI(g,4).*cosd(DO(g,e+1,4))+DI(g,5)-DI(g,1).*cosd(DO(g,e+1,1)));
B(g,1)=2*DI(g,3).*(DI(g,4).*sind(DO(g,e+1,4))-DI(g,1).*sind(DO(g,e+1,1)));
C(g,1)=DI(g,1).^2-DI(g,2).^2+DI(g,3).^2+DI(g,4).^2+DI(g,5).^2+2*(DI(g,4).*cosd(DO(g,e+1,4))).*(DI(g,5)-DI(g,1).*cosd(DO(g,e+1,1)))-2*DI(g,5).*DI(g,1).*cosd(DO(g,e+1,1))-2*(DI(g,4).*sind(DO(g,e+1,4)).*DI(g,1).*sind(DO(g,e+1,1)));

D(g,1)=2*DI(g,2).*(DI(g,1).*cosd(DO(g,e+1,1))-DI(g,5)-DI(g,4).*cosd(DO(g,e+1,4)));
E(g,1)=2*DI(g,2).*(DI(g,1).*sind(DO(g,e+1,1))-DI(g,4).*sind(DO(g,e+1,4)));
F(g,1)=DI(g,1).^2+DI(g,2).^2-DI(g,3).^2+DI(g,4).^2+DI(g,5).^2-2*(DI(g,1).*cosd(DO(g,e+1,1))).*(DI(g,5)+DI(g,4).*cosd(DO(g,e+1,4)))+2*DI(g,4).*DI(g,5).*cosd(DO(g,e+1,4))-2*(DI(g,4).*sind(DO(g,e+1,4)).*DI(g,1).*sind(DO(g,e+1,1)));

W(g,1)=(-E(g,1)+(E(g,1).^2-(F(g,1).^2-D(g,1).^2)).^0.5)./((F(g,1)-D(g,1)));
X(g,1)=(-B(g,1)-(B(g,1).^2-(C(g,1).^2-A(g,1).^2)).^0.5)./((C(g,1)-A(g,1)));

Y(g,1)=(-E(g,1)-(E(g,1).^2-(F(g,1).^2-D(g,1).^2)).^0.5)./((F(g,1)-D(g,1)));
Z(g,1)=(-B(g,1)+(B(g,1).^2-(C(g,1).^2-A(g,1).^2)).^0.5)./((C(g,1)-A(g,1)));



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


DO(g,e+1,2)=2*atand(W(g,1));
DO(g,e+1,5)=2*atand(X(g,1));
DO(g,e+1,3)=2*atand(Y(g,1));
DO(g,e+1,6)=2*atand(Z(g,1));

bx1(g,e+1)=DI(g,1)*cosd(DO(g,e+1,1))+DI(g,2)*cosd(DO(g,e+1,2));
by1(g,e+1)=DI(g,1)*sind(DO(g,e+1,1))+DI(g,2)*sind(DO(g,e+1,2));
bx2(g,e+1)=DI(g,1)*cosd(DO(g,e+1,1))+DI(g,2)*cosd(DO(g,e+1,3));
by2(g,e+1)=DI(g,1)*sind(DO(g,e+1,1))+DI(g,2)*sind(DO(g,e+1,3));


end

figure(g);
hold on;
axis ([-500 500 -500 500]);
axis fill;
comet(bx1(g,:), by1(g,:));
comet(bx2(g,:), by2(g,:));
hold off;

end


