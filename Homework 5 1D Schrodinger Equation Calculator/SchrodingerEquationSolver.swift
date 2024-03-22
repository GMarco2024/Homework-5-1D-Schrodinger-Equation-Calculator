//
//  SchrodingerEquationSolver.swift
//  Homework 5 1D Schrodinger Equation Calculator
//
//  Created by PHYS 440 Marco on 3/22/24.
//

let potential = Potential(function: { x in x * x })
let schrodingerSolver = SchrodingerEquationSolver(potential: potential, dx: 0.01)
let rungeKuttaSolver = RungeKutta()
let energy: Double = 1.0
let boundaryConditions: [Double] = [1.0, 0.0]
let maxIterations = 1000
let psiSolutions = schrodingerSolver.solve(energy: energy, boundaryConditions: boundaryConditions, maxIterations: maxIterations, rungeKutta: rungeKuttaSolver)

