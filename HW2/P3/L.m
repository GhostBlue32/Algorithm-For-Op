function l = L(x, k, lambda)
    l = (log(k) + (k - 1) * log(x) - k * log(lambda) - (x / lambda).^k);
end