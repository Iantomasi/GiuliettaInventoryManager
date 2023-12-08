//
//  GiuliettaInventoryManagementApp.swift
//  GiuliettaInventoryManagement
//
//  Created by ella iantomasi on 2023-11-22.
//

import SwiftUI
import Firebase
import FirebaseFirestore


@main
struct GiuliettaInventoryManagementApp: App {
   
      @StateObject var navigationViewModel = NavigationViewModel()
      @StateObject var inventoryItemViewModel = InventoryItemViewModel()
      @StateObject var orderViewModel = OrderViewModel()
      
      init() {
          FirebaseApp.configure() // configure Firebase when app is started
      }

      var body: some Scene {
          WindowGroup {
              ContentView()
                  // injecting our views into our environment
                  .environmentObject(navigationViewModel)
                  .environmentObject(inventoryItemViewModel)
                  .environmentObject(orderViewModel)
          }
      }
  }
