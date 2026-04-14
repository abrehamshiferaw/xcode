import UIKit

// Using an 'actor' guarantees thread-safe access to our cache

actor ImageCache {
//     A shared singleton instance so the whole app uses the same cache
    static let shared = ImageCache()
//    NSCache automatically evicts objects if the iphone runs low on memory!
    
    private let cache = NSCache<NSURL, UIImage>()
    
    private init() {
//        Optional: Set sensible limits so we don't eat all the device's RAM
        
        cache.countLimit = 200 // store upto 200 thumbnails
        
        cache.totalCostLimit = 1024 * 1024 * 100 // Approx 100 MB max
    }
    
    func getImage(for url: URL ) -> UIImage? {
        return cache.object(forKey: url as NSURL )
    }
    
    func insertImage(_ image: UIImage, for url: URL){
        cache.setObject(image, forKey: url as NSURL)
    }
}
