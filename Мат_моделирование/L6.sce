clear x;
clear m;
clear U;
clear a;
clear u;
clear g;
clear z;

clear E;
clear Te;
clear R;
clear D;

clear A;
clear B;
clear T;

me = 9.1093897e-31;
qe = 1.60217733e-19;
h = (6.6260755e-34) / (2*%pi);

function g = fg(m,E,U)
    
    g = sqrt(2*m*(E - U)/(h*h));
    
endfunction

function T = fT(g1,g2,m1,m2,z)
    
    T(1,1) = 0.5*(1 + (g1/g2)*(m2/m1))*exp(-1*%i*(g2-g1)*z);
    T(1,2) = 0.5*(1 - (g1/g2)*(m2/m1))*exp(-1*%i*(g2+g1)*z);
    T(2,1) = 0.5*(1 - (g1/g2)*(m2/m1))*exp(%i*(g2+g1)*z);
    T(2,2) = 0.5*(1 + (g1/g2)*(m2/m1))*exp(%i*(g2-g1)*z);
    
endfunction

function D = fD(g_first,g_last,m_first,m_last,T)
    
    D = abs(g_last/g_first)*(m_first/m_last)*(abs((T(2,2)*T(1,1) - T(1,2)*T(2,1))/T(2,2)))^2
    
endfunction

function R = fR(T)
    
    R = (abs(T(2,1)/T(2,2)))^2;
    
endfunction

function B_first = fB_first(A_first,T)
    
        B_first = -1*(T(2,1)/T(2,2))*A_first;
    
endfunction

function A_last = fA_last(A_first,T)
    
    A_last = (T(2,2)*T(1,1) - T(1,2)*T(2,1))/T(2,2)*A_first;
    
endfunction

function m = fm(x)
    
    m = (0.067 + 0.083*x)*me;
    
endfunction

function Eg = fEg(x)
    
    if x < 0.45 then
        
        Eg = (1.424 + 1.247*x)*qe;
        
    else
        
        Eg = (1.9 + 0.125*x + 0.143*x*x)*qe;
        
    end
    
endfunction

function a0 = fa0(x)
    
    a0 = (0.56533 + 0.00078*x)*1e-9;
    
endfunction

function F = fF(z,g,A,B)
    
        
        F = (abs(A*exp(%i*g*z) + B*exp(-1*%i*g*z)))^2;
        
    
endfunction

function [a,g,m,u,Te] = main(z,E)
    
    x(1) = 0;
    a(1) = 0;
    u(1) = fEg(x(1))/2;
    m(1) = fm(x(1));
    g(1) = fg(m(1),E,u(1));
    
    for i = 2:N
        
        if pmodulo(i,2) == 1 then
         
           x(i) = 0;
         
        else
         
           x(i) = 0.3;
         
        end
        
        u(i) = fEg(x(i))/2;
        m(i) = fm(x(i));
        g(i) = fg(m(i),E,u(i));
        a(i) = a(i-1) + M*fa0(x(i));
        
    end  
       
    Te = fT(g(1),g(2),m(1),m(2),a(1));
    
    for i = 2:N-1
        
        Te = fT(g(i),g(i+1),m(i),m(i+1),a(i))*Te;
        
    end
    
endfunction

function [U,F] = pF(z,E)
    
    [a,g,m,u,Te] = main(z,E);
    
    A(1) = 0.18;
    B(1) = fB_first(A(1),Te);
    A(N) = fA_last(A(1),Te);
    B(N) = 0;
 
    for i = 2:N-1
     
         T = fT(g(i-1),g(i),m(i-1),m(i),a(i-1));
         A(i) = A(i-1)*T(1,1) + B(i-1)*T(1,2);
         B(i) = A(i-1)*T(2,1) + B(i-1)*T(2,2);
     
    end
    
    j = 1;
    
    for i = 1:length(z);
     
     if (z(i) < a(j)) || (j == N) then
         
         U(i) = u(j);
         F(i) = fF(z(i),g(j),A(j),B(j));
         
     else
         
         j = j + 1;
         U(i) = u(j);
         F(i) = fF(z(i),g(j),A(j),B(j));
         
     end
           
    end
    
    
endfunction

N = 7;
M = 10;
s = 1000;

z0 = -10e-9;
zN = 5.5e-9*N;
z = z0:(zN-z0)/s:zN;

E = 0.8*qe:(1.5*qe/1000):2.5*qe;

for i = 1:length(E)
    
    [a,g,m,u,Te] = main(z,E(i));
    R(i) = fR(Te);
    D(i) = fD(g(1),g(N),m(1),m(N),Te); 
    
end

subplot(2,1,1);
plot(E/qe,R,E/qe,D);

E1 = 0.95*qe;
E2 = 1.15*qe;
E3 = 0.75*qe;

[U1,F1] = pF(z,E1);
[U2,F2] = pF(z,E2);
[U3,F3] = pF(z,E3);

subplot(2,1,2); 
plot(z,U1/qe,z,F1 + E1/qe,z,U2/qe,z,F2 + E2/qe,z,U3/qe,z,F3 + E3/qe)
