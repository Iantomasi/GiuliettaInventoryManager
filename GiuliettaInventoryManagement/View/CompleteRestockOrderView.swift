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
    @State private var comments: String = ""
    @State private var email: String = ""
    @State private var isDropdownVisible: Bool = false
    @State private var shouldNavigate = false

    
    
    @EnvironmentObject var inventoryItemViewModel: InventoryItemViewModel
    @EnvironmentObject var orderViewModel: OrderViewModel


    //these will be hard-coded emails of the restaurant owners
    let emailContacts: [String] = ["contact1@example.com", "contact2@example.com", "contact3@example.com"]
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
                    print("hello you in paper airplane button")
                    // Call the placeOrder method when the button is tapped
                    orderViewModel.placeOrder(with: inventoryItemViewModel.selectedItems, comments: comments, email: email) { result in
                        switch result {
                        case .success():
                            // Handle success, like showing a confirmation message and navigating to the next view
                            print("Order placed successfully")
                            self.shouldNavigate = true
                        case .failure(let error):
                            // Handle failure, like showing an error message to the user
                            print("Error placing order: \(error.localizedDescription)")
                        }
                    }
                }) {
                               Image(systemName: "paperplane.circle.fill")
                                   .resizable()
                                   .frame(width: 30, height: 30)
                           }

                           // Hidden navigation link activated by the button
                           NavigationLink(destination: ConfirmedRestockOrderView(), isActive: $shouldNavigate) {
                               EmptyView()
                           }
                           .hidden()
            }
            
            Text("Requested Items")
                .font(.subheadline).bold()
                .padding(.top)
            
            //these will be the items that we clicked + button on in the past view
            ForEach(inventoryItemViewModel.selectedItems) { item in
                   HStack {
                       Text(item.name)
                           .padding(.trailing, 8)
                       Spacer()
                       Button(action: {
                           inventoryItemViewModel.removeItemFromOrder(item: item)
                       }) {
                           Image(systemName: "minus.circle.fill")
                               .foregroundColor(.red)
                       }
                   }
               }
            
            //Simple additional comments field
            TextField("Comments", text: $comments)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                .padding(.top)
            
            //This is where I'm hoping the to implement the email API logic
            TextField("Send to", text: $email, onEditingChanged: { isEditing in
                self.isDropdownVisible = isEditing
                }) //when swift sees we are editing the Send to box, it makes the hard-coded emails list drop down
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
/*
 struct CompleteRestockOrderView_Previews: PreviewProvider {
 static func setupFirebase() {
 if FirebaseApp.app() == nil { // Check if Firebase has already been configured
 FirebaseApp.configure()
 }
 }
 
 static var previews: some View {
 setupFirebase()
 return CompleteRestockOrderView()
 .environmentObject(InventoryItemViewModel())
 .environmentObject(OrderViewModel())
 }
 
 }
 */
