//
//  InventoryItemModel.swift
//  GiuliettaInventoryManagement
//
//  Created by ella iantomasi on 2023-11-25.
//

import Foundation
struct InventoryItemModel: Identifiable{
    
    let id: UUID = UUID()
    let name: String
    let imageName: String
    
    // initializer to create InventoryItem instance (inventory items are hard coded in the app (in the HomePageView) and only the names are persisted to our OrderModel which is what needs to be conformed to Firestore document data
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
    
}
    
