//
//  OrderModel.swift
//  GiuliettaInventoryManagement
//
//  Created by ella iantomasi on 2023-11-25.
//

import Foundation
import FirebaseFirestore // Import Firestore

enum DeliveryStatus: String, Codable {
    case enroute = "EN ROUTE"
    case delivered = "DELIVERED"
}

struct OrderModel: Identifiable, Codable {
    var id: String
    var itemNames: [String]
    var status: DeliveryStatus
    var date: Date
    var comments: String
    var email: String

    // No CodingKeys or init(from:) needed if you're not using Firestore's Codable support

    // Converts the `OrderModel` to a dictionary suitable for Firestore.
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
