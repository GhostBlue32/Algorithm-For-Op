function test_P2()
    D_S1 = [0, 1, 0, -sqrt(3);
        0, 0, 1, -sqrt(3);
        1, 0, 0, -sqrt(3)];
    D_S2 = [0, 1, 0, 0, -1, 0;
        0, 0, 1, 0, 0, -1;
        1, 0, 0, -1, 0, 0];
    D_S3 = [-sqrt(3), sqrt(3), -sqrt(3), sqrt(3), -sqrt(3), sqrt(3), -sqrt(3), sqrt(3);
         sqrt(3), -sqrt(3), -sqrt(3), sqrt(3), sqrt(3), -sqrt(3), -sqrt(3), sqrt(3);
         sqrt(3), sqrt(3), sqrt(3), sqrt(3), -sqrt(3), -sqrt(3), -sqrt(3), -sqrt(3)];
    u0 = [0.5; 0.5; 0.5];
    fprintf('D_S1, ')
    xend = gps(@Hartmann, u0, D_S1, 0.2, 1e-6)
    fprintf('D_S2, ')
    xend = gps(@Hartmann, u0, D_S2, 0.2, 1e-6);
    fprintf('D_S3, ')
    xend = gps(@Hartmann, u0, D_S3, 0.2, 1e-6);
end