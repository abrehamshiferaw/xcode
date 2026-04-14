import UIKit
import ImageIO

struct ImageLoaderService {
//    Asynchronously downloads and shrinks the image
    
    static func loadAndDownsample(from url: URL) async throws -> UIImage {
//        1. CHECK THE CACHE FIRST
//        We use 'await' because we are communicating with the actor
        if let cachedImage = await ImageCache.shared.getImage(for: url) {
            return cachedImage // Instant return ! No Network or CPU work needed
        }
//        2. Download In Background
        let (data, _) = try await URLSession.shared.data(from: url)
//        3. DOWNSAMPLE
        guard let thumbnail = downsample(data: data, to: CGSize(width: 300, height: 300)) else {
            throw URLError(.cannotDecodeRawData)
        }
//        4. SAVE TO CACHE FOR NEXT TIME
        await ImageCache.shared.insertImage(thumbnail, for: url)
        
        return thumbnail
    }
    
    
//    Core Graphics magic: Downsamples an image directly from its raw data buffer
    
    private static func downsample(data: Data, to pointSize: CGSize) -> UIImage? {
//        Don't decode the full image into memory
        let imageSourceOptions = [kCGImageSourceShouldCache: false ] as CFDictionary
        
        guard let imageSource = CGImageSourceCreateWithData( data as CFData , imageSourceOptions ) else {
            return nil
        }
//        We will calculate the target pixel size
        let scale = UIScreen.main.scale
        let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scale
        let downsampleOptions = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels
        ] as CFDictionary
        
//        Create the tiny thumbnail
        
        guard let downsampledCGImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions ) else {
            return nil
        }
        
        return UIImage(cgImage: downsampledCGImage)
    }
}
