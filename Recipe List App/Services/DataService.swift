//
//  DataService.swift
//  Recipe List App
//
//  Created by Jessie P on 4/21/23.
//

import Foundation

class DataService {
    static func getlocalData() -> [Recipe] {
        //find path of json file form bundle
        let path = Bundle.main.path(forResource: "recipes", ofType: "json")
        // check if file was found
        guard path != nil else{
            return [Recipe]()
            }
        // create url object
        let url = URL(fileURLWithPath: path ?? "none")
        
        do{
            // create data object
             let data = try Data(contentsOf: url)
            
            // parsing Json object
            let decoder = JSONDecoder()
            
            do{
                let recipeObject = try decoder.decode([Recipe].self, from: data)
                
                // add id to each object
                for item in recipeObject{
                    item.id = UUID()
                    
                    for item in item.ingredients{
                        item.id = UUID()
                    }
                }
                //update jsonObject in view model
                return recipeObject
            }
            catch{
                print ("cannot parsing jsonObject")
            }
        }
        catch{
            print ("cannot create data object")
        }
        return [Recipe]()
    }
   
}
