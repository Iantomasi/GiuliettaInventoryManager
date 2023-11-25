//
//  NavigationViewModel.swift
//  GiuliettaInventoryManagement
//
//  Created by ella iantomasi on 2023-11-25.
//

import Foundation

class NavigationViewModel: ObservableObject {
    
    @Published var navigateToHome: Bool = false

    @Published var shouldPopToRootView: Bool = false
}
