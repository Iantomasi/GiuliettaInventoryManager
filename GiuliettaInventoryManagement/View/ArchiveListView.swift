//
//  ArchiveListView.swift
//  GiuliettaInventoryManagement
//
//  Created by ella iantomasi on 2023-11-25.
//

import SwiftUI


struct ArchiveListView: View {
    @Binding var showArchiveListView: Bool // controlling the visibility of this list view
    @EnvironmentObject var orderViewModel: OrderViewModel
    @State private var selectedOrderId: String?
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 20) {
            HStack {
                Spacer()
                Button(action: {
                    showArchiveListView.toggle() // hide the ArchiveListView and return to HomePageView
                }) {
                    Image(systemName: "arrow.uturn.left")
                        .font(.system(size: 20))
                        .foregroundColor(.blue)
                }
                .padding(.leading)
            }
            
            Text("Archive List")
                .font(.title)
            
            // pushing orders with EN ROUTE status and DELIVERED status to seperate tables
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
                orderViewModel.fetchOrders() // fecthing orderes when the view appears
            }
        }
        .padding()
    }
     
    // function that creates a view for each order row
    func orderRow(for order: OrderModel) -> some View {
        HStack {
            Button(action: {
                // calling deleteOrderFunction in OrderViewModel
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
            .buttonStyle(PlainButtonStyle()) // ensuring that buttons are tappable in List form
            
            
            Button(action: {
                self.selectedOrderId = order.id
            }) {
                HStack {
                    Image(systemName: "pencil")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(order.status == .delivered ? Color.gray : Color.blue) // grey out the 'edit pencil' button on orders with DELIVERED status
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .buttonStyle(PlainButtonStyle())  // ensuring that buttons are tappable in List form
            
            Text(order.id.prefix(3))
                .padding()
                .frame(maxWidth: .infinity, alignment: .trailing)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            
            // navigate to EditOrderStatusView populated with data associated to the order id that is set when we tap on the 'edit penci' button
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
