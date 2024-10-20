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
    WHHt = Wn * Hn * (Hn');
    gwn = WHHt - A * (Hn');

    % Step
    HHt = Hn * (Hn');
    %delta = alpha*gwn;

    % Backstepping
    alpha = 1;
    for iter = 1:20
        Wi = max(Wn - alpha * gwn, 0);
        d = Wi - Wn;
        gradd = sum(sum(gwn .* d));
        dQd = sum(sum((d * HHt) .* d));
        signal = 0.99 * gradd + 0.5 * dQd < 0;
        if iter == 1
            dec_al = ~signal;
            Wp = Wn;
        end
        if dec_al
            if signal
                Wnp1 = Wi;
                fprintf('Yes\n')
                break;
            else
                alpha = alpha * beta;
            end
        else
            if ~signal | Wp == Wi | norm(Wi) == 0
                Wnp1 = Wp;
                break;
            else
                alpha = alpha / beta;
                Wp = Wi;
            end
        end
    end

    
    %---------------------------
    % Get gradh at current point [Wn,Hn].
    WtWH = Wn' * Wn * Hn;
    ghn = WtWH - Wn' * A;

    % Step
    WtW = Wn' * Wn;
    %delta = alpha*ghn; 

    % Backstepping
    alpha = 1;
    for iter = 1:20
        Hi = max(Hn - alpha * ghn, 0);
        d = Hi - Hn;
        gradd = sum(sum(ghn .* d));
        dQd = sum(sum((WtW * d) .* d));
        signal = 0.99 * gradd + 0.5 * dQd < 0;
        if iter == 1
            dec_al = ~signal;
            Hp = Hn;
        end
        if dec_al
            if signal
                Hnp1 = Hi;
                fprintf('Yes\n')
                break;
            else
                alpha = alpha * beta;
            end
        else
            if ~signal | Hp == Hi | norm(Hi) == 0
                Hnp1 = Hp;
                break;
            else
                alpha = alpha / beta;
                Hp = Hi;
            end
        end
    end
    
    % init grad
    if i == 1
        initgrad = norm([gwn; ghn'], 'fro');
    % Move variables back.
    Wn = Wnp1;
    Hn = Hnp1; 

    % Check for convergence
    projnorm = norm([gwn(gwn<0 | Wn>0); ghn(ghn<0 | Hn>0)]);
    if projnorm < tol * initgrad
        break;
    end
    
    %fprintf('--------------------------------------------\n')
    %pause()
    
  end  % end of for loop

%error('nonnegative matrix factorization terminated without convergence!\n')
end
