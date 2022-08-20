function dv = fdv(v,E,B)

q = 1;
m = 1;

dv = [];

dv(1) = (q/m)*(E(1) + v(2)*B(3) - v(3)*B(2));
dv(2) = (q/m)*(E(2) + v(3)*B(1) - v(1)*B(3));
dv(3) = (q/m)*(E(3) + v(1)*B(2) - v(2)*B(1));