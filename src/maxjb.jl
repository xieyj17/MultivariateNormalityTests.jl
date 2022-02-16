function MaxJB(data::Matrix{Float64}; α::Float64=0.05, pratio::Float64=0.9)
    M = MultivariateStats.fit(PCA, data'; pratio=pratio)
    pca_proj = data * M.proj
    n, p = size(pca_proj)
    s = zeros(p)
    for i in 1:p
        s[i] = JarqueBeraTest(pca_proj[:,i]).JB
    end
    test_stat = maximum(s)
    temp_chi = Chisq(2)
    critical_value = quantile(temp_chi, 1-α^p)
    pvalue = 1-(cdf(temp_chi, test_stat))^p
    return MVNorm_Test_Res("Max-Jqrque-Bera",test_stat, critical_value, pvalue)
end