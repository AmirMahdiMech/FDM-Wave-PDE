Lx = 1; % length of the string
dx = 0.01; % space step size
nx = fix(Lx/dx); 
x = linspace(0,Lx,nx); % space vector
T = 2;
wn = zeros(nx,1); % u(t)
wnm1 = wn; wnp1 = wn; % u(t-1) and u(t+1) respectively
CFL = 0.9; % Parameter of method 
c = 2; % wave speed
dt = CFL*dx/c 
wn(:) = x(:)+7; % initial condition(u(0))
q = wn; 
t = dt;
for i=2:nx-1
    wnp1(i)= wn(i) + 0.5*CFL^2 * (wn(i+1)-2*wn(i)+wn(i-1)) + t*(2*x(i)+3); % Recursive FDM method for implementing initial condition for velocity 
end
wnp1(1) = 2+2*t; % initial velocity condition(u_t(0)) 
wnp1(end) = 1;
while(t<T)
    wnm1 = wn ; wn = wnp1;
    t = t+dt;
    for i=2:nx-1
    wnp1(i)= 2*wn(i) - wnm1(i) + CFL^2 * (wn(i+1)-2*wn(i)+wn(i-1)); % Recursive FDM method
    wnm1 = wn; wn = wnp1;
    end
    wnp1(1) = 2+2*t; % Boundary condition u(0,t)
    wnp1(end) = 1; % Boundary condition u(Lx,t)
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
legend('t = 0.0 s','t = 0.225 s','t = 0.45 s','t = 0.9 s','t = 1.575 s');
title('displacement of the string')
xlabel('X')
ylabel('U(displacement)')
