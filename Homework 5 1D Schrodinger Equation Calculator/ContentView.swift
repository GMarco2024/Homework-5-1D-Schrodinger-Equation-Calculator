//
//  ContentView.swift
//  Homework 5 1D Schrodinger Equation Calculator
//
//  Created by PHYS 440 Marco on 3/8/24.
//

import SwiftUI

struct ContentView: View {
    @State private var energyInput: String = "1.0"
    @State private var boundaryCondition1: String = "1.0"
    @State private var boundaryCondition2: String = "0.0"
    @State private var maxIterationsInput: String = "1000"
    @State private var psiSolutions: [Double] = []

    var body: some View {
        VStack {
      
            HStack {
                Text("Energy:")
                TextField("Enter energy", text: $energyInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
            }

        
            HStack {
                Text("Boundary Condition 1:")
                TextField("Value", text: $boundaryCondition1)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
               
            }

   
            HStack {
                Text("Boundary Condition 2:")
                TextField("Value", text: $boundaryCondition2)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                   
            }

       
            HStack {
                Text("Max Iterations:")
                TextField("Value", text: $maxIterationsInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                   
            }

            Button("Solve") {
                solveSchrodingerEquation()
            }
            .padding()
            

            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(psiSolutions.indices, id: \.self) { index in
                        Text("ψ[\(index)]: \(psiSolutions[index])")
                    }
                }
            }
        }
        .padding()
    }
    
    // Method to solve the Schrodinger Equation
    func solveSchrodingerEquation() {
        guard let energy = Double(energyInput),
              let bc1 = Double(boundaryCondition1),
              let bc2 = Double(boundaryCondition2),
              let maxIterations = Int(maxIterationsInput) else {
            print("Invalid input")
            return
        }

        // Define the potential function
        let potential = Potential(function: { x in x * x })
        
        // Initializes the Schrodinger equation solver with the potential and dx
        let schrodingerSolver = SchrodingerEquationSolver(potential: potential, dx: 0.01)
        
        // Initializes the Runge-Kutta solver
        let rungeKuttaSolver = RungeKutta()

        // Solves the equation and update psiSolutions
        psiSolutions = schrodingerSolver.solve(energy: energy,
                                               boundaryConditions: [bc1, bc2],
                                               maxIterations: maxIterations,
                                               rungeKutta: rungeKuttaSolver)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
