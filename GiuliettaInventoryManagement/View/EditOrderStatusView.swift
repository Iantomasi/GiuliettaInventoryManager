//
//  EditOrderStatusView.swift
//  GiuliettaInventoryManagement
//
//  Created by ella iantomasi on 2023-11-25.
//

import SwiftUI

enum Status: String {
    case enRoute = "EN ROUTE"
    case delivered = "DELIVERED"
}

struct EditOrderStatusView: View {
    var restockOrderId: String // string holding the id of the selected order
    @EnvironmentObject var orderViewModel: OrderViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let order = orderViewModel.currentOrder {
                VStack {
                    Text("Restock Order ID: \(order.id)")
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.bottom, 20)

                    // display the itemNames, status, date, comments and email of the order
                    ForEach(order.itemNames, id: \.self) { itemName in
                        Text(itemName)
                            .padding(.trailing, 8)
                    }

                    Text("Status: \(order.status.rawValue)")
                    Text("Date: \(order.date.formatted())")
                    Text("Comments: \(order.comments)")
                    Text("Email: \(order.email)")

                    Spacer(minLength: 20)

                    // Only show the "DELIVERED" button if the status is not already delivered
                    if order.status != .delivered {
                        Button(action: {
                            // calling the updateOrderStatus function in the OrderViewModel
                            orderViewModel.updateOrderStatus(orderId: order.id, newStatus: .delivered) { result in
                                switch result {
                                case .success():
                                    print("Order status updated to delivered.")
                                    presentationMode.wrappedValue.dismiss()
                                case .failure(let error):
                                    print("Error updating order status: \(error.localizedDescription)")
                                }
                            }
                        }) {
                            Text("DELIVERED")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(10)
                        }
                        .padding()
                    }
                }
            } else {
                Text("Loading order details...")
                    .padding()
            }
        }
        .padding()
        .onAppear {
            // fetch the details for the current order
            orderViewModel.fetchOrderDetails(orderId: restockOrderId)
        }
    }
}
