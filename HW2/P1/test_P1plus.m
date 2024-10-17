function test_P1()
    for i = 1:20

        % Get A
        B = randn(5, 5);
        A = B' * B;

        % Test if it is symmetric positive definite
        eigenvalues = eig(A);
        if all(eigenvalues > 0) && norm(A - A') == 0
            fprintf('Success, Matrix is symmetric positive definite\n');
        else
            fprintf('Failed, eig(A) = [');
            fprintf('%f ', eigenvalues);  % 使用循环打印所有特征值
            fprintf('], norm(A - A^T) = %f\n', norm(A - A'));
        end

        % Get b
        b = randn(5, 1);

        % "\" operator 
        x_1 = A \ b;
        
        % Gradient method
        tol = 1e-5;
        X0 = randn(5, 1);
        lfcn_handle = @(x) lfcn(x, A, b);
        Lgrad_handle = @(x) lgrad(x, A, b);

        % result
        x_2 = gradient_descent(lfcn_handle, Lgrad_handle, X0, tol);

        % Compare two methods
        fprintf('Norm between two methods is %f\n', norm(x_1 - x_2));
    end
end

% 梯度下降法
function X = gradient_descent(lfcn, lgrad, X0, tol)
  % Armijo's rule parameter -- sets desired decrease of obj fcn.
  c1 = .01; 
    
  % Initialize algorithm
  X = X0;

  for i = 1:1000
    % Compute the fcn here
    fx = lfcn(X);

    % Get the gradient at point X. This is the direction to step in.
    gn = lgrad(X);

    % Line search using backtracking. Use Armijo's rule to validate step length.
    alpha = 1;  % Initial step size
    fxstep = lfcn(X - alpha * gn);

    % Iterate until Armijo's rule is satisfied.
    for j = 1:25
      if fxstep > fx - c1 * alpha * norm(gn)^2
        alpha = alpha / 2;  % Shrink step.
        fxstep = lfcn(X - alpha * gn);
        
        % Ensure alpha does not shrink too small
        if alpha < 1e-10
            error('Step size too small, gradient descent failed to converge');
        end
      else 
        break;
      end
    end
    
    % Update X using the value of alpha we found.
    X = X - alpha * gn;

    % Check if we're close enough to quit yet.  
    % Use norm(gn) < tol as stopping criterion
    if norm(gn) < tol
      fprintf('Terminating after %d iterations.\n', i);
      return;
    end
  end

  error('Terminated without convergence!\n');
end

% 损失函数
function fx = lfcn(x, A, b)
    fx = 0.5 * x' * A * x - x' * b;
end

% 梯度函数
function gx = lgrad(x, A, b)
    gx = A * x - b;
end