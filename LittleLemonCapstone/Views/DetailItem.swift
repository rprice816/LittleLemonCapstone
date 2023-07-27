//
//  DetailItem.swift
//  LittleLemonCapstone
//
//  Created by russell price on 7/22/23.
//


import SwiftUI

struct DetailItem: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    let dish: Dish
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.highlightColor1)
                .ignoresSafeArea()
            ScrollView {
                AsyncImage(url: URL(string: dish.image ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 350, height: 250)
                .border(Color.primaryColor1, width: 5)
                .cornerRadius(10)
                .padding()
                    Text(dish.title ?? "")
                        .font(.subTitleFont())
                        .foregroundColor(.primaryColor1)
                        .bold()
                    Spacer(minLength: 20)
                VStack{
                    Text(dish.descriptionDish ?? "")
                        .font(.regularText())
                    Spacer(minLength: 10)
                    Text("$" + (dish.price ?? ""))
                        .font(.highlightText())
                        .foregroundColor(.primaryColor1)
                        .monospaced()
                    Spacer()
                }
                .padding()
                .frame(width: 350)
                .background(Color.primaryColor1.opacity(0.2))
                .cornerRadius(10)

            }
            .frame(maxWidth: .infinity)
            .ignoresSafeArea()
        }
    }
}

struct DetailItem_Previews: PreviewProvider {
    static var previews: some View {
        DetailItem(dish: PersistenceController.oneDish())
    }
}
