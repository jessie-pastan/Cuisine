//
//  RecipeDetailView.swift
//  Recipe List App
//
//  Created by Jessie P on 4/21/23.
//

import Foundation
import SwiftUI

struct RecipeDetailView: View {
    @State var portionsSelect = 2
    var recipe : Recipe
    var body: some View {
        
        ScrollView {
            
            //MARK: recipe image
            Image(recipe.image)
                .resizable()
                .scaledToFill()
            //MARK: recipe name
            Text(recipe.name)
                .font(.title)
                .bold()
                .padding([.bottom, .top],10)
            //MARK: ingredeient
            
            VStack(alignment: .leading) {
                
                Text("Select Your Serving Size:")
                Picker("", selection: $portionsSelect){
                    Text("2").tag(2)
                    Text("4").tag(4)
                    Text("6").tag(6)
                    Text("8").tag(8)
                    
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 160)
               
                
                Text("Ingredients")
                    .bold()
                    .font(.title2)
                    .padding(.bottom,5)
                    .padding(.top, 10)
                
                ForEach(recipe.ingredients) { item in
                    Text("•" + RecipeModel.getIngredient(ingredient: item, recipeServing: recipe.servings, targetServing: portionsSelect) + " " + item.name)
                    //Text("•\(item.name)")
                    
                }
                Divider()
                //MARK: direction
                Text("Directions")
                    .bold()
                    .font(.title2)
                    .padding(.bottom,5)
                    .padding(.top,10)
                ForEach(0..<recipe.directions.count, id: \.self){ index in
                    Text(String(index+1)+"."+recipe.directions[index])
                        .padding(5)
                }
            }
            .padding([.leading, .trailing], 10)
        }
           
    }
}


struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // create a dummy recipe and pass it into detail view
        //so that we can see in a previews.
        let model = RecipeModel()
        RecipeDetailView(recipe: model.recipes[0])
    }
}
