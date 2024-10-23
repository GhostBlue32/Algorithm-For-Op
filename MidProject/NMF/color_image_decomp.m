function color_image_decomp()
    C = imread('Pro.jpg');  % This image is in uint8 format.
    % Convert to double before processing.
    Cr = double(C);
    [r,c,fo] = size(Cr);
    fprintf('Image size = [%d,%d,%d].\n', r, c,fo)
    tic;
    startp = floor(r / 6);
    endp = floor(r / 2);
    for p = startp:50:endp
        
        starttime = toc;
        tol = 1e-3;
            
        % Plot image.  Note that I have made the image small so I don't
        % need to deal with gigantic matrices.  Therefore, I need to
        % magnify the image to display it successfully.
        
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
        
        [r1,c1,fo] = size(W0);  
        fprintf('W size = [%d,%d].\n', r1, c1)  
        
        [r2,c2,fo] = size(H0);  
        fprintf('H size = [%d,%d].\n', r2, c2)  
        
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
