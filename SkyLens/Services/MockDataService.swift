import Foundation

struct MockDataService {
//    Generates an array of 50 massive 4k (3840x2160) image payloads
    
    static func getHighResImages() -> [ImageModel] {
        var images: [ImageModel] = []
        for i in 1...50 {
//            The ?random parameter ensures the network fetches a unique image every time, preventing automatic caching
            if let url = URL(string: "https://picsum.photos/3840/2160?random=\(i)") {
                images.append(ImageModel(url:url, title: "Drone Capture \(String(format: "%02d", i))" ))
            }
        }
        
        return images
    }
}
