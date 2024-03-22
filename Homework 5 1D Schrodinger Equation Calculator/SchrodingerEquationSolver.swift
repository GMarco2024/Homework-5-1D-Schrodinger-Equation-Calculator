//
//  SchrodingerEquationSolver.swift
//  Homework 5 1D Schrodinger Equation Calculator
//
//  Created by PHYS 440 Marco on 3/22/24.
//

// This defines a quadratic potential function V(x) = x^2.
let potential = Potential(function: { x in x * x })

// This initializes the SchrodingerEquationSolver.swift with the defined potential and a spatial step size of 0.01.
let schrodingerSolver = SchrodingerEquationSolver(potential: potential, dx: 0.01)

let rungeKuttaSolver = RungeKutta()

// Temporarily set Energy to 1.0
let energy: Double = 1.0

// Ok, so, this defines boundary conditions for the wavefunction ψ, starting with ψ(0) = 1.0 and ψ'(0) = 0.0.
let boundaryConditions: [Double] = [1.0, 0.0]

// This temporarily sets the maximum number of iterations for the numerical solution.
let maxIterations = 1000

let psiSolutions = schrodingerSolver.solve(energy: energy, boundaryConditions: boundaryConditions, maxIterations: maxIterations, rungeKutta: rungeKuttaSolver)


