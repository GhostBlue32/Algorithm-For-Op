function run_nonnegative_matrix_factorization_image()
    tic;
    for p = 10:10:100
        
        starttime = toc;
        tol = 1e-3;
    
        C = imread('Pro.png');  % This image is in uint8 format.
        
        % Plot image.  Note that I have made the image small so I don't
        % need to deal with gigantic matrices.  Therefore, I need to
        % magnify the image to display it successfully.
        
        
        % Convert to double before processing.
        Cr = double(C);
        [r,c] = size(Cr);
        fprintf('Image size = [%d,%d].\n', r, c)
        
        % Initialize factor matrices
        W0 = 5*rand(r,p);
        H0 = 5*rand(p,c);
        
        % Do factorization
        %[W,H] = nonnegative_matrix_factorization(Cr, W0, H0, tol);
        [W,H] = Coordinate_descent(Cr, W0, H0, tol);
        
        [r,c] = size(W);  
        fprintf('W size = [%d,%d].\n', r, c)  
        
        [r,c] = size(H);  
        fprintf('H size = [%d,%d].\n', r, c)  
        
        % Reconstruct matrix and display it.
        D = uint8(W*H);
        endtime = toc;

        % Save the image with a name that includes the value of p
        %filename = sprintf('GSDresult/reconstructed_image_p=%d.png', p);
        filename = sprintf('CDresult/reconstructed_image_p=%d.png', p);
        imwrite(D, filename);
        fprintf('The time for p=%d is %f s\n', p, endtime - starttime)
    end
  
end
