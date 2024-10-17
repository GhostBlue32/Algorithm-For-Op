function Z = gradw(A,W,H)
    
  Z = (W*H-A)*H';

end
