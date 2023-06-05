Lx = 1;
dx = 0.01;
nx = fix(Lx/dx);
x = linspace(0,Lx,nx);
T = 2;
wn = zeros(nx,1);
wnm1 = wn; wnp1 = wn;
CFL = 0.9;
c = 2;
dt = CFL*dx/c
wn(:) = x(:)+7;
q = wn;
t = dt;
for i=2:nx-1
    wnp1(i)= wn(i) + 0.5*CFL^2 * (wn(i+1)-2*wn(i)+wn(i-1)) + t*(2*x(i)+3);
end
wnp1(1) = 2+2*t;
wnp1(end) = 1;
while(t<T)
    wnm1 = wn ; wn = wnp1;
    t = t+dt;
    for i=2:nx-1
    wnp1(i)= 2*wn(i) - wnm1(i) + CFL^2 * (wn(i+1)-2*wn(i)+wn(i-1));
    wnm1 = wn; wn = wnp1;
    end
    wnp1(1) = 2+2*t;
    wnp1(end) = 1;
    wn(1) = 2+2*t;
    wn(end) = 1;
    clf;
    plot(x,wn);
    q = [q wn];
    axis([0 Lx -10 10]);
    pause(0.01);
end
q
figure(1)
plot(x,q(:,1),'-',x,q(:,50),'-',x,q(:,100),'-',x,q(:,200),'-',x,q(:,350),'-')
legend('t = 0.0','t = 0.225','t = 0.45','t = 0.9','t = 1.575');
title('displacement of the string')
xlabel('X')
ylabel('U(displacement)')
