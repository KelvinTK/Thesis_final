function H = to_bin(B, Z)
    [m, n] = size(B);
    H = zeros(m*Z, n*Z);
    for i = 1:m
        for j = 1:n
            p = B(i, j);
            q = eye(Z);
            if p == -1
                H(i*Z-Z+1:i*Z, j*Z-Z+1:j*Z) = zeros(Z);
            elseif p == 0
                H(i*Z-Z+1:i*Z, j*Z-Z+1:j*Z) = q;
            else
                H(i*Z-Z+1:i*Z, j*Z-Z+1:j*Z) = [q(:, Z-p+1:end) q(:, 1:Z-p)];
            end
        end
    end
end

