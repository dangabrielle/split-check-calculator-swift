//
//  ContentView.swift
//  WeSplit
//
//  Created by Gabrielle Dang on 12/26/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grantTotal = checkAmount + tipValue
        let amountPerPerson = grantTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalAmount: Double {
        _ = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        
        return checkAmount + tipValue
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of People", selection: $numberOfPeople, content: {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    })
//                    .pickerStyle(.navigationLink)
                }
                
                Section ("How much tip do you want to leave?") {
                    Picker("Tip Percentage", selection: $tipPercentage, content: {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    })
//                    .pickerStyle(.segmented)
                    .pickerStyle(.navigationLink)
                }
                
                Section ("Total amount"){
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section ("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
