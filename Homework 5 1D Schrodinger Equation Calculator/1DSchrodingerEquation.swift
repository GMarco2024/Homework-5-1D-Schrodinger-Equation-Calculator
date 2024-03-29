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

// Solves the Schrödinger equation for a given potential.

class SchrodingerEquationSolver {
    var psi: [Double] = []
    var psiPrime: [Double] = []
    var potential: Potential
    let dx: Double
    let mass: Double = 9.10938356e-31
    let hbar: Double = 1.0545718e-34

    init(potential: Potential, dx: Double = 0.1) {
        self.potential = potential
        self.dx = dx
    }

    
    func differential(psi: Double, x: Double) -> Double {
        let V = potential.function(x)
        let energy = 1.0 // Replace with a mechanism to dynamically set energy

        return (2.0 * mass / (hbar * hbar)) * (V - energy) * psi
    }

    // Solves the Schrödinger equation.
    func solve(energy: Double, boundaryConditions: [Double], maxIterations: Int, rungeKutta: RungeKutta) -> [Double] {
        psi = boundaryConditions
        psiPrime = [Double](repeating: 0.0, count: boundaryConditions.count)

        for i in 0..<maxIterations {
            let x = Double(i) * dx
    

            // Calculate Psi_i
            let psi_i = psi[i - 1] + dx * psiPrime[i - 1]
            
            // Calculate Psi'_i
            let psiPrime_i = psiPrime[i - 1] + dx * (2 * mass / (hbar * hbar)) * (potential.function(x - dx) - energy) * psi[i - 1]

            // Calculate Delta X
            let deltaX = (psiPrime_i - psiPrime[i - 1]) / ((2 * mass / (hbar * hbar)) * (potential.function(x - dx) - energy) * psi[i - 1])

            // Calculate V(x_i-1)
            let V = (psiPrime_i - psiPrime[i - 1]) / (deltaX * (2 * mass / (hbar * hbar)) * psi[i - 1]) + energy

            // Calculate Energy (E). Not sure if needed. Just added this just in case.
            let energy = V - (psiPrime_i - psiPrime[i - 1]) / (deltaX * (2 * mass / (hbar * hbar)) * psi[i - 1])

            psi.append(psi_i)
            psiPrime.append(psiPrime_i)
        }

        return psi
    }
}
    
    

