//
//  RungeKutta.swift
//  Homework 5 1D Schrodinger Equation Calculator
//
//  Created by Marco Gonzalez on 3/21/24.
//

import SwiftUI

struct ContentView: View {
    @State private var energyInput: String = "1.0"
    @State private var boundaryCondition1: String = "1.0"
    @State private var boundaryCondition2: String = "0.0"
    @State private var maxIterationsInput: String = "1000"
    @State private var psiSolutions: [Double] = []
    @State private var selectedPotential: String = "Square Well" // Default selection

    // Potentials from Professor Terry's Potentials.swift
    
    let potentialTypes = ["Square Well", "Linear Well", "Parabolic Well", "Square + Linear Well", "Square Barrier", "Triangle Barrier", "Coupled Parabolic Well", "Coupled Square Well + Field", "Harmonic Oscillator", "Kronig - Penney", "Variable Kronig - Penney", "KP2-a"]
    
    var body: some View {
        VStack {
            // Picker for selecting potential types
            Picker("Potential Type:", selection: $selectedPotential) {
                ForEach(potentialTypes, id: \.self) { potentialType in
                    Text(potentialType).tag(potentialType)
                }
            }
            .pickerStyle(MenuPickerStyle())
            
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

        // This defines the potential function based on the selected Potential
        // This is a simplified example. Unfinished....
        let potential = Potential(function: { x in
            // Example potential function; replace with your own logic
            switch selectedPotential {
            case "Square Well":
                return 0
           
                
                //We need to add cases to the rest of the listed potentials
                
                
            default:
                return x - x
            }
        })
        
        // This initializes the Schrodinger equation solver with the potential and dx
        let schrodingerSolver = SchrodingerEquationSolver(potential: potential, dx: 0.01)
        
        // This initializes the Runge-Kutta solver
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
