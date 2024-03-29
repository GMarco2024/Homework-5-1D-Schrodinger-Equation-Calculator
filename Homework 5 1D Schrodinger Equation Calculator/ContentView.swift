//
//  RungeKutta.swift
//  Homework 5 1D Schrodinger Equation Calculator
//
//  Created by Marco Gonzalez on 3/21/24.
//

import SwiftUI

struct ContentView: View {
    @State private var energyInput: String = "1.0"
    @State private var xMinString: String = "0.0"
    @State private var xMaxString: String = "10.0"
    @State private var xMin = 0.0
    @State private var xMax = 10.0
    @State private var maxIterationsInput: String = "1000"
    @State private var psiSolutions: [Double] = []
    @State private var selectedPotential: String = "Square Well"
    @State private var xStepString: String = "0.0001"
    @State private var mypotential: [Double] = []
    @State private var xStep = 0.0
    
    // @State private var count:
   // @State private var dataPoint
   // @State private var contentArray
    

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
                Text("X-Min:")
                TextField("Value", text: $xMinString)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
               
            }
   
            HStack {
                Text("X-Max:")
                TextField("Value", text: $xMaxString)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                   
            }
            
            HStack {
                Text("X-Step:")
                TextField("Value", text: $xStepString)
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
            
              let maxIterations = Int(maxIterationsInput) else {
            print("Invalid input")
            return
        }

        // This defines the potential function based on the selected Potential
        // Unfinished....I need to add the rest of the potentials.
        let potential = Potential(function: { x in
            
            switch selectedPotential {
                
            case "Square Well":
                xStep = Double(xStepString)!
                xMax = Double(xMaxString)!
                xMin = Double(xMinString)!
                
                mypotential.append(100000.0)
                
                for i in stride(from: xMin+xStep, through: xMax-xStep, by: xStep) {
                    
                    //        potential.oneDPotentialXArray.append(i)
                   
                    
                    mypotential.append(0.0)
                
                    
                    //             count = potential.oneDPotentialXArray.count
                    //            dataPoint = [.X: potential.oneDPotentialXArray[count-1], .Y: potential.oneDPotentialYArray[count-1]]
                    //             contentArray.append(dataPoint)
                }
                
                mypotential.append(100000.0)
                
                return 0.0
                
            default:
                return x - x
            }
        })
        
        // This initializes the Schrodinger equation solver with the potential and dx
        let schrodingerSolver = SchrodingerEquationSolver(potential: potential, dx: 0.001)
        
        // This initializes the Runge-Kutta solver
        let rungeKuttaSolver = RungeKutta()

        // Solves the equation and update psiSolutions
        psiSolutions = schrodingerSolver.solve(energy: energy,
                                               boundaryConditions: [xMin, xMax],
                                               maxIterations: maxIterations,
                                               rungeKutta: rungeKuttaSolver)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
