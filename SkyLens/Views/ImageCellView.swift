import SwiftUI

struct ImageCellView: View {
    let imageModel: ImageModel
    var body: some View {
//        🚨 INTENTIONALLY BAD CODE:
//        We are forcing the UI to wait for this function to finish before it renders.
        let uiImage = loadHeavyImageSynchronously(from: imageModel.url)
        Image(uiImage: uiImage).resizable()
            .aspectRatio(contentMode: .fill)
        
//        force it into a nice square for the grid
            .frame(minWidth: 0, maxWidth: .infinity)
            .aspectRatio(1, contentMode: .fit)
            .clipped()
    }
    
//    The Culprit: This function halts the main thread
    private func loadHeavyImageSynchronously(from url: URL ) -> UIImage {
        do {
//            Data(contentsOf:) is synchronous call .
//            The app literally freezes here while it downloads 5-10 Megabytes.
            let data = try Data(contentsOf: url )
            if let image = UIImage(data: data) {
                return image
            }
        } catch{
            print("Failed to load image \(error)")
        }
//        Return a blank image if it fails
        return UIImage()
    }
}
