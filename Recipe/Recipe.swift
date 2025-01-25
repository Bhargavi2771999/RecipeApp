import Foundation


// for our json data
"""
struct Recipe : Identifiable , Codable{
    let id : UUID
    let title : String
    let image : String
    let ingredients : [String]
    let instructions : String
}

"""

struct RecipeResponse : Codable {
    let recipeArr : [Recipe]
}

struct Recipe : Identifiable , Codable {
    let id : instructions
    let title : String
    let image : String
    let instructions : String?
    let extendedIngredients : [Ingredient]
}

struct Ingredient : Codable {
    let original : String
}

