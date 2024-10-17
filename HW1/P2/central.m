function cDif = central(f, x, h) % central difference formula
    cDif = (f(x + h) - f(x - h)) / (2 * h);
end
