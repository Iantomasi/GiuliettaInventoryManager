//
//  CompleteRestockOrderView.swift
//  GiuliettaInventoryManagement
//
//  Created by ella iantomasi on 2023-11-25.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct CompleteRestockOrderView: View {
    
    // state variables being used to store user input and view control
    @State private var comments: String = ""
    @State private var email: String = ""
    @State private var isDropdownVisible: Bool = false
    @State private var shouldNavigate = false

    
    // environment objects declared to access shared data and logic
    @EnvironmentObject var inventoryItemViewModel: InventoryItemViewModel
    @EnvironmentObject var orderViewModel: OrderViewModel


    // hard-coded emails of the restaurant owners
    let emailContacts: [String] = ["ericgiulietta@gmail.com", "coreygiulietta@icloud.com"]
    var filteredContacts: [String] {
          return emailContacts
      }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Complete Restock Order")
                    .font(.headline)
                
                Spacer()
                
                Button(action: {
                    // call the placeOrder method when button is tapped
                    orderViewModel.placeOrder(with: inventoryItemViewModel.selectedItems, comments: comments, email: email) { result in
                        switch result {
                        case .success():
                            print("Order placed successfully")
                            self.shouldNavigate = true
                        case .failure(let error):
                            print("Error placing order: \(error.localizedDescription)")
                        }
                    }
                }) {
                               Image(systemName: "paperplane.circle.fill")
                                   .resizable()
                                   .frame(width: 30, height: 30)
                           }

                           // hidden navigation link activated by the button
                           NavigationLink(destination: ConfirmedRestockOrderView(), isActive: $shouldNavigate) {
                               EmptyView()
                           }
                           .hidden()
            }
            
            Text("Requested Items")
                .font(.subheadline).bold()
                .padding(.top)
            
            // these will be the items that we clicked + button on in the past view
            ForEach(inventoryItemViewModel.selectedItems) { item in
                   HStack {
                       Text(item.name)
                           .padding(.trailing, 8)
                       Spacer()
                       Button(action: {
                           // calling removeItemFromOrder method in InventoryItemViewModel when - button is tapped
                           inventoryItemViewModel.removeItemFromOrder(item: item)
                       }) {
                           Image(systemName: "minus.circle.fill")
                               .foregroundColor(.red)
                       }
                   }
               }
            
            // simple additional comments text box
            TextField("Comments", text: $comments)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                .padding(.top)
            
            
            TextField("Send to", text: $email, onEditingChanged: { isEditing in
                self.isDropdownVisible = isEditing
                }) // when swift sees we are editing the Send to box, it makes the hard-coded emails list drop down
            .padding()
            .overlay(RoundedRectangle(cornerRadius:5).stroke(Color.gray, lineWidth: 1))
            .padding(.top)
            
              if isDropdownVisible {
                List(filteredContacts, id: \.self) { contact in
                    Button(action: {
                            self.email = contact
                            self.isDropdownVisible = false
                    }) {
                        Text(contact).frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .frame(height: 150)
                .background(RoundedRectangle(cornerRadius: 5).fill(Color.white))
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                .listStyle(PlainListStyle())
        }
                        
        Spacer()
            
            HStack {
                Spacer()
                Image("delivery")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 265, height: 265)
                    .padding([.bottom, .trailing])
                
            }
        }
        .padding()
    }
}
