module EasyHists
using FLoops, FHist

export easyhist1D, easyhist2D, easyhist3D

function merge(h::Hist1D, x)
    push!(h, x)
    return h
end

function merge(h::Hist1D, x::AbstractVector)
    push!.(Ref(h), x)
    return h
end

function merge(h::Hist1D, h2::Hist1D)
    merge!(h, h2)
    return h
end

function easyhist1D(f, data, bins, t, ex = ThreadedEx(); normalize = true)
    x = f(data)
    @floop ex for _ ∈ 1:(t - 1)
        @reduce(hist = merge(Hist1D(eltype(x); bins), f(data)))
    end
    push!.(Ref(hist), x)
    return normalize ? hist |> LinearAlgebra.normalize : hist
end

function easyhist1D(f, data::Tuple, bins, t, ex = ThreadedEx(); normalize = true)
    x = f(data...)
    @floop ex for _ ∈ 1:(t - 1)
        @reduce(hist = merge(Hist1D(eltype(x); bins), f(data...)))
    end
    merge(hist, x)
    return normalize ? hist |> LinearAlgebra.normalize : hist
end

function easyhist2D(f, data, bins, t, ex = ThreadedEx(); normalize = true)
    x = f(data)
    @floop ex for _ ∈ 1:(t - 1)
        @reduce(hist = merge(Hist2D(eltype(x); bins), f(data)))
    end
    merge(hist, x)
    return normalize ? hist |> LinearAlgebra.normalize : hist
end

function easyhist2D(f, data::Tuple, bins, t, ex = ThreadedEx(); normalize = true)
    x = f(data...)
    @floop ex for _ ∈ 1:(t - 1)
        @reduce(hist = merge(Hist2D(eltype(x); bins), f(data...)))
    end
    merge(hist, x)
    return normalize ? hist |> LinearAlgebra.normalize : hist
end

function easyhist3D(f, data, bins, t, ex = ThreadedEx(); normalize = true)
    x = f(data)
    @floop ex for _ ∈ 1:(t - 1)
        @reduce(hist = merge(Hist3D(eltype(x); bins), f(data)))
    end
    merge(hist, x)
    return normalize ? hist |> LinearAlgebra.normalize : hist
end

function easyhist3D(f, data::Tuple, bins, t, ex = ThreadedEx(); normalize = true)
    x = f(data...)
    @floop ex for _ ∈ 1:(t - 1)
        @reduce(hist = merge(Hist3D(eltype(x); bins), f(data...)))
    end
    merge(hist, x)
    return normalize ? hist |> LinearAlgebra.normalize : hist
end
end
