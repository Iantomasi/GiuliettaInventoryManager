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
    @Binding var restockOrderId: String
    @State private var orderStatus: Status = .enRoute // Default status which should be EN ROUTE
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss() //Close button functionality (dismisses the view)
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

            //This will of course be the items we passed into the order originally, the same list in the CompleteRestockOrderView. I worry this will be fairly complex but maybe we are overthinking it
            ForEach(0..<5) { _ in
                HStack {
                    Text("item")
                        .padding(.trailing, 8)
                    Spacer()
                }
            }
            Spacer(minLength: 20)

            HStack {
                Spacer()
                Button(action: {
                    self.orderStatus = .delivered    //set the default status from EN ROUTE to Delivered, which will in turn push the data under the DELIVERED table in the ArchiveListView
                }) {
                    Text("DELIVERED")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
                Spacer()
            }
            .padding()
        }
        .padding()
    }
}

/*
 struct EditOrderStatusView_Previews: PreviewProvider {
 static var previews: some View {
 EditOrderStatusView(restockOrderId: .constant("restockOrderId"))
 }
 }
 */
