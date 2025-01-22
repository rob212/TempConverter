//
//  ContentView.swift
//  TempConverter
//
//  Created by Rob McBryde on 21/01/2025.
//

import SwiftUI

enum Unit: String, CaseIterable, Identifiable {
    case celsius = "Celsuis"
    case fahrenheit = "Fahrenheit"
    case kelvin = "Kelvin"
    
    var id: String { self.rawValue}
}

struct ContentView: View {
    @State private var inputUnit: Unit = .celsius
    @State private var inputValue = 23.0
    @State private var outputUnit: Unit = .fahrenheit
    @State private var outputValue = 32.0
    
    @FocusState private var amountIsFocussed: Bool
    
    private var convertedValue: Double {
        var initialValueInCelsius = inputValue
        // convert the inputValue to celsuis
        if inputUnit == .fahrenheit {
            initialValueInCelsius = (inputValue - 32) * (5/9)
        } else if inputUnit == .kelvin {
            initialValueInCelsius = inputValue - 273.15
        }
        
        // read the outputUnit and then convert celsuis to that
        switch outputUnit {
        case .celsius:
            return initialValueInCelsius
        case .fahrenheit:
            return (initialValueInCelsius * 9 / 5 ) + 32
        case .kelvin:
            return initialValueInCelsius + 273.15
        }
    }
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Input unit") {
                    Picker("Input unit", selection: $inputUnit) {
                        ForEach(Unit.allCases) { unit in
                            Text(unit.rawValue).tag(unit)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Amount") {
                    TextField("Value", value: $inputValue, format: .number)
                        .keyboardType(.numberPad)
                        .focused($amountIsFocussed)
                }
                
                Section("Convert to") {
                    Picker("Output unit", selection: $outputUnit) {
                        ForEach(Unit.allCases) { unit in
                            Text(unit.rawValue).tag(unit)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Result") {
                    Text(convertedValue.formatted())
             
                }
                
                
            }
            .navigationTitle("Temp Converter")
            .toolbar {
                if amountIsFocussed {
                    Button("Done") {
                        amountIsFocussed = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
