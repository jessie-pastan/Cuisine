//
//  RecipeModel.swift
//  Recipe List App
//
//  Created by Jessie P on 4/21/23.
//

import Foundation

class RecipeModel: ObservableObject {
    
    @Published var recipes =  [Recipe]()
    
    init(){
        // parse local jsonfile
        let recipesData = DataService.getlocalData()
        
        // set the recipes property
        self.recipes = recipesData
        
    }
    
    
    
    
}
