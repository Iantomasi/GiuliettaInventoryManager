//
//  ArchiveListView.swift
//  GiuliettaInventoryManagement
//
//  Created by ella iantomasi on 2023-11-25.
//

import SwiftUI

struct ArchiveListView: View {
    @Binding var showArchiveListView: Bool
    @EnvironmentObject var orderViewModel: OrderViewModel
    @State private var selectedOrderId: String?
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 20) {
            HStack {
                Spacer()
                Button(action: {
                    showArchiveListView.toggle()
                }) {
                    Image(systemName: "arrow.uturn.left")
                        .font(.system(size: 20))
                        .foregroundColor(.blue)
                }
                .padding(.leading)
            }
            
            Text("Archive List")
                .font(.title)
            
            List {
                Section(header: Text("EN ROUTE")) {
                    ForEach(orderViewModel.orders.filter { $0.status == .enroute }) { order in
                        orderRow(for: order)
                    }
                }
                
                Section(header: Text("DELIVERED")) {
                    ForEach(orderViewModel.orders.filter { $0.status == .delivered }) { order in
                        orderRow(for: order)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .onAppear {
                orderViewModel.fetchOrders()
            }
        }
        .padding()
    }
    
    func orderRow(for order: OrderModel) -> some View {
        HStack {
            Button(action: {
                // This button's action should only be called when this button is tapped
                orderViewModel.deleteOrder(orderId: order.id) { result in
                    switch result {
                    case .success():
                        print("Successfully deleted order.")
                    case .failure(let error):
                        print("Error deleting order: \(error.localizedDescription)")
                    }
                }
            }) {
                HStack {
                    Image(systemName: "trash")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .buttonStyle(PlainButtonStyle()) // Prevent List from hijacking touch events
            
            Button(action: {
                // This button's action should only be called when this button is tapped
                self.selectedOrderId = order.id
            }) {
                HStack {
                    Image(systemName: "pencil")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(order.status == .delivered ? Color.gray : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .buttonStyle(PlainButtonStyle()) // Prevent List from hijacking touch events
            
            Text(order.id.prefix(3))
                .padding()
                .frame(maxWidth: .infinity, alignment: .trailing)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            
            NavigationLink(destination: EditOrderStatusView(restockOrderId: order.id), isActive: Binding(
                get: { self.selectedOrderId == order.id },
                set: { isActive in
                    if !isActive {
                        self.selectedOrderId = nil
                    }
                }
            )) {
                EmptyView()
            }
            .hidden()
        }
    }
}
