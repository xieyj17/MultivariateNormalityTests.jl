function snu(data::Matrix{Float64}, dir::Vector{Float64})::Float64
    n, _ = size(data)
    proj = data * dir
    sk = skewness(proj)^2
    #return n*sk/6
    return sk
end

function knu(data::Matrix{Float64}, dir::Vector{Float64})::Float64
    n, _ = size(data)
    proj = data * dir
    ku = abs(kurtosis(proj))
    #return sqrt(n/24)*ku
    return ku
end

function get_cv(n::Int64, p::Int64; B::Int64=100, par::Bool=true)
    sks = Vector{Float64}(undef, B)
    kus = Vector{Float64}(undef, B)
    dummy_dist = MvNormal(zeros(p), Diagonal(ones(p)))
    unit_sphere = FastGenSphere(n^2,p;par=par)
    for i in 1:B
        td = Matrix(rand(dummy_dist, n)')
        sks[i] =  Projection_Pursuit(td, snu;unit_sphere=unit_sphere,par=par).var
        kus[i] =  Projection_Pursuit(td, knu;unit_sphere=unit_sphere,par=par).var
    end
    # if par
    #     @sync for i in 1:B
    #         td = Matrix(rand(dummy_dist, n)')
    #         Threads.@spawn sks[i] =  Projection_Pursuit(td, snu;unit_sphere=unit_sphere,par=false).var
    #         Threads.@spawn kus[i] =  Projection_Pursuit(td, knu;unit_sphere=unit_sphere,par=false).var
    #     end
    # else
    #     for i in 1:B
    #         td = Matrix(rand(dummy_dist, n)')
    #         sks[i] =  Projection_Pursuit(td, snu;unit_sphere=unit_sphere,par=false).var
    #         kus[i] =  Projection_Pursuit(td, knu;unit_sphere=unit_sphere,par=false).var
    #     end
    # end
    return sks, kus
end

function PP_MVNorm(data::Matrix{Float64}, α::Float64=0.05; B::Int64=100, par::Bool=true)
    n, p = size(data)
    unit_sphere = FastGenSphere(n^2,p;par=par)
    # get test statistics
    sk = Projection_Pursuit(data, snu;unit_sphere=unit_sphere,par=par).var * (n/6)
    ku = Projection_Pursuit(data, knu;unit_sphere=unit_sphere,par=par).var * sqrt(n/24)
    # get critical values
    sks, kus = get_cv(n,p; B=100,par=par)
    sks .*= (n/6)
    kus .*= sqrt(n/24)
    sk_quantile = quantile(sks, 1-α)
    ku_quantile = quantile(kus, 1-α)
    pvalue = 1 - (sum(sks .<= sk)/length(sks))*(sum(kus .<= ku)/length(kus))

    return MVNorm_Test_Res("ProjectionPursuit", (sk, ku), (sk_quantile, ku_quantile), pvalue)
end