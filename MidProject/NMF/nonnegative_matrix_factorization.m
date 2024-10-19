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
    tkw = 1/norm(HHt);   % Step size from reference.
    %delta = alpha*gwn;

    % Backstepping
    alpha = 1;
    for iter = 1:20
        Wi = max(Wn - alpha * tkw * gwn, 0);
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
                break;
            else
                alpha = alpha * beta;
            end
        else
            Wnp1 = Wi;
            break;
            % if ~signal | Wp == Wi
            %     Wnp1 = Wp;
            %     break;
            % else
            %     alpha = alpha / beta;
            %     Wp = Wi;
            % end
        end
    end

    
    %---------------------------
    % Get gradh at current point [Wn,Hn].
    WtWH = Wn' * Wn * Hn;
    ghn = WtWH - Wn' * A;

    % Step
    WtW = Wn' * Wn;
    tkh = 1/norm(WtW);
    %delta = alpha*ghn; 

    % Backstepping
    alpha = 1;
    for iter = 1:20
        Hi = max(Hn - alpha * tkh * ghn, 0);
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
                break;
            else
                alpha = alpha * beta;
            end
        else
            Hnp1 = Hi;
            break;
            % if ~signal | Hp == Hi
            %     Hnp1 = Hp;
            %     break;
            % else
            %     alpha = alpha / beta;
            %     Hp = Hi;
            % end
        end
    end

   

    % Check for convergence
    if (norm(Wn - Wnp1) < tol && norm(Hn - Hnp1) < tol)
      fprintf('Converged after %d iterations.\n', i)
      return
    end

    % Move variables back.
    Wn = Wnp1;
    Hn = Hnp1;    
    
    %fprintf('--------------------------------------------\n')
    %pause()
    
  end  % end of for loop

%error('nonnegative matrix factorization terminated without convergence!\n')
end
