//
//  ContentView.swift
//  GiuliettaInventoryManagement
//
//  Created by ella iantomasi on 2023-11-22.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct ContentView: View {
    @StateObject private var navigationViewModel = NavigationViewModel()
        @State private var showArchiveListView: Bool = false
        
        var body: some View {
            NavigationView {
                ZStack {
                    // show the HomePageView when the ArchiveListView is not being shown
                    if !showArchiveListView {
                        HomePageView(showArchiveListView: $showArchiveListView)
                    }

                    // show ArchiveListView when needed
                    if showArchiveListView {
                        ArchiveListView(showArchiveListView: $showArchiveListView)
                            .environment(\.layoutDirection, .rightToLeft) //making the ArchiveList fade in from the left instead of the right, what we're doing is essentially flipping our page's view
                            .transition(.move(edge: .leading))
                            .animation(.default) //give up on using optimized nav logic, this is super cool anyways
                    }
                }
            }
            .environmentObject(navigationViewModel) // provide the navigation view model to the views
        }
    }

