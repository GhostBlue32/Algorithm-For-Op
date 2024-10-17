function [pk, pl] = L_grad(x, k, lambda)
    pl = -k / lambda + k * (x / lambda).^k / lambda;
    pk = 1 / k + log(x) - log(lambda) - (x / lambda).^k .* log(x / lambda);
end