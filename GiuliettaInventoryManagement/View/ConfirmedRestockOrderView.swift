//
//  ConfirmedRestockOrderView.swift
//  GiuliettaInventoryManagement
//
//  Created by ella iantomasi on 2023-11-25.
//

import SwiftUI

enum OrderStatus: String {
    case SHIPPED = "EN ROUTE" // our default order status upon creation
}

struct ConfirmedRestockOrderView: View {

    @EnvironmentObject var navigationViewModel: NavigationViewModel
    @EnvironmentObject var inventoryItemViewModel: InventoryItemViewModel

    
    // state of current order status
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
                
                Text("Status: \(currentStatus.rawValue)")
                    .font(.headline)
                    .padding()
                
                Spacer(minLength: 30)
                
                // logic to return to the HomePageView
                Button("Return", action: {
                    navigationViewModel.shouldNavigateToCompleteOrderView = false
                })
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Spacer()
                
            }
            .padding()
            .navigationBarBackButtonHidden(true)
            .onDisappear {
                       // Clear the selected items when this view (ConfirmedRestockOrder) disappears
                       inventoryItemViewModel.selectedItems.removeAll()
                   }
        }
    }
