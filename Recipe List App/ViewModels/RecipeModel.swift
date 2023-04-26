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
    
    static func getIngredient(ingredient: Ingredient, recipeServing: Int, targetServing: Int)->String {
        // create variable to store return value
        var portion = ""
        // num and denum is an optional.
        // then we need to upwrap.  and we gonna give 1 for both value.
        //  using nil coelesing to unwrap and assign value 1
        var numurator = ingredient.num ?? 1
        var denomurator = ingredient.denom ?? 1
        var wholePortion = 0
        
        //Next, check if ingredient.num is not nill so we can continue calculate
        if ingredient.num != nil {
            // calculate ingredient for sigle serving of that recipe by => denom * recipeServing
            denomurator *= recipeServing
            // calculate ingredient for ... serving that user selected by => numerator * targetServing
            numurator *= targetServing
            
            // reduce fraction both demom and num with "greater common divisor"
            //find greater common divisor by using functional rational
            let divisor = Rational.greatestCommonDivisor(numurator, denomurator)
            
            // reduce fraction by divide both value with divisor
            numurator /= divisor
            denomurator /= divisor
            
            //get the whole portion if numurator > demomurator
            if numurator >= denomurator {
                
                // find the whole portion this will give a whole number of portion
                wholePortion = numurator/denomurator
                // find the remain from portion and modify numurator to express the remainder
                numurator = numurator % denomurator
                // assign value to variable portion (Sting)
                portion += String(wholePortion)
            }
            //only in case we have remainder we will assign string for whole portion and remainder
            //check if there is remainder
            if numurator > 0 {
                // check if whole portion is exist ? then add " " between whole portion and remainder. if there is no whole portion will have no space("")
                portion += wholePortion > 0 ? " " : ""
                // after add string whole portion then also assign string for remainder (e.g. 1/2)
                portion += "\(numurator)/\(denomurator)"
            }
        }
            //Add Unit to portion that we have
            //Unit is option we need to unwrap before use (use if var unit becoz we need to modify unit)
            if var unit = ingredient.unit{
                
                //if whole portion > 1 then plauralize unit
                if wholePortion > 1 {
                    if unit.suffix(2) == "ce" {
                        unit += "s"
                    }else if
                        unit.suffix(2) == "ch" || unit.suffix(2) == "sh"{
                        unit += "es"
                    }else if
                        unit.suffix(1) == "f"{
                        unit = (String(unit.dropLast()))
                        unit += "ves"
                    }else{
                        unit += "s"
                    }
                }
                
                //check if num and denom is available for that ingredient or not
                portion += ingredient.num == nil && ingredient.denom == nil ? "" :" "
                
                return portion+unit.capitalized
            }
        return portion
            
    }
}
