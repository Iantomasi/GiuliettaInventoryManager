//
//  OrderModel.swift
//  GiuliettaInventoryManagement
//
//  Created by ella iantomasi on 2023-11-25.
//

import Foundation
import FirebaseFirestore

// enum for tracking delivery status, conforming to String and Codable for easy encoding/decoding
enum DeliveryStatus: String, Codable {
    case enroute = "EN ROUTE"
    case delivered = "DELIVERED"
}

// defining our order structure, conforming to Identifiable(use in Swift UI) and Codable (serialization)
struct OrderModel: Identifiable, Codable {
    var id: String
    var itemNames: [String]
    var status: DeliveryStatus
    var date: Date
    var comments: String
    var email: String


    // this is the method that's responsible for formatting our OrderModel data to conform to our Firestore document data
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "itemNames": itemNames,
            "status": status.rawValue,
            "timestamp": Timestamp(date: date),
            "comments": comments,
            "email": email
        ]
    }
}
