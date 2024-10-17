function P2_test()
    % This tests the comparison of central and forward difference
    

    % Define hvec  x
    hvec = [1e-4, 1e-3, 1e-2, 1e-1];% stpe size vector
    x = 2; % x value
    
    % plot the error vs stpesize
    comparePlot(@f, @fp, x, hvec);
    
    
    
end




% f formula
function fx = f(x)
    fx = x ^ 3 - 5 * x ^ 2 + 7 * x - 2;
end


% f differential formula
function fp = fp(x) 
    fp = 3 * x ^ 2 - 10 * x + 7;
end
