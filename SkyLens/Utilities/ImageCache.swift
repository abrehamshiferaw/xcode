import UIKit

actor ImageCache {
    static let shared = ImageCache()
    
//    Tier 1: In-Memory RAM Cache
    private let ramCache = NSCache<NSURL, UIImage>()
    
// Tier 2: The physical hard drive directory path
    private let fileManager = FileManager.default
    private var diskCacheDirectory: URL? {
        fileManager.urls (for: .cachesDirectory, in: .userDomainMask).first
    }
    
    private init() {
        ramCache.countLimit = 200
        ramCache.totalCostLimit = 1024 * 1024 * 100
    }
    
//    MARK: - Retrieve
    func getImage(for url: URL ) -> UIImage? {
//        1. Check RAM Cache First (Instant)
        if let memoryImage = ramCache.object(forKey: url as NSURL)
        {
            return memoryImage
        }
//        2. Check Disk Cache Second ( A few milliseconds )
        if let fileURL = getFilePath(for: url ),
           let diskData = try? Data(contentsOf: fileURL),
           let diskImage = UIImage(data: diskData){
//            It was on the hard drive! put it back in RAM so it is instant next time.
            ramCache.setObject(diskImage, forKey: url as NSURL)
            return diskImage
        }
//        3. Not found anywhere, needs network download
        return nil
    }
//    MARK: - Save
    func insertImage(_ image: UIImage, for url: URL) {
//        1. Save to RAM Cache
        ramCache.setObject(image, forKey: url as NSURL)
        
//        2. Save to Disk Cache ( Background file writing )
        if let fileURL = getFilePath(for: url),
           let jpegData = image.jpegData(compressionQuality: 0.8 ) {
//            0.8 saves space!
            try? jpegData.write(to: fileURL)
        }
    }
//    MARK: - Helper
    // Converts a URL like "https://picsum.photos" into a safe file name like "https%3A%2F%2Fpicsum%2Ephotos"
      private func getFilePath(for url: URL) -> URL? {
          guard let safeFileName = url.absoluteString.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
          else {
              return nil
          }
          return diskCacheDirectory?.appendingPathComponent(safeFileName)
      }
      }
