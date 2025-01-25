import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe  // The recipe passed from the list
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(recipe.title)
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)

                AsyncImage(url: URL(string: recipe.image))
                    .frame(width: 300, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.vertical)
                
                Text("Ingredients")
                    .font(.title2)
                    .bold()
                    .padding(.bottom, 5)

                ForEach(recipe.extendedIngredients, id: \.id) { ingredient in
                    Text("\(ingredient.amount) \(ingredient.unit) \(ingredient.name)")
                        .padding(.bottom, 2)
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Recipe Detail")
    }
}
