//
//  GiuliettaInventoryManagementApp.swift
//  GiuliettaInventoryManagement
//
//  Created by ella iantomasi on 2023-11-22.
//

import SwiftUI

@main
struct GiuliettaInventoryManagementApp: App {
    var navigationViewModel = NavigationViewModel()
       var inventoryItemViewModel = InventoryItemViewModel()

       var body: some Scene {
           WindowGroup {
               ContentView()
                   // Inject your view models into the environment
                   .environmentObject(navigationViewModel)
                   .environmentObject(inventoryItemViewModel)
           }
       }
   }
