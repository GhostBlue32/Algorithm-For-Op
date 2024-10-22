function [Wnp1, Hnp1] = nonnegative_matrix_factorization(A, W0, H0, tol)
  % Projected gradient descent used for NMF.  
  % A is the matrix to decompose.  The initial guesses
  % are matrices.
  % Reference:  https://angms.science/doc/NMF/nmf_pgd.pdf

  % I tried both the stepsize in the paper as well as a constant
  % stepsize.  The stepsize in the paper converges somewhat faster
  % (11 sec vs. 16 sec).  
  % alpha = 0.00005;
    
  % Initialize algorithm and display starting point.
  Wn = W0;
  Hn = H0;
  beta = 0.1;

  % Do optimization in a loop to prevent infinite loops
  % from nonconvergence
  for i = 1:500000
    %---------------------------
    % Get gradw at current point [Wn,Hn].
    gwn = Wn * (Hn * (Hn')) - A * (Hn');

    % Step
    HHt = Hn * (Hn');
    tkw = 1 / norm(HHt);
    %tkw = trace((Wn * Hn - A)' * gwn * Hn) / trace(Hn' * (gwn') * (gwn * Hn));
    %delta = alpha*gwn;
    Wnp1 = max(Wn - tkw * gwn, 0);
    
    
    %---------------------------
    % Get gradh at current point [Wn,Hn].
    ghn = Wnp1' * Wnp1 * Hn - Wnp1' * A;

    % Step
    WtW = Wnp1' * Wnp1;
    tkh = 1 / norm(WtW);
    %tkh = trace((Wnp1 * Hn - A)' * Wnp1 * ghn) / trace(ghn' * WtW * ghn);
    %delta = alpha*ghn;
    Hnp1 = max(Hn - tkh * ghn, 0);

    
    
    % init grad
    if i == 1
        initgrad = norm([gwn; ghn'], 'fro');
    end
    % Move variables back.
    Wn = Wnp1;
    Hn = Hnp1; 

    % Check for convergence
    projnorm = norm([gwn(gwn<0 | Wn>0); ghn(ghn<0 | Hn>0)], 'fro');
    if projnorm < tol * initgrad
        fprintf('Converge after %d iteration\n', i);
        fnorm = norm(A - Wnp1 * Hnp1, 'fro');
        fprintf('final norm is %f\n', fnorm);
        break;
    end
    
    %fprintf('--------------------------------------------\n')
    %pause()
    

%error('nonnegative matrix factorization terminated without convergence!\n')
  end
end
