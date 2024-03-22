//
//  RungeKutta.swift
//  Homework 5 1D Schrodinger Equation Calculator
//
//  Created by Marco Gonzalez on 3/21/24.
//

import Foundation

// This defines a class for performing numerical integration using the Runge-Kutta method.
class RungeKutta {
    func solve(yCurrent: Double, k: Double, dx: Double) -> Double {
        return yCurrent + dx * k
    }
}

