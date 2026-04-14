import SwiftUI

struct ContentView: View {
    let image = MockDataService.getHighResImages()
    
    let columns = [
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 2) {
                    ForEach(image) {
                        imageModel in
                        ImageCellView(imageModel: imageModel)
                    }
                }
                .padding(.horizontal, 2) // Tiny padding on the screen edges
            }
            .navigationTitle("SkyLens")
            .navigationBarTitleDisplayMode(.inline) // Makes the top bar smaller and cleaner
            
        }
//        Force Dark Mode for the professional "Studio" look
        .preferredColorScheme(.dark)
    }
}
