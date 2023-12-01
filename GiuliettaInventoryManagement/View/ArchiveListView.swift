//
//  ArchiveListView.swift
//  GiuliettaInventoryManagement
//
//  Created by ella iantomasi on 2023-11-25.
//

import SwiftUI

struct ArchiveListView: View {
    
    @Binding var showArchiveListView: Bool
    @State private var showEditOrderStatusView: Bool = false
    @State private var showOrderDetailsView: Bool = false
    
    @State private var selectedOrderId: String = ""

    // Dummy Order struct that we are using in our dummy data lists
    struct DummyOrder {
        let id: Int
        let description: String
        var isDelivered: Bool
    }

    // Sample dummy data
    let enRouteOrders: [DummyOrder] = [
        DummyOrder(id: 0, description: "restock order 1", isDelivered: false),
    ]

    //More dummy data
    let deliveredOrders: [DummyOrder] = [
        DummyOrder(id: 2, description: "restock order 2", isDelivered: true),
        DummyOrder(id: 3, description: "restock order 3", isDelivered: true),
    ]

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

            List { //research
                Section(header: Text("EN ROUTE")) {
                    ForEach(enRouteOrders, id: \.id) { order in
                        orderRow(for: order)
                    }
                }

                Section(header: Text("DELIVERED")) {
                    ForEach(deliveredOrders, id: \.id) { order in
                        orderRow(for: order)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .sheet(isPresented: $showEditOrderStatusView) {
                EditOrderStatusView(restockOrderId: $selectedOrderId)
            }
            .sheet(isPresented: $showOrderDetailsView) {
                OrderDetailsView(restockOrderId: $selectedOrderId)
            }
            Spacer()
        }
        .padding()
    }

    func orderRow(for order: DummyOrder) -> some View {
        HStack {
            Button("delete", action: {
                // implement delete later on
            })
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)

            Button(action: {
                selectedOrderId = "\(order.id)"
                if order.isDelivered {
                    showOrderDetailsView.toggle() // If the order is delivered, show OrderDetailsView
                } else {
                    showEditOrderStatusView.toggle() // Else, show the EditOrderStatusView
                }
            }) {
                Text("edit")
                    .padding()
                    .background(order.isDelivered ? Color.gray : Color.blue) //if it's delivered make the edit button grey, otherwise keep blue
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Text(order.description)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
        }
    }
}
/*
 struct ArchiveListView_Previews: PreviewProvider {
 @State static private var dummyShowArchiveListView = true
 
 static var previews: some View {
 NavigationView {
 ArchiveListView(showArchiveListView: $dummyShowArchiveListView)
 }
 }
 }
 */
