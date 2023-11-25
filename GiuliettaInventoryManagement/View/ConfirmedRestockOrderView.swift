//
//  ConfirmedRestockOrderView.swift
//  GiuliettaInventoryManagement
//
//  Created by ella iantomasi on 2023-11-25.
//

import SwiftUI

enum OrderStatus: String {
    case SHIPPED = "EN ROUTE"
}

struct ConfirmedRestockOrderView: View {

    @EnvironmentObject var navigationViewModel: NavigationViewModel
        
    @State private var currentStatus: OrderStatus = .SHIPPED
        
        var body: some View {
            VStack(alignment: .center, spacing: 15) {
                
                Spacer(minLength: 20)
                
                Image("truck")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                
                Text("Confirmed Restock Order")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                
                Text("Status: \(currentStatus.rawValue)") //research
                    .font(.headline)
                    .padding()
                
                Spacer(minLength: 30)
                
                Button("Return", action: {
                    navigationViewModel.navigateToHome = false
                })
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Spacer()
                
            }
            .padding()
            .navigationBarBackButtonHidden(true) // Hide the back button because we aren't modifying anything after an email is sent
        }
    }
