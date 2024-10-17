function Z = gradh(A,W,H)

  Z = W'*(W*H-A);

end
