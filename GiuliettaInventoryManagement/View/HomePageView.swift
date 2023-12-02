//
//  HomePageView.swift
//  GiuliettaInventoryManagement
//
//  Created by ella iantomasi on 2023-11-25.
//

import SwiftUI

struct HomePageView: View {
    
    //booleans to use in views logic
    @Binding var showArchiveListView: Bool
    @State private var isFloorExpanded: Bool = false
    @State private var isBarExpanded: Bool = false
    @State private var isKitchenExpanded: Bool = false
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    @EnvironmentObject var inventoryItemViewModel: InventoryItemViewModel
    @EnvironmentObject var orderViewModel: OrderViewModel
    
    
    
    let floorItems = [
    InventoryItemModel(name: "Table setups", imageName: "table_setup"),
    InventoryItemModel(name: "Cleaning supplies", imageName: "cleaning_supplies"),
    InventoryItemModel(name: "Dishwashing supplies", imageName: "dishwashing_supplies"),
    InventoryItemModel(name: "Washroom supplies", imageName: "washroom_supplies")
    
    ]
    
    let barItems = [
    
        InventoryItemModel(name: "Glassware", imageName: "glassware"),
        InventoryItemModel(name: "Wine bottles", imageName: "wine_bottles"),
        InventoryItemModel(name: "Beer keg", imageName: "beer_keg"),
        InventoryItemModel(name: "Cocktail shakers", imageName: "cocktail_shakers"),
        InventoryItemModel(name: "Sodas", imageName: "sodas"),
        InventoryItemModel(name: "Juices", imageName: "juices"),
        InventoryItemModel(name: "Lemons, Limes & Oranges", imageName: "lemons_limes_oranges"),
        InventoryItemModel(name: "Ice buckets", imageName: "ice_buckets"),
        InventoryItemModel(name: "Coffee supplies", imageName: "coffee_supplies")
    ]
    
    let kitchenItems = [InventoryItemModel(name: "Culinary cutlery", imageName: "culinary_cutlery"),
                        InventoryItemModel(name: "Pots & pans", imageName: "pots_pans"),
                        InventoryItemModel(name: "Pizza dishes", imageName: "pizza_dishes"),
                        InventoryItemModel(name: "Pasta dishes", imageName: "pasta_dishes"),
                        InventoryItemModel(name: "Dessert dishes", imageName: "dessert_dishes"),
                        InventoryItemModel(name: "Meats", imageName: "meats"),
                        InventoryItemModel(name: "Cheeses", imageName: "cheeses"),
                        InventoryItemModel(name: "Vegetables", imageName: "vegetables"),
                        InventoryItemModel(name: "Eggs", imageName: "eggs"),
                        InventoryItemModel(name: "Dough", imageName: "dough"),
                        InventoryItemModel(name: "Pasta", imageName: "pasta"),
                        InventoryItemModel(name: "Oils & Spices", imageName: "oils_spices"),
                        InventoryItemModel(name: "Fryer oil & basket", imageName: "deep_fryer"),
                        InventoryItemModel(name: "Fruits", imageName: "fruits"),
                        InventoryItemModel(name: "Nutella", imageName: "nutella")
    ]
    
    var body: some View {
         ZStack {
             Image("chef-list")
                 .resizable()
                 .scaledToFit()
                 .frame(height: 400)
                 .padding(.top, 250) // Adjust to ensure the image is positioned correctly
             
             VStack(alignment: .center, spacing: 10) {
                 Text("Giulietta Pizzeria Inventory")
                     .font(.largeTitle).bold()
                     .foregroundColor(.black)
                     .multilineTextAlignment(.center)

                 ScrollView {
                     VStack {
                         CustomDisclosureGroup(isExpanded: $isFloorExpanded, title: "Floor", items: floorItems, inventoryItemViewModel: inventoryItemViewModel)
                         CustomDisclosureGroup(isExpanded: $isBarExpanded, title: "Bar", items: barItems, inventoryItemViewModel: inventoryItemViewModel)
                         CustomDisclosureGroup(isExpanded: $isKitchenExpanded, title: "Kitchen", items: kitchenItems, inventoryItemViewModel: inventoryItemViewModel)
                                             }
                                         }
                                         Spacer()
                HStack {
                    Button(action: {
                        showArchiveListView.toggle()
                    }) {
                        Text("Orders") //Orders bottom left brings us to the ArchiveListView (animation from left to right was SO tedious
                    }
                    
                    Spacer()
                    NavigationLink(destination: CompleteRestockOrderView(), isActive: $navigationViewModel.navigateToHome) {
                        Text("Next") //Bringing us to the CompleteRestockOrderView which I'm hoping to link to the Email API with some help (could possible use a built-in iOS functionality accoording to a classmate?)
                    }
                }
            }
            .padding()
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarBackButtonHidden(true) //hide back-bar button on home page
            .onReceive(navigationViewModel.$shouldPopToRootView) { shouldPop in
                if shouldPop {
                    navigationViewModel.shouldPopToRootView = false
                    
                } //this logic I found on the internet, essentially what renders switching back to the HomePageView from the ConfirmedReStockOrderView
            }
        }
    }
}
struct CustomDisclosureGroup: View {
    @Binding var isExpanded: Bool
    let title: String
    let items: [InventoryItemModel]
    var inventoryItemViewModel: InventoryItemViewModel // Add this line

    var body: some View {
        DisclosureGroup(
            isExpanded: $isExpanded,
            content: {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        ForEach(items) { item in
                            InventoryItemView(item: item, inventoryItemViewModel: inventoryItemViewModel) // Modify this line
                        }
                    }
                }
                .frame(maxHeight: 200) // Set a maximum height for the scrollable content
            },
            label: {
                Text(title)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading) // Ensure full width
            }
        )
        .padding(.horizontal, 0) // Match padding with the content
        .accentColor(.white)
        .background(Color.black.opacity(0.6))
        .cornerRadius(10)
    }
}

struct InventoryItemView: View {
    let item: InventoryItemModel
    var inventoryItemViewModel: InventoryItemViewModel // Add this line


    var body: some View {
        HStack {
            Image(item.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
            Text(item.name)
                .foregroundColor(.white) // Make the text white
            Spacer()
            Button(action: {
                inventoryItemViewModel.addItemToOrder(item: item)
            }) {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.white)
            }
        }
        .padding(.vertical, 4)
        .padding(.horizontal)
        .background(Color.black.opacity(0.6))

    }
}

/*
struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
            HomePageView(showArchiveListView: .constant(false))
                .environmentObject(NavigationViewModel())
                .environmentObject(InventoryItemViewModel())
        }
    }
 */

//removed file commit

