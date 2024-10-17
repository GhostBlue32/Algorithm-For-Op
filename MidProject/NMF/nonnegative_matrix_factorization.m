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

  % Do optimization in a loop to prevent infinite loops
  % from nonconvergence
  for i = 1:500000
    %---------------------------
    % Get gradw at current point [Wn,Hn].
    gwn = gradw(A, Wn, Hn);

    % Step
    tkw = 1/norm(Hn*Hn');   % Step size from reference.
    delta = tkw*gwn;
    %delta = alpha*gwn;    

    % Update Wn
    Wnp1 = Wn - delta;

    % Projection step -- 
    % if any elements of Wnp1 are negative, find them and
    % set them to zero.  
    idx = find(Wnp1<0);
    Wnp1(idx) = 0;
    
    %---------------------------
    % Get gradh at current point [Wn,Hn].
    ghn = gradh(A, Wn, Hn);

    % Step
    tkh = 1/norm(Wn'*Wn);
    delta = tkh*ghn;
    %delta = alpha*ghn;    

    % Update Hn
    Hnp1 = Hn - delta;

    % If any elements of Hnp1 are negative, find them and
    % set them to zero.
    idx = find(Hnp1<0);
    Hnp1(idx) = 0;

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

error('nonnegative matrix factorization terminated without convergence!\n')
end
