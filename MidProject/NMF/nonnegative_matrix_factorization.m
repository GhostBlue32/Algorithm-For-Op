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
  Wnp1 = W0;
  Hnp1 = H0;
  flag = 1;
  i = 1;

  % Do optimization in a loop to prevent infinite loops
  % from nonconvergence
  while i < 500000
    Wn = Wnp1;
    Hn = Hnp1;
    %---------------------------
    % Step and Gradient
    HHt = Hn * (Hn');
    tkw = 1 / norm(HHt);
    gwn = Wnp1 * (HHt) - A * (Hn');
    
    lambda = 0;
    V = Wn;
    for ineri = 1:100
        lambdap = lambda;
        lambda = 0.5 * (1 + sqrt(1 + 4 * lambda^2));
        gamma = (1 - lambdap) / lambda;
        Vp = V;
        WHHt = (Wnp1 - Wn) * HHt;
        gwnn = gwn + WHHt;
        V = max(Wnp1 - tkw * gwnn, 0);
        Wnp1 = (1 - gamma) * V + gamma * Vp;
        i = i + 1;
        if ineri == 3
            initg = norm(WHHt);
        else 
            if ineri > 3 && norm(WHHt) < initg * 0.8 * (1 - gamma)
                break
            end
        end
    end
    gwn = gwnn;

    %---------------------------    
    % Step and Gradient
    WtW = Wnp1' * Wnp1;
    tkh = 1 / norm(WtW);
    ghn = WtW * Hnp1 - Wnp1' * A;
    
    lambda = 0;
    G = Hn;
    for ineri = 1:100
        lambdap = lambda;
        lambda = 0.5 * (1 + sqrt(1 + 4 * lambda^2));
        gamma = (1 - lambdap) / lambda;
        Gp = G;
        WtWh = WtW * (Hnp1 - Hn);
        ghnn = ghn + WtWh;
        G = max(Hnp1 - tkh * ghnn, 0);
        Hnp1 = (1 - gamma) * G + gamma * Gp;
        i = i + 1;
        if ineri == 3
            inith = norm(WtWh);
        else 
            if ineri > 3 && norm(WtWh) < inith * 0.8 * (1 - gamma)
                break
            end
        end
    end
    ghn = ghnn;

    

    
    
    % init grad
    if flag == 1
        initgrad = norm([gwn; ghn'], 'fro');
        flag = 0;
    end
    

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
