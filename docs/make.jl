using MultivariateNormalityTests
using Documenter

DocMeta.setdocmeta!(MultivariateNormalityTests, :DocTestSetup, :(using MultivariateNormalityTests); recursive=true)

makedocs(;
    modules=[MultivariateNormalityTests],
    authors="Yijun Xie",
    repo="https://github.com/xieyj17/MultivariateNormalityTests.jl/blob/{commit}{path}#{line}",
    sitename="MultivariateNormalityTests.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://xieyj17.github.io/MultivariateNormalityTests.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/xieyj17/MultivariateNormalityTests.jl",
    devbranch="main",
)
