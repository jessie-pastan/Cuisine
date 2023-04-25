//
//  ContentView.swift
//  Recipe List App
//
//  Created by Jessie P on 4/21/23.
//

import SwiftUI

struct RecipeListView: View {
    
    
    @EnvironmentObject var model: RecipeModel
    
    var body: some View {
        
        
      NavigationView{
          
          VStack {
              Text("All Recipe")
                  .font(.largeTitle)
                  .bold()
                  .padding(.top,40)
              ScrollView {
                  LazyVStack(alignment: .leading) {
                      ForEach(model.recipes){r in
                            
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
                      .navigationBarHidden(true)
                      .padding(.leading, 10)
                  }
              }
          }
          
      }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
            .environmentObject(RecipeModel())
    }
}
