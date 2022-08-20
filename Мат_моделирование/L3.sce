//Решение уравнения колеблющейся струны

clear x;
clear f;
clear t;
clear u;
clear R;
clear Er;

Fn = 500;
r = 7.8;
a = sqrt(Fn/r);
L = 1.5;
T = 5;

N = 100;
M = 100;

function f = F(x,t)
    
    if x == L/4 then
        f = 0.02*sin(2*%pi*0.4*t);
    else
        f = 0;
    end
    
    
endfunction

dx = L/N;
dt = T/M;

for i = 1:N+1
    
    x(i) = (i-1)*dx;
    
end

for j = 1:M+1
    
    t(j) = (j-1)*dt;
    u(1,j) = 0;
    u(N+1,j) = 0;
    
end

for i = 1:N+1
        
    for j = 1:M+1
        
        f(i,j) = F(x(i),t(j));
        
    end
    
end

R(N+1,M+1) = 0;
Rm = 1;
k = 1;

while Rm > 0.0001
    
  for j = 3:M
    
      for i = 2:N
        
        V = (0.5/(a*dt^2 - dx^2))*(a*dt^2*(u(i-1,j) + u(i+1,j)) - dx^2*(u(i,j-1) + u(i,j+1)) + dt^2*f(i,j));
        R(i,j) = abs(V - u(i,j));
        u(i,j) = V;
        
      end   
        
    end
    
    Rm = R(1,1);
    
    for i = 1:N+1
        for j = 1:M+1
            if R(i,j) > Rm then Rm = R(i,j); end
        end
    end
    
    s=get("current_axes")
    delete(s.children)
    subplot(2,1,1);
    surf(x,t,u')
    xlabel('x')
    ylabel('t')
    Er(k) = Rm;
    k = k + 1;
    subplot(2,1,2);
    plot(Er)
    ylabel('Error')
    
end

















    
