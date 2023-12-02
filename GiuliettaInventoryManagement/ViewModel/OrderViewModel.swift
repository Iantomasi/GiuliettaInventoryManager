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
    @Published var currentOrder: OrderModel?
    
    
    func placeOrder(with items: [InventoryItemModel], comments: String, email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let order = OrderModel(id: UUID().uuidString,
                               itemNames: items.map { $0.name },
                               status: .enroute,
                               date: Date(),
                               comments: comments,
                               email: email)
        
        // Convert the order to a dictionary for Firestore
        let orderData = order.toDictionary()
        
        // Add order to Firestore
        db.collection("orders").document(order.id).setData(orderData) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func fetchOrders() {
        db.collection("orders").addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error fetching orders: \(error.localizedDescription)")
                return
            }
            
            self.orders = querySnapshot?.documents.compactMap { document in
                let orderData = document.data()
                let order = OrderModel(id: document.documentID,
                                       itemNames: orderData["itemNames"] as? [String] ?? [],
                                       status: DeliveryStatus(rawValue: orderData["status"] as? String ?? "") ?? .enroute,
                                       date: (orderData["timestamp"] as? Timestamp)?.dateValue() ?? Date(),
                                       comments: orderData["comments"] as? String ?? "",
                                       email: orderData["email"] as? String ?? "")
                return order
            } ?? []
        }
    }
    
    func fetchOrderDetails(orderId: String) {
        let docRef = db.collection("orders").document(orderId)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists,
               let orderData = document.data() {
                let order = OrderModel(
                    id: document.documentID,
                    itemNames: orderData["itemNames"] as? [String] ?? [],
                    status: DeliveryStatus(rawValue: orderData["status"] as? String ?? "") ?? .enroute,
                    date: (orderData["timestamp"] as? Timestamp)?.dateValue() ?? Date(),
                    comments: orderData["comments"] as? String ?? "",
                    email: orderData["email"] as? String ?? ""
                )
                DispatchQueue.main.async {
                    self.currentOrder = order
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func updateOrderStatus(orderId: String, newStatus: DeliveryStatus, completion: @escaping (Result<Void, Error>) -> Void) {
        let docRef = db.collection("orders").document(orderId)
        
        // Update the status field of the document
        docRef.updateData([
            "status": newStatus.rawValue
        ]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
                // Update the currentOrder status if the operation was successful
                if let index = self.orders.firstIndex(where: { $0.id == orderId }) {
                    DispatchQueue.main.async {
                        self.orders[index].status = newStatus
                        self.currentOrder?.status = newStatus
                    }
                }
            }
        }
    }
    
    func deleteOrder(orderId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection("orders").document(orderId).delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
                DispatchQueue.main.async {
                    self.orders.removeAll { $0.id == orderId }
                }
            }
        }
    }
}
