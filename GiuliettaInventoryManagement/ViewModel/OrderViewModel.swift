//
//  OrderViewModel.swift
//  GiuliettaInventoryManagement
//
//  Created by ella iantomasi on 2023-11-25.
//

import Foundation
import FirebaseFirestore

class OrderViewModel: ObservableObject {
    private let db = Firestore.firestore()

    @Published var orders: [OrderModel] = []

    // Create an order
    func addOrder(order: OrderModel) {
        var ref: DocumentReference? = nil
        ref = db.collection("orders").addDocument(data: [
            "itemNames": order.itemNames,
            "status": order.status.rawValue,
            "date": order.timestamp
        ]) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }

    // Retrieve an order by id
    func getOrder(by id: String) {
        let docRef = db.collection("orders").document(id)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
    }

    // Update an order by id
    func updateOrder(order: OrderModel) {
        let docRef = db.collection("orders").document(order.id)

        docRef.updateData([
            "status": order.status.rawValue
            // Include any other data you want to update
        ]) { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Document successfully updated")
            }
        }
    }

    // Delete an order by id
    func deleteOrder(by id: String) {
        db.collection("orders").document(id).delete() { error in
            if let error = error {
                print("Error removing document: \(error)")
            } else {
                print("Document successfully removed")
            }
        }
    }
}
