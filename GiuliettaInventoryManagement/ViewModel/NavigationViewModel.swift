//
//  NavigationViewModel.swift
//  GiuliettaInventoryManagement
//
//  Created by ella iantomasi on 2023-11-25.
//

import Foundation

class NavigationViewModel: ObservableObject {
    
    // booleans that are responsible for navigating back to HomePageView (surprisingly complicated for such a 'simple and intuitive' prorgamming language)
    
    @Published var shouldNavigateToCompleteOrderView: Bool = false
    
    @Published var shouldPopToRootView: Bool = false
}
