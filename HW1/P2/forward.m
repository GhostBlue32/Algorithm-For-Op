function fDif = forward(f, x, h) % forward difference formula
    fDif = (f(x + h) - f(x)) / h;
end


