//
//  Menu.swift
//  LittleLemonCapstone
//
//  Created by russell price on 7/22/23.
//


import SwiftUI
import CoreData

struct Menu: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var startersIsEnabled = false
    @State var mainsIsEnabled = false
    @State var dessertsIsEnabled = false
    @State var drinksIsEnabled = false
    
    @State var searchText = ""
    
    @State var loaded = false
    
    @State var isKeyboardVisible = false
    
    init() {
        UITextField.appearance().clearButtonMode = .whileEditing
    }
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    if !isKeyboardVisible {
                        withAnimation() {
                            Hero()
                                .frame(maxHeight: 180)
                                .padding(.vertical)
                        }
                    }
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color.highlightColor1)
                        TextField("Search menu", text: $searchText)
                            .textFieldStyle(.roundedBorder)
                    }
                }
                .padding()
                .background(Color.primaryColor1)
                HStack{
                    Text("ORDER FOR DELIVERY!")
                        .font(.sectionTitle())
                        .foregroundColor(.highlightColor2)
                        .frame(alignment: .leading)
                        .padding(.top)
                        .padding(.trailing)
                    Image("Delivery van")
                        .resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 20, height: 20, alignment: .leading)
                        .padding(.top)
                        .padding(.trailing)
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        Toggle("Starters", isOn: $startersIsEnabled)
                        Toggle("Mains", isOn: $mainsIsEnabled)
                        Toggle("Desserts", isOn: $dessertsIsEnabled)
                        Toggle("Drinks", isOn: $drinksIsEnabled)
                    }
                    .toggleStyle(MyToggleStyle())
                    .padding(.horizontal)
                }
                FetchedObjects(predicate: buildPredicate(),
                               sortDescriptors: buildSortDescriptors()) {
                    (dishes: [Dish]) in
                    List(dishes) { dish in
                        NavigationLink(destination: DetailItem(dish: dish)) {
                            FoodItem(dish: dish)
                        }
                    }
                    .listStyle(.inset)
                }
            }
        }
        .onAppear {
            if !loaded {
                MenuList.getMenuData(viewContext: viewContext)
                loaded = true
            }
        }
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title",
                                 ascending: true,
                                 selector:
                                    #selector(NSString.localizedStandardCompare))]
    }
    
    func buildPredicate() -> NSCompoundPredicate {
        let search = searchText == "" ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        let starters = !startersIsEnabled ? NSPredicate(format: "category != %@", "starters") : NSPredicate(value: true)
        let mains = !mainsIsEnabled ? NSPredicate(format: "category != %@", "mains") : NSPredicate(value: true)
        let desserts = !dessertsIsEnabled ? NSPredicate(format: "category != %@", "desserts") : NSPredicate(value: true)
        let drinks = !drinksIsEnabled ? NSPredicate(format: "category != %@", "drinks") : NSPredicate(value: true)
        
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [search, starters, mains, desserts, drinks])
        return compoundPredicate
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
