//
//  InventoryItemViewModel.swift
//  GiuliettaInventoryManagement
//
//  Created by ella iantomasi on 2023-11-25.
//

import Foundation
class InventoryItemViewModel: ObservableObject {

    @Published var selectedItems: [InventoryItemModel] = []

    
    // This function will be used to add the items to an order in CompleteRestockOrderView
    func addItemToOrder(item: InventoryItemModel) {
          if !selectedItems.contains(where: { $0.id == item.id }) {
              selectedItems.append(item)
          }
      }

    // This function will be used to remove the items from an order in ConfirmedRestockOrderView
    func removeItemFromOrder(item: InventoryItemModel) {
         selectedItems.removeAll { $0.id == item.id }
     }
 }
