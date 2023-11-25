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
    var id: String // Use String to match Firestore document IDs
    var itemNames: [String] // Just store the names of the items
    var status: DeliveryStatus
    var date: Date

    // Add an initializer that can be used to initialize from Firestore document
    init(id: String = UUID().uuidString, itemNames: [String], status: DeliveryStatus = .enroute, date: Date = Date()) {
        self.id = id
        self.itemNames = itemNames
        self.status = status
        self.date = date
    }
    
    // Add a computed property to convert Date to Timestamp for Firestore
    var timestamp: Timestamp {
        return Timestamp(date: date)
    }
    
    // Add an initializer to initialize from Firestore document data
    init?(documentID: String, dictionary: [String: Any]) {
        guard let statusRawValue = dictionary["status"] as? String,
              let status = DeliveryStatus(rawValue: statusRawValue),
              let timestamp = dictionary["date"] as? Timestamp,
              let itemNames = dictionary["itemNames"] as? [String] else { return nil }
        
        self.id = documentID
        self.status = status
        self.date = timestamp.dateValue()
        self.itemNames = itemNames
    }
}
