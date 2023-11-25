//
//  OrderViewModel.swift
//  GiuliettaInventoryManagement
//
//  Created by ella iantomasi on 2023-11-25.
//

import Foundation

class OrderViewModel: ObservableObject {
    @Published var orders: [OrderModel] = []

    // Create an order
    func addOrder(order: OrderModel) {
       //create order logic
    }

    // Retrieve an order by id
    func getOrder(by id: Int){
     //get order by id logic
    }

    // Update an order by id
    func updateOrder(order: OrderModel) {
       //update order status logic (from EN ROUTE to DELIVERED)
    }

    // Delete an order id
    func deleteOrder(by id: Int) {
        //delete order by id logic
    }
}
