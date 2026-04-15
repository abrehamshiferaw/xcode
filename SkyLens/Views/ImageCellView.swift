import SwiftUI
/*
 Optimized and upgraded the image view cell 
 
 */
struct ImageCellView: View {
    let imageModel: ImageModel
//    we need state to hold the image once it finishes downloading in the background
    
    @State private var loadedImage: UIImage? = nil
    
    var body: some View {
        ZStack {
//            A subtle gray background placeholder while loading
            Color(UIColor.systemGray6)
            if let uiImage = loadedImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
            } else {
//                Show a sleek spinner while the background task is running
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .gray))
            }
        }
//        Force the square grid look
        .frame(minWidth: 0, maxWidth: .infinity)
        .aspectRatio(1, contentMode: .fit)
//        Add a premium 8pt rounded cornerr to each image
        .cornerRadius(8)
        .clipped()
//        .task automatically cancels the download if the user scrolls the cell off-screen!
        .task {
            await fetchImage()
        }
    }
 
    private func fetchImage() async {
        do {
            let image = try await ImageLoaderService.loadAndDownsample(from: imageModel.url)
            await MainActor.run {
//                Wrap the UI update in a SwiftUI animation!
                
                withAnimation(.easeIn(duration: 0.3))
                {
                    self.loadedImage = image
                }
            }
        } catch {
            print("Failed to load optimized image: \(error)")
        }
    }
}


