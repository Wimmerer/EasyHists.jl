using EasyHists
using Documenter

DocMeta.setdocmeta!(EasyHists, :DocTestSetup, :(using EasyHists); recursive=true)

makedocs(;
    modules=[EasyHists],
    authors="Raye Kimmerer <kimmerer@mit.edu>",
    repo="https://github.com/Wimmerer/EasyHists.jl/blob/{commit}{path}#{line}",
    sitename="EasyHists.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://Wimmerer.github.io/EasyHists.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/Wimmerer/EasyHists.jl",
    devbranch="main",
)
