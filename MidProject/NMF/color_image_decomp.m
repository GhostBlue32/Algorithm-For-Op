function color_image_decomp()
    tic;
    for p = 100:50:300
        
        starttime = toc;
        tol = 1e-3;
    
        C = imread('Pro.jpg');  % This image is in uint8 format.
        
        % Plot image.  Note that I have made the image small so I don't
        % need to deal with gigantic matrices.  Therefore, I need to
        % magnify the image to display it successfully.
        
        
        % Convert to double before processing.
        Cr = double(C);
        [r,c,fo] = size(Cr);
        fprintf('Image size = [%d,%d,%d].\n', r, c,fo)
        
        % Initialize factor matrices
        W0 = 5*rand(r,p);
        H0 = 5*rand(p,c);
        W1 = 5*rand(r,p);
        H1 = 5*rand(p,c);
        W2 = 5*rand(r,p);
        H2 = 5*rand(p,c);

        % Do factorization
        %[W,H] = nonnegative_matrix_factorization(Cr, W0, H0, tol);
        %[W,H] = Coordinate_descent(Cr, W0, H0, tol);
        %[W,H] = nmfLin(Cr, W0, H0, tol);
        [W0,H0] = nonnegative_matrix_factorization(Cr(:,:,1), W0, H0, tol);
        [W1,H1] = nonnegative_matrix_factorization(Cr(:,:,2), W1, H1, tol);
        [W2,H2] = nonnegative_matrix_factorization(Cr(:,:,3), W2, H2, tol);
        
        [r,c,fo] = size(W0);  
        fprintf('W size = [%d,%d].\n', r, c)  
        
        [r,c,fo] = size(H0);  
        fprintf('H size = [%d,%d].\n', r, c)  
        
        % Reconstruct matrix and display it.
        R = uint8(W0 * H0);  % Red channel
        G = uint8(W1 * H1);  % Green channel
        B = uint8(W2 * H2);  % Blue channel

        % Combine the three channels to form a color image
        D_color = cat(3, R, G, B);
        endtime = toc;

        % Save the image with a name that includes the value of p
        filename = sprintf('demo/reconstructed_image_p=%d.png', p);
        imwrite(D_color, filename);
        fprintf('The time for p=%d is %f s\n', p, endtime - starttime)
    end
  
end
