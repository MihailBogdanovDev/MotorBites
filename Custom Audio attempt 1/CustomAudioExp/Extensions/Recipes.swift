/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Extension for custom questions.
*/

import Foundation

extension Recipe {
    
    static let allRecipes = [
        Recipe(title: "Lamb Sfiha", offset: 1184, time: "1h30m", budget: 30, description: "aaa", ingridients: ["Example Ing", "Example Ing", "Example Ing", "Example Ing", "Example Ing", "Example Ing", "Example Ing"], imageURL: (URL(string: "https://firebasestorage.googleapis.com/v0/b/motorbites-1a543.appspot.com/o/syrian_flatbread_pizza_22452_16x9.jpg?alt=media&token=d6b95e12-46a8-478e-ad42-160aa150f98c"
                                                                                                                                                                ) ?? URL(string: "www.google.com"))!, steps: CookingStep.allCookingSteps),

        Recipe(title: "Chicken Balmoral", offset: 2350, time: "1h30m", budget: 30, description: "aaa", ingridients: ["Example Ing", "Example Ing", "Example Ing", "Example Ing", "Example Ing", "Example Ing", "Example Ing"],imageURL: (URL(string: "https://firebasestorage.googleapis.com/v0/b/motorbites-1a543.appspot.com/o/images.jpeg?alt=media&token=a09fba55-3adb-4a6c-8730-d5d43213e5d2"
) ?? URL(string: "www.google.com"))!, steps: CookingStep.allCookingSteps),
        Recipe(title: "Salmon en croute", offset: 2896, time: "1h30m", budget: 30, description: "aaa", ingridients: ["Example Ing", "Example Ing", "Example Ing", "Example Ing", "Example Ing", "Example Ing", "Example Ing"],imageURL: (URL(string: "https://firebasestorage.googleapis.com/v0/b/motorbites-1a543.appspot.com/o/HCP2550-800x605.jpg?alt=media&token=dff8865a-81de-4e41-af93-2a5f7370fed5"
) ?? URL(string: "www.google.com"))!, steps: CookingStep.allCookingSteps)
    ]
}
