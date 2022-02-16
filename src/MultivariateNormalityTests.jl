module MultivariateNormalityTests

using  MultivariateStats
using HypothesisTests
using Distributions
using ProjectionPursuit
# Write your package code here.

struct MVNorm_Test_Res
    test_type::String
    test_statistic::Union{Float64, Tuple{Float64, Float64}}
    critical_value::Union{Float64, Tuple{Float64, Float64}}
    pvalue::Float64
end

include("ghhk.jl")
include("maxjb.jl")
include("ppnorm.jl")



export GHHK, MaxJB, 
    MVNorm_Test_Res

end
