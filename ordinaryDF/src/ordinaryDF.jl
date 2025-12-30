using DifferentialEquations

g=9.81
l=1.0
m=1.0

function pendulum!(du, u, p, t)
        du[1] = u[1]
        du[2] = (-3 * g / 2 * l) * sin(u[2]) + ((3 / m * l * l) * u[3])
end

u0 = [0.01; 0.0; 0.0]
tspan = (0.0, 10.0)
prob = ODEProblem(pendulum!, u0, tspan)
sol = solve(prob)

sol  = solve(prob, Tsit5(), saveat = 0.01)


# 0> time, 1 -> w(t), 2 -> theta()
using Plots
plot(sol, idxs = (1, 2))

plot(sol, idxs = (0, 1))

plot(sol, idxs = (0, 2))


# ---- Plot θ(t) and ω(t) ----
plt1 = plot(sol.t, [u[1] for u in sol.u],
            xlabel = "Time (s)",
            ylabel = "θ(t) (rad)",
            title = "Pendulum Angle θ(t)",
            legend = false)

plt2 = plot(sol.t, [u[2] for u in sol.u],
            xlabel = "Time (s)",
            ylabel = "ω(t) (rad/s)",
            title = "Pendulum Angular Velocity ω(t)",
            legend = false)

# Show combined plot
plot(plt1, plt2, layout = (2, 1))

# Optionally save to PDF:
savefig("pendulum_theta_omega.pdf")