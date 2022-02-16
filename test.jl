
# using PkgTemplates

# t = Template(; 
#     user="xieyj17",
#     dir=".",
#     authors="Yijun Xie",
#     julia=v"1.0",
#     plugins=[
#         Git(; manifest=true, ssh=true),
#         GitHubActions(;
#             destination="CI.yml",
#             linux=true,
#             osx=false,
#             windows=false,
#             x64=true,
#             x86=false,
#             coverage=true,
#             extra_versions=["1.0", "1.7", "nightly"],
#         ),
#         Codecov(),
#         Documenter{GitHubActions}(),
#         Develop(),
#     ],
# )

# t("MultivariateNormalityTests")



using Random
using Distributions
using LinearAlgebra
#using PosDefManifold
#using PDMats


N=100
td = Exponential(1);
tds = rand(td, N);
n=30
#diag = rand(Uniform(6,10), n)
#Q, _ = qr(randn(n, n)); 
D = Diagonal(n:-1:1); 
#cov_mat = Q*D*Q';

#cov_mat = Float64.(cov_mat)

d = MvNormal(zeros(n), D);

dat = rand(d, N);


ndat = hcat(dat', tds);

GHHK(ndat)
MaxJB(ndat)
PP_MVNorm(ndat)