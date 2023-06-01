function B = search(B, max_dv, EbNodB, BER, Z, MIB, unpunc)
    [mb, nb] = size(B);
    for vn = 1:nb-mb %target VNs        
        %target parity indexes
        n = find(B(1:mb, vn)==-1);
        n = n(n<4); %replace 4 with candidate CNs,...add conditions if necessary
        
        for k = 1:length(n)+max_dv-4 %minus #candidate CNs
            combinations = nchoosek(n, k);
            [i, ~] = size(combinations);
            for j = 1:i
                B(combinations(j, :), vn) = nan;
                %pick cyclic coefficients
                B = get_exponents(B);
                %simulate
                err_rate = simulate(B,Z, EbNodB, MIB, unpunc);
                if err_rate(1) < BER
                    writematrix(B, "BG/B");
                    while err_rate(1) < BER_target %set-up target BER
                        EbNodB = EbNodB - 0.1;
                        err_rate = simulate(B,Z, EbNodB, MIB, unpunc);
                    end
                    BER = err_rate(1);
                end
                B = load("BG/B_previous.txt");
            end
            B = load("BG/B_previous.txt");
        end
        B = load("BG/B.txt");
        writematrix(B, "BG/B_previous");
    end
end

