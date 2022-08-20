clear p
clear D
clear S
clear x
clear Dx
clear Sx

m = 0.5;
a = 1.0;
b = 1.0;

g = 5.0;
c = 0.1;

function [D,S] = F1(p1,p2)
    
    S = a*(p1^m) - b;
    D = g*exp(-1*c*p2);
    
endfunction

function [D,S,pn] = F2(p)
    
    S = a*(p^m) - b;
    D = S;
    pn = (-1/c)*log(D/g);
    S = a*(pn^m) - b;
    
endfunction

N = 1000.0;
p(1) = 0; 

for i = 2:N
    
    p(i) = (i-1)*0.1;
    [D(i),S(i)] = F1(p(i-1),p(i));
    
end

plot(p,D,p,S)

M = 10000.0;
S0 = 4.0;
x(1) = ((S0 + b)/a)^(1/m);

[Dx(1),Sx(1)] = F1(x(1),x(1));

for i = 2:M;
    
    [Dx(i),Sx(i),x(i)] = F2(x(i-1));
    y(2*i - 3) = x(i);
    y(2*i - 2) = x(i);
    A(2*i - 3) = Dx(i);
    A(2*i - 2) = Sx(i);
    
end

plot2d(y,A,style=color('red'))
