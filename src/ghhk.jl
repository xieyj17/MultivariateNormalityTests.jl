function GHHK(data::Matrix{Float64}; α::Float64=0.05, pratio::Float64=0.9)
    M = MultivariateStats.fit(PCA, data'; pratio=pratio)
    pca_proj = data * M.proj
    n, p = size(pca_proj)
    s = 0
    for i in 1:p
        temp_data = pca_proj[:,i]
        tau = skewness(temp_data)
        kappa = kurtosis(temp_data)
        s += (tau^2 /6 + kappa^2 / 24) * n
    end
    temp_chi = Chisq(2*p)
    critical_value = quantile(temp_chi, 1-α)
    pvalue = 1-cdf(temp_chi, s)
    return MVNorm_Test_Res("GHHK",s, critical_value, pvalue)
end