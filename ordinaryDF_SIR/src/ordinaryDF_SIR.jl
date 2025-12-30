using DifferentialEquations

gamma_rate = 0.1
beta_rate = 0.3
N = 1000
I0 = 1
R0 = 0
S0 = N - I0 - R0

tspan = (0,160)

function SIR(du, u, p, t)
    du[1] = -1 * beta_rate* u[1] * u[2]
    du[2] = (beta_rate * u[1] * u[2] / N ) - (gamma_rate * u[2])
    du[3] = gamma_rate * u[2]
end

u0 = [S0;I0;R0]
prob = ODEProblem(SIR, u0, tspan)

sol  = solve(prob, Tsit5(), saveat = 1)


# ---- Plot θ(t) and ω(t) ----
plt1 = plot(sol.t, [u[1] for u in sol.u],
            xlabel = "Time (s)",
            ylabel = "S(t) (rad)",
            title = "S(t)",
            legend = false)

plt2 = plot(sol.t, [u[2] for u in sol.u],
            xlabel = "Time (s)",
            ylabel = "I(t)",
            title = "I(t)",
            legend = false)

plt3 = plot(sol.t, [u[3] for u in sol.u],
            xlabel = "Time (s)",
            ylabel = "R(t)",
            title = "R(t)",
            legend = false)

# Show combined plot
plot(plt1, plt2, plt3, layout = (3, 1))

# Optionally save to PDF:
savefig("SIR_infectious_disease_time.pdf")