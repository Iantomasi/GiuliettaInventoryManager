//
//  InventoryItemViewModel.swift
//  GiuliettaInventoryManagement
//
//  Created by ella iantomasi on 2023-11-25.
//

import Foundation
class InventoryItemViewModel: ObservableObject {

    @Published var selectedItems: [InventoryItemModel] = []

    // Get item by id
    func getItem(by id: Int){
        // Logic to get item by id
    }

    // This function will be used to add the items to an order in CompleteRestockOrderView
    func addItemToOrder(item: InventoryItemModel) {
        // Logic for adding item to order
    }

    // This function will be used to remove the items from an order in ConfirmedRestockOrderView
    func removeItemFromOrder(item: InventoryItemModel) {
        // Logic for removing item from order
    }
}
