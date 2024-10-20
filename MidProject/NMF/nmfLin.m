function [W,H] = nmfLin(V,Winit,Hinit,tol)
% NMF by alternative non-negative least squares using projected gradients
% Author: Chih-Jen Lin, National Taiwan University
% W,H: output solution
% Winit,Hinit: initial solution
% tol: tolerance for a relative stopping condition
% timelimit, maxiter: limit of time and iterations
    W = Winit;
    H = Hinit; 
    maxiter = 500000;
    gradW = W*(H*H') - V*H';
    gradH = (W'*W)*H - W'*V;
    initgrad = norm([gradW; gradH'],'fro');

    fprintf('Init gradient norm %f\n', initgrad);
    tolW = max(0.001,tol)*initgrad; 
    tolH = tolW;
    for iter=1:maxiter
        % stopping condition
        projnorm = norm([gradW(gradW<0 | W>0); gradH(gradH<0 | H>0)]);
        if projnorm < tol*initgrad
            break;
        end
        [W,gradW,iterW] = nlssubprob(V',H',W',tolW,1000); 
        W = W'; 
        gradW = gradW';
        if iterW==1
            tolW = 0.1 * tolW;
        end
        [H,gradH,iterH] = nlssubprob(V,W,H,tolH,1000);
        if iterH==1
            tolH = 0.1 * tolH;
        end
        if rem(iter,10)==0, fprintf('.'); end
    end
    fprintf('\nIter = %d Final proj-grad norm %f\n', iter, projnorm);