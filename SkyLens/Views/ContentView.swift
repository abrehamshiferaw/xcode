import SwiftUI

struct ContentView: View {
//    1. Load our 50 massive image URLs
    
    let images = MockDataService.getHighResImages()
//    2. Define a 3-column grid layout with tiny 2pt spacing for a modern look
    
    let columns = [
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2)
    ]
    var body: some View {
        NavigationView {
            ScrollView {
//                3. LazyVGrid only loads cells when they appear on screen
                LazyVGrid(columns: columns, spacing: 2) {
                    ForEach(images)  {
                        imageModel in ImageCellView(imageModel: imageModel)
                    }
                }
            }
            .navigationTitle("SkyLens Gallery")
        }
    }
}
