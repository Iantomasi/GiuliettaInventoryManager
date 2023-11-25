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
    
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
    
}
    
