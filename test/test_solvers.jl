include("solvers/unconstrained.jl")
include("solvers/bound-constrained.jl")
include("solvers/unconstrained-nls.jl")

function test_solvers()
  @info "Testing NLP solvers"
  @info "  unconstrained solvers"
  for solver in [trunk, lbfgs, tron]
    @info "    $solver"
    test_unconstrained_solver(solver)
  end
  @info "  bound-constrained solvers"
  for solver in [tron]
    @info "    $solver"
    test_bound_constrained_solver(solver)
  end

  @info "Testing NLS solvers"
  @info "  unconstrained solvers"
  for solver in [(nls; kwargs...) -> trunk(nls, subsolver=:cgls; kwargs...),
                 (nls; kwargs...) -> tron(nls, subsolver=:cgls; kwargs...) ] # cgls due to multiprecision
    @info "    $solver"
    test_unconstrained_nls_solver(solver)
  end
  @info "  bound-constrained solvers"
  for solver in [(nls; kwargs...) -> tron(nls, subsolver=:cgls; kwargs...) ]
    @info "    $solver"
    test_bound_constrained_nls_solver(solver)
  end
end

test_solvers()

@info "Specific solver tests"
include("solvers/trunkls.jl")
