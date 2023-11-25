//
//  OrderModel.swift
//  GiuliettaInventoryManagement
//
//  Created by ella iantomasi on 2023-11-25.
//

import Foundation

enum DeliveryStatus: String{
    case enroute = "EN ROUTE"
    case delivered = "DELIVERED"
}

struct OrderModel: Identifiable{
    let id: Int
    var items: [InventoryItemModel] // array of the hard-coded items we have selected
    var status: DeliveryStatus // some logic for order status has already been implemented in the views, however I will be refactoring and updating accordingly
    let date: Date
}
