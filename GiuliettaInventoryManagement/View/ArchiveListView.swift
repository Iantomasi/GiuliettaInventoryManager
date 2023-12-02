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
            Button("del", action: {
                // implement delete functionality here
            })
            .padding()
            .frame(maxWidth: .infinity) // This will allow the button to expand
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            Button(action: {
                self.selectedOrderId = order.id // Set the selectedOrderId when "edit" is tapped
            }) {
                Text("edit")
                    .padding()
                    .frame(maxWidth: .infinity) // This will allow the button to expand
            }
            .background(order.status == .delivered ? Color.gray : Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            Text(order.id.prefix(3))
                .padding()
                .frame(maxWidth: .infinity, alignment: .trailing) // This will allow the text to expand
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            
            NavigationLink("", destination: EditOrderStatusView(restockOrderId: order.id), isActive: Binding(
                get: { self.selectedOrderId == order.id },
                set: { isActive in
                    if !isActive {
                        self.selectedOrderId = nil
                    }
                }
            )).hidden()
        }
    }
}

struct ArchiveListView_Previews: PreviewProvider {
    static var previews: some View {
        ArchiveListView(showArchiveListView: .constant(true))
            .environmentObject(OrderViewModel())
    }
}
