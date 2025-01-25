"""
import SwiftUI

struct RecipeMainView : View {
     
    @StateObject var viewModel : ViewModel()

     var body : some View {
         
           List(viewModel.recipeArr){ recipe in

             HStack{
                  
                  Text(recipe.image)
                  Text(recipe.title)

             }


           }
           .padding()


     }


}
"""

"""
// displaying api data
import SwiftUI

struct ContentView: View {
    @StateObject var recipeService = RecipeService()
    
    var body: some View {
        NavigationView {
            List(recipeService.recipes) { recipe in
                VStack(alignment: .leading) {
                    AsyncImage(url: URL(string: recipe.image)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 200)
                    .cornerRadius(10)

                    Text(recipe.title)
                        .font(.headline)
                    
                    if let instructions = recipe.instructions {
                        Text(instructions)
                            .font(.subheadline)
                            .lineLimit(2)
                    }
                }
            }
            .navigationTitle("Recipes")
            .onAppear {
                recipeService.fetchRecipes()
            }
        }
    }
}

"""
"""
// with search bar
import SwiftUI

struct RecipeListView: View {
    @StateObject private var recipeService = RecipeService()
    @State private var searchText = ""  // Search query input
    
    var filteredRecipes: [Recipe] {
        if searchText.isEmpty {
            return recipeService.recipes
        } else {
            return recipeService.recipes.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        VStack {
            TextField("Search Recipes", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Fetch Recipes") {
                recipeService.fetchRecipes()  // Fetch new recipes
            }
            .padding()
            
            List(filteredRecipes, id: \.id) { recipe in
                VStack(alignment: .leading) {
                    Text(recipe.title).font(.headline)
                    AsyncImage(url: URL(string: recipe.image))  // Display recipe image
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
        }
        .padding()
    }
}

"""
"""
// with navigation to DetailView
import SwiftUI

struct RecipeListView: View {
    @StateObject private var recipeService = RecipeService()
    @State private var searchText = ""  // Search query input
    
    var filteredRecipes: [Recipe] {
        if searchText.isEmpty {
            return recipeService.recipes
        } else {
            return recipeService.recipes.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search Recipes", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Fetch Recipes") {
                    recipeService.fetchRecipes()  // Fetch new recipes
                }
                .padding()
                
                List(filteredRecipes, id: \.id) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                        VStack(alignment: .leading) {
                            Text(recipe.title).font(.headline)
                            AsyncImage(url: URL(string: recipe.image))
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }
            }
            .padding()
        }
    }
}

"""
// contains search bar and sort buttons
import SwiftUI

struct RecipeListView: View {
    @StateObject private var recipeService = RecipeService()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search Recipes", text: $recipeService.searchText, onEditingChanged: { _ in
                    recipeService.applyFilters()
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                
                // Sorting Buttons
                HStack {
                    Button("Original") { recipeService.changeSortOrder(to: .neutral) }
                        .padding()
                    Button("Sort A-Z") { recipeService.changeSortOrder(to: .ascending) }
                        .padding()
                    Button("Sort Z-A") { recipeService.changeSortOrder(to: .descending) }
                        .padding()
                }
                
                Button("Fetch Recipes") {
                    recipeService.fetchRecipes()
                }
                .padding()
                
                List(recipeService.sortedRecipes, id: \.id) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                        VStack(alignment: .leading) {
                            Text(recipe.title).font(.headline)
                            AsyncImage(url: URL(string: recipe.image))
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }
            }
            .padding()
        }
    }
}



