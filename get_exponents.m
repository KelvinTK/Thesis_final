function B = get_exponents(B)
    TCC = load("TCC/Tcc.txt");
    [~, n] = size(TCC);
    [m, ~] = size(B);
    for i = 1:m
        for j = 1:n
            if isnan(B(i, j))
                B(i, j) = TCC(i, j);
            end
        end
    end
end

