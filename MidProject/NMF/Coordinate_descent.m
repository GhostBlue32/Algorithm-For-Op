function [Wnp1, Hnp1] = Coordinate_descent(A, W0, H0, tol)
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
  [wr,wc] = size(Wn);
  [hr,hc] = size(Hn);
  % Do optimization in a loop to prevent infinite loops
  % from nonconvergence
  for it = 1:500000
    Wnp1 = Wn;
    Hnp1 = Hn;
    % compute matrix R
    R = A - Wn * Hn;

    %---------------------------    
    % update Wn
    % update each wij
    HH = Hn * Hn';
    for i = 1:wr
        for j = 1:wc
            Rht = sum(R(i,:) .* Hn(j,:));
            s = max(-Wn(i,j), Rht / HH(j,j));
            Wnp1(i, j) = Wn(i, j) + s;
            R(i, :) = R(i, :) - s * Hn(j, :);
        end
    end
    %---------------------------
    % update Hn
    WW = Wnp1' * Wnp1;
    for i = 1:hr
        for j = 1:hc
            Wtr = sum(Wnp1(:, i) .* R(:, j));
            s = max(-Hn(i,j), Wtr / WW(i, i));
            Hnp1(i, j) = Hn(i, j) + s;
            R(:, j) = R(:, j) - s * Wnp1(:, i);
        end
    end

    % Check for convergence
    if (norm(Wn - Wnp1) < tol && norm(Hn - Hnp1) < tol)
      fprintf('Converged after %d iterations.\n', it)
      return
    end

        
    
    %fprintf('--------------------------------------------\n')
    %pause()
    
  end  % end of for loop

error('nonnegative matrix factorization terminated without convergence!\n')
end
