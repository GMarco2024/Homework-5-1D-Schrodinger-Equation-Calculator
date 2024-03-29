//
// 1DSchrodingerEquation.swift
// Homework 5 1D Schrodinger Equation Calculator
//
// Created by Marco Gonzalez on 3/21/24.
//

import Foundation

// Defines a structure to represent a potential energy function in a quantum system.
struct Potential {
    
    // Holds a function that calculates the potential energy at a given position (x).
    var function: (Double) -> Double
}

// Solves the Schrödinger equation for a given potential.
class SchrodingerEquationSolver {
    
    // Array to store the wavefunction values (ψ) at discrete points.
    var psi: [Double] = []
    
    // The potential energy function affecting the quantum particle.
    var potential: Potential
    
    // The step size for discretization in the spatial domain.
    let dx: Double
    
    // Mass of an electron in kilograms.
    let mass: Double = 9.10938356e-31
    
    // Reduced Planck's constant.
    let hbar: Double = 1.0545718e-34
    
    // Initializer for setting up the solver with a specific potential and step size.
    init(potential: Potential, dx: Double = 0.1) {
        self.potential = potential
        self.dx = dx
        
    }
    
    // Function to compute the rate of change of the wavefunction ψ based on the differential form of the Schrödinger equation.
    
    func differential(psi: Double, x: Double) -> Double {
        
        // This calculates the potential energy at position x.
        let V = potential.function(x)
        
        let energy = 1.0
        
        // Returns the rate of change of ψ using the differential equation derived from the Schrödinger equation.
        return (2.0 * mass / (hbar * hbar)) * (V - energy) * psi
    }
    
    // Solves the Schrödinger equation numerically using an instance of RungeKutta for integration.
    func solve(energy: Double, boundaryConditions: [Double], maxIterations: Int, rungeKutta: RungeKutta) -> [Double] {
       
        // This sets the initial wavefunction values based on boundary conditions.
        psi = boundaryConditions
       
        // Iteratively calculate the wavefunction values using the Runge-Kutta method.
        for i in 0..<maxIterations {
            
            // Calculate the current position based on iteration count and step size.
            
            let x = Double(i) * dx
            
            // Calculate the rate of change (k) at the current position.
            let k = differential(psi: psi.last!, x: x)
            
            // This computes the next ψ value.
            let nextPsi = rungeKutta.solve(yCurrent: psi.last!, k: k, dx: dx)

            psi.append(nextPsi)
        }

        return psi
    }
}


