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
    
    private let db = Firestore.firestore() // reference the Firestore db
    
    @Published var orders: [OrderModel] = [] // OrderModel array that is being observed by our views for changes
    @Published var currentOrder: OrderModel? // OrdeModel that is being currenlty viewed/edited and also being observed by our views for changes
    
    
    
    // create order
    func placeOrder(with items: [InventoryItemModel], comments: String, email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        // WTF is @escaping? (lol) We use @escaping here (and in update and delete methods as well) because we are performing the asynchronous operation of saving our data to Firestore which entails calling our completion handler potentially after the function already returned.
      
        let order = OrderModel(id: UUID().uuidString,
                               itemNames: items.map { $0.name }, // map the inventory items to their names
                               status: .enroute,
                               date: Date(), // setting the current date
                               comments: comments,
                               email: email)
        
        // converting the order to a dictionary for Firestore
        let orderData = order.toDictionary()
        
        // adding the order to Firestore
        db.collection("orders").document(order.id).setData(orderData) { error in
            // this closure is escaping because it will be called after the network request completes, which is after the placeOrder function has already returned

            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    
    // get all orders from db/update orders array
    func fetchOrders() {
        db.collection("orders").addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Error fetching orders: \(error.localizedDescription)")
                return
            }
            
            // map documents to OrderModel objects and update orders array
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
    
    // get order by id
    func fetchOrderDetails(orderId: String) {
        let docRef = db.collection("orders").document(orderId)
        
        // get the order form the db
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
                    self.currentOrder = order // updated currentOrder in app's main thread
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
    // update order
    func updateOrderStatus(orderId: String, newStatus: DeliveryStatus, completion: @escaping (Result<Void, Error>) -> Void) {
        let docRef = db.collection("orders").document(orderId)
        
        // update the status of the document in Firestore
        docRef.updateData([
            "status": newStatus.rawValue
        ]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
                // update the currentOrder status if successful
                if let index = self.orders.firstIndex(where: { $0.id == orderId }) {
                    DispatchQueue.main.async {
                        self.orders[index].status = newStatus
                        self.currentOrder?.status = newStatus
                    }
                }
            }
        }
    }
    
    // delete order
    func deleteOrder(orderId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection("orders").document(orderId).delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
                DispatchQueue.main.async {
                    self.orders.removeAll { $0.id == orderId } // remove order by id from orders array
                }
            }
        }
    }
}
