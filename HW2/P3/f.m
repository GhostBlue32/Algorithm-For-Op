function wb = f(x, k, lambda)
    wb = (k / lambda) * (x / lambda).^(k - 1) .* exp(-(x / lambda).^k);
end