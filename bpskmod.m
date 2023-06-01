function rx = bpskmod(cw, EsNodB )
    bpskmod = comm.BPSKModulator;
    bpskdem = comm.BPSKDemodulator("DecisionMethod", "Log-likelihood ratio");
    mod_cw = bpskmod(cw);
    chann = comm.AWGNChannel("NoiseMethod","Signal to noise ratio (Es/No)","EsNo",EsNodB);
    noisy_sig = chann(mod_cw);
    rx = bpskdem(noisy_sig);
end

