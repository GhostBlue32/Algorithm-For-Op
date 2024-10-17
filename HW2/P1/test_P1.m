function test_P1()
    % This is the test for x = A\b and using the gradient descent to get x
    

    % norm dif and relative dif
    norm_Dif = zeros(1, 20);
    rel_Dif = zeros(1, 20);


    for i = 1:20
        % To indicate the answer x's norm is no larger than 100
        flag = 1;
        while flag > 0
            % Get A
            B = randn(5, 5);
            A = B'* B;
    
            % Test if it is symmetric positive definite
            eigenvalues = eig(A);
            if all(eigenvalues > 0) && norm(A - A') == 0
                fprintf('Success, Matrix is symmetric positive definite\n');
            else
                fprintf('Failed, eig(A) = %f, norm(A - A^T) = %f\n', eigenvalues, norm(A - A'));
            end
    
            % Get b
            b = randn(5, 1);
    
            % "\" operator 
            x_1 = A \ b
    
            % The norm of x_1 is too large, then quit
            if norm(x_1) > 100
                fprintf('Norm of result is too large, norm is %f\n', norm(x_1));
            else
                flag = 0;
            end
        end
        
        % Gradient method
        tol = 1e-5;
        X0 = randn(5, 1);
        lfcn_handle = @(x)lfcn(x, A, b);
        Lgrad_handle = @(x)lgrad(x, A, b);
        % result
        x_2 = gradient_descent(lfcn_handle, Lgrad_handle, X0, tol)

        % Compare two method
        norm_D = norm(x_1 - x_2);
        rel_D = norm(x_1 - x_2) / norm(x_1);
        fprintf('Norm between to method is %f\n', norm_D);
        fprintf('Relative norm between to method is %f\n', rel_D);
        norm_Dif(i) = norm_D;
        rel_Dif(i) = rel_D;
    end
    
    % The average of norm dif
    fprintf('The average of norm dif is %f\n', sum(norm_Dif) / 20);
    % The average of relative norm dif
    fprintf('The average of relative norm dif is %f\n', sum(rel_Dif) / 20);
end


