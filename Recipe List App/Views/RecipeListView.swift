//
//  ContentView.swift
//  Recipe List App
//
//  Created by Jessie P on 4/21/23.
//

import SwiftUI

struct RecipeListView: View {
    
    
    @ObservedObject var model = RecipeModel()
    
    var body: some View {
        
        
      NavigationView{
            List(model.recipes){r in
                
                NavigationLink(
                    destination: RecipeDetailView(recipe: r),
                    label: {
                        //list of recipe
                    HStack(spacing: 20) {
                        Image(r.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width:50, height: 50, alignment: .center)
                            .clipped()
                            .cornerRadius(5)
                        Text(r.name)
                    }
                    
                })
               
            }
            .navigationBarTitle("All Recipe")
          
      }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
