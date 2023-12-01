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
                    if !showArchiveListView {
                        HomePageView(showArchiveListView: $showArchiveListView)
                    }

                    if showArchiveListView {
                        ArchiveListView(showArchiveListView: $showArchiveListView)
                            .environment(\.layoutDirection, .rightToLeft) //making the ArchiveList fade in from the left instead of the right, what we're doing is essentially flipping our page's view
                            .transition(.move(edge: .leading))
                            .animation(.default) //give up on using optimized nav logic, this is super cool anyways
                    }
                }
            }
            .environmentObject(navigationViewModel)
        }
    }

/*
struct ContentView_Previews: PreviewProvider {
        static func setupFirebase() {
              if FirebaseApp.app() == nil { // Check if Firebase has already been configured
                  FirebaseApp.configure()
              }
          }
        static var previews: some View {
            setupFirebase()
            return ContentView()
                .environmentObject(InventoryItemViewModel())
                .environmentObject(OrderViewModel())
        }
    }
 */

