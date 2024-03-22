//
// 1DSchrodingerEquation.swift
// Homework 5 1D Schrodinger Equation Calculator
//
// Created by Marco Gonzalez on 3/21/24.
//

import Foundation

struct Potential {
  var function: (Double) -> Double
}

class SchrodingerEquationSolver {
    var psi: [Double] = []
    var potential: Potential
    let dx: Double
    let mass: Double = 9.10938356e-31 // Mass of an electron in kg
    let hbar: Double = 1.0545718e-34 // Reduced Planck constant in m^2 kg / s
    
    init(potential: Potential, dx: Double = 0.1) {
        self.potential = potential
        self.dx = dx
        
        // Runge-Kutta 1st order (Euler's method)
        func rungeKutta1(y: Double, k: Double) -> Double {
            return y + dx * k
        }
        
        // The differential equation for the Schrödinger equation in 1D.
        func differential(psi: Double, x: Double) -> Double {
            let V = potential.function(x)
            let energy = 1.0
            return (2.0 * mass / (hbar * hbar)) * (V - energy) * psi
        }
        
        func solve(energy: Double, boundaryConditions: [Double], maxIterations: Int) -> [Double] {
            psi = boundaryConditions // Set initial conditions
            
            for i in 0..<maxIterations {
                let x = Double(i) * dx
                let k = differential(psi: psi.last!, x: x)
                let nextPsi = rungeKutta1(y: psi.last!, k: k)
                psi.append(nextPsi)
                
            }
            
            return psi
        }
    }
    

    let examplePotential = Potential(function: { x in
        return 0.5 * x * x
    })
    
    let solver = SchrodingerEquationSolver(potential: examplePotential)
    
    //
    let psiSolutions = solver.solve(energy: 0.75, boundaryConditions: [0.0, 0.0], maxIterations: 5000)
    
    // Output or further process `psiSolutions` as needed
}
