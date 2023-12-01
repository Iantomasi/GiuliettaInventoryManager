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
                Button("delete", action: {
                    // implement delete functionality here
                })
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)

                Button(action: {
                    // implement edit functionality here
                }) {
                    Text("edit")
                        .padding()
                        .background(order.status == .delivered ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                VStack(alignment: .leading) {
                    Text(order.itemNames.joined(separator: ", ")) // Assuming you want to show item names
                    Text("Status: \(order.status.rawValue)")
                    Text("Date: \(order.date.formatted())") // Format the date as you wish
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            }
        }
    }

    struct ArchiveListView_Previews: PreviewProvider {
        static var previews: some View {
            ArchiveListView(showArchiveListView: .constant(true))
                .environmentObject(OrderViewModel())
        }
    }
