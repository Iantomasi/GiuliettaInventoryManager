//
//  CompleteRestockOrderView.swift
//  GiuliettaInventoryManagement
//
//  Created by ella iantomasi on 2023-11-25.
//

import SwiftUI

struct CompleteRestockOrderView: View {
    @State private var comments: String = ""
    @State private var email: String = ""
    @State private var isDropdownVisible: Bool = false
    
    
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
                
                NavigationLink(destination: ConfirmedRestockOrderView()) {
                    Image(systemName: "paperplane.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
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

struct CompleteRestockOrderView_Previews: PreviewProvider {
    static var previews: some View {
        CompleteRestockOrderView()
    }
}
