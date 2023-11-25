//
//  OrderDetailsView.swift
//  GiuliettaInventoryManagement
//
//  Created by ella iantomasi on 2023-11-25.
//

import SwiftUI

struct OrderDetailsView: View {
    @Binding var restockOrderId: String
    @State private var orderStatus: Status = .enRoute // Default status EN ROUTE
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss() //Same logic as in Edit
                }) {
                    Text("Close")
                        .font(.system(size: 20))
                        .foregroundColor(.blue)
                }
                .padding(.trailing)
            }
            
            TextField("Restock Order ID", text: $restockOrderId)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.bottom, 20)
            
            //Same data as in Edit OrderStatusView & CompleteRestockOrderView
            ForEach(0..<5) { _ in
                HStack {
                    Text("item")
                        .padding(.trailing, 8)
                    Spacer()
                }
            }
            
            Spacer(minLength: 20)
        }
        .padding()
    }
}

 
 struct OrderDetailsView_Previews: PreviewProvider {
     static var previews: some View {
 OrderDetailsView(restockOrderId: .constant("restockOrderId"))
     }
 }
 
 
