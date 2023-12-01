//
//  OrderViewModel.swift
//  GiuliettaInventoryManagement
//
//  Created by ella iantomasi on 2023-11-25.
//

import Foundation
import Firebase
import FirebaseFirestore

class OrderViewModel: ObservableObject {
    
    private let db = Firestore.firestore()

    @Published var orders: [OrderModel] = []

    func placeOrder(with items: [InventoryItemModel], comments: String, email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let order = OrderModel(id: UUID().uuidString, // This will generate a new UUID string
                               itemNames: items.map { $0.name },
                               status: .enroute,
                               date: Date())
        
        // Convert order to dictionary for Firestore
        let orderData: [String: Any] = [
            "id": order.id,
            "itemNames": order.itemNames,
            "status": order.status.rawValue,
            "date": Timestamp(date: order.date),
            "comments": comments,
            "email": email
        ]
        
        // Add order to Firestore
        Firestore.firestore().collection("orders").document(order.id).setData(orderData) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}

    
