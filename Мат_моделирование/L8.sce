clear A;
clear B;

N = 50;
m = 1;

for i = 1:N
    
    for j = 1:N
        
        r = rand();
        
        if r >= 0.5 then
            
            A(i,j) = 2;
            
        else
            
            A(i,j) = 1;
            
        end
        
    end
    
end

for t = 1:60
    
    for i = 1:N
        
        for j = 1:N
            
            S = 0;
            
            if A(i,j) == 1 then
                
                for k1 = (i - m):(i + m)
                    
                    for k2 = (j - m):(j + m)
                        
                        if ((k1 >= 1) && (k1 <= N)) then
                            
                            if ((k2 >= 1) && (k2 <= N)) then
                                
                                if (A(k1,k2) == 2) then
                                    S = S + 1;
                                end
                                
                            elseif (k2 < 1) then
                                
                                if (A(k1,k2 + N) == 2) then
                                    S = S + 1;
                                end
                                
                            elseif (k2 > N) then
                                
                                if (A(k1,k2 - N) == 2) then
                                    S = S + 1;
                                end
                            
                            end
                            
                        elseif (k1 < 1) then
                            
                            if ((k2 >= 1) && (k2 <= N)) then
                                
                                if (A(k1 + N,k2) == 2) then
                                    S = S + 1;
                                end
                                
                            elseif (k2 < 1) then
                                
                                if (A(k1 + N,k2 + N) == 2) then
                                    S = S + 1;
                                end
                                
                            elseif (k2 > N) then
                                
                                if (A(k1 + N,k2 - N) == 2) then
                                    S = S + 1;
                                end
                               
                           end
                                                                                  
                        elseif (k1 > N) then
                            
                            if ((k2 >= 1) && (k2 <= N)) then
                                
                                if (A(k1 - N,k2) == 2) then
                                    S = S + 1;
                                end
                                
                            elseif (k2 < 1) then
                                
                                if (A(k1 - N,k2 + N) == 2) then
                                    S = S + 1;
                                end
                                
                            elseif (k2 > N) then
                                
                                if (A(k1 - N,k2 - N) == 2) then
                                    S = S + 1;
                                end
                               
                           end
                       
                       end
                       
                   end
                   
               end
               
               if S >= 2 then B(i,j) = 2; end
               
               
               elseif A(i,j) == 2 then
                
                for k1 = (i - m):(i + m)
                    
                    for k2 = (j - m):(j + m)
                        
                        if ((k1 >= 1) && (k1 <= N)) then
                            
                            if ((k2 >= 1) && (k2 <= N)) then
                                
                                if (A(k1,k2) == 2) then
                                    S = S + 1;
                                end
                                
                            elseif (k2 < 1) then
                                
                                if (A(k1,k2 + N) == 2) then
                                    S = S + 1;
                                end
                                
                            elseif (k2 > N) then
                                
                                if (A(k1,k2 - N) == 2) then
                                    S = S + 1;
                                end
                            
                            end
                            
                        elseif (k1 < 1) then
                            
                            if ((k2 >= 1) && (k2 <= N)) then
                                
                                if (A(k1 + N,k2) == 2) then
                                    S = S + 1;
                                end
                                
                            elseif (k2 < 1) then
                                
                                if (A(k1 + N,k2 + N) == 2) then
                                    S = S + 1;
                                end
                                
                            elseif (k2 > N) then
                                
                                if (A(k1 + N,k2 - N) == 2) then
                                    S = S + 1;
                                end
                               
                           end
                                                                                  
                        elseif (k1 > N) then
                            
                            if ((k2 >= 1) && (k2 <= N)) then
                                
                                if (A(k1 - N,k2) == 2) then
                                    S = S + 1;
                                end
                                
                            elseif (k2 < 1) then
                                
                                if (A(k1 - N,k2 + N) == 2) then
                                    S = S + 1;
                                end
                                
                            elseif (k2 > N) then
                                
                                if (A(k1 - N,k2 - N) == 2) then
                                    S = S + 1;
                                end
                               
                           end
                       
                   end
                   
               end
               
           end
           
           if S - 1 > 3 then B(i,j) = 1; end
           
       end 
       
   end 
   end

    A = B;
                    
    Matplot(A);
    
    sleep(0.1,'s');

end

