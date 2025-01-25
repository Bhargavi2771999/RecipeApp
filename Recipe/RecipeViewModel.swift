"""
import Foundation

class RecipeViewModel : ObservableObject {

     @Published var recipeArr : [Recipe]



     func loadData() -> [Recipe] {

       if let url = Bundle.main.url(forResource : "Recipes" , withExtension : "json"){
            if let data = try? Data(contentsOf : url){
                let decoder = JSONDecoder()
                if let recipes = try? decoder.decode([Recipe].self , from : Data)
                    self.recipeArr = recipes
                
            }

       }

     }

}
"""
"""

import Foundation

class RecipeService: ObservableObject {
    @Published var recipes: [Recipe] = []
    
    let apiKey = "5c0504b66a1e4147904d45cec0c114b8"  // Replace with your API key
    let apiUrl = "https://api.spoonacular.com/recipes/random?apiKey=\(apiKey)&number=5"

    func fetchRecipes() {
        guard let url = URL(string: apiUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let decodedResponse = try decoder.decode(RecipeResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.recipes = decodedResponse.recipes
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
}

"""
// contains search and sort logic
import Foundation
import SwiftUI

class RecipeService: ObservableObject {
    @Published var recipes: [Recipe] = []  // Original data
    @Published var sortedRecipes: [Recipe] = []  // Sorted and filtered data
    @Published var searchText: String = ""  // Search query
    
    enum SortOrder {
        case neutral
        case ascending
        case descending
    }

    private var sortOrder: SortOrder = .neutral
    
    let apiKey = "YOUR_SPOONACULAR_API_KEY"
    let apiUrl = "https://api.spoonacular.com/recipes/random?apiKey=YOUR_SPOONACULAR_API_KEY&number=5"

    init() {
        fetchRecipes()
    }

    func fetchRecipes() {
        guard let url = URL(string: apiUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let decodedResponse = try decoder.decode(RecipeResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.recipes = decodedResponse.recipes
                        self.applyFilters()  // Apply sorting & searching after fetching
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
    
    // Sort recipes based on user selection
    func changeSortOrder(to order: SortOrder) {
        sortOrder = order
        applyFilters()
    }
    
    // Apply both sorting and searching filters
    func applyFilters() {
        var filteredList = recipes
        
        // Apply search filter
        if !searchText.isEmpty {
            filteredList = filteredList.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
        
        // Apply sorting
        switch sortOrder {
        case .neutral:
            sortedRecipes = filteredList
        case .ascending:
            sortedRecipes = filteredList.sorted { $0.title < $1.title }
        case .descending:
            sortedRecipes = filteredList.sorted { $0.title > $1.title }
        }
    }
}

