//
//  InventoryItemViewModel.swift
//  GiuliettaInventoryManagement
//
//  Created by ella iantomasi on 2023-11-25.
//

import Foundation
class InventoryItemViewModel: ObservableObject {

    @Published var selectedItems: [InventoryItemModel] = []

    // this function adds our hard-coded items to the OrderModel in the CompleteRestockOrderView
    func addItemToOrder(item: InventoryItemModel) {
          if !selectedItems.contains(where: { $0.id == item.id }) {
              selectedItems.append(item)
          }
      }

    // this functionm removes accidentally clicked items from the OrderModel in the CompleteRestockOrderView
    func removeItemFromOrder(item: InventoryItemModel) {
         selectedItems.removeAll { $0.id == item.id }
     }
 }
