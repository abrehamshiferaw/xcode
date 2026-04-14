import SwiftUI

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
//            Call our new background service
            let image = try await ImageLoaderService.loadAndDownsample(from: imageModel.url)
//            Update the UI on the main thread
            await MainActor.run {
                self.loadedImage = image
            }
        } catch {
            print("Failed to load optimized image: \(error)")
        }
    }
}


