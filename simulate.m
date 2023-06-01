function err_rate = simulate(B,Z, EbNodB, MIB, unpunc)
%     Z = 79;
    [mb, nb] = size(B);
    punc = nb*Z-length(unpunc);
    kb = nb-mb;
    k = kb*Z;
    R = kb/(nb-2); %remove -2 if the code is not punctured
    
    H = to_bin(B, Z);
    H = sparse(H);

    enc = comm.LDPCEncoder("ParityCheckMatrix",H);
    dec = comm.LDPCDecoder("ParityCheckMatrix", H, ...
        "IterationTerminationCondition","Parity check satisfied", ...
        "MaximumIterationCount", 50);

    EsNodB = 10*log10(1*R)+EbNodB;
    iters = ; %set max #iterations

    err_cnt = 0;
    for iter = 1:iters
        
        msg = randi([0 1], 1, k);
        cwd = enc(msg');
        
        rx = bpskmod(cwd(unpunc), EsNodB);
        llr = [zeros(punc, 1); rx];
        
        msg_cap = dec(llr)';           
        
        [~,err] = biterr(msg(MIB), msg_cap(MIB));
        err_cnt = err_cnt + err;      
    end
    err_rate = err_cnt/iter;
    err_rate = round(err_rate, 2, "significant"); %filter some uncessary changes
end

