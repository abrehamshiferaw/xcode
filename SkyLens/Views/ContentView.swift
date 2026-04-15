import SwiftUI

struct ContentView: View {
//    1. State variables to handle our infinite list
    @State private var images: [ImageModel] = []
    @State private var currentPage = 1
    @State private var isLoading = false
    
    let columns = [
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 2) {
                    ForEach(images){
                        imageModel in ImageCellView(imageModel: imageModel)
//                        2. When a cell appears, check if it's the last one!
                            .onAppear {
                                if imageModel.id == images.last?.id {
                                    loadMoreContent()
                                }
                            }
                    }
                }
                .padding(.horizontal, 2)
//                3. Show a spinner at the very bottom while fetching the next page
                if isLoading {
                    ProgressView()
                        .padding()
                }
            }
            .navigationTitle("SkyLens")
            .navigationBarTitleDisplayMode(.inline)
        }
        .preferredColorScheme(.dark)
//        4. Load the first page when the app launches
        .task {
            await fetchInitialData()
        }
        
    }
//    MARK: - Pagination Logic
    
    private func fetchInitialData ()
    async {
        isLoading = true
        let newImages = await MockDataService.getImages(page: currentPage)
        images.append(contentsOf: newImages)
        isLoading = false
    }
    
    private func loadMoreContent() {
//        Prevent multiple simultaneous network calls
        guard !isLoading else {return }
        isLoading = true
        currentPage += 1
//        Push the background work to a new Task
        Task {
            let newImages = await MockDataService.getImages(page: currentPage)
//            Update the UI back on the Main Thread
            await MainActor.run {
                images.append(contentsOf: newImages)
                isLoading = false
            }
        }
    }
}
