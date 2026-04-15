import Foundation

struct MockDataService {
//    Simulates fetching a specific 'page' of results, 20 at a time
    static func getImages(page: Int, perPage: Int = 20 ) async -> [ImageModel] {
//        Simulate a slight network delay (0.5 seconds) so we can see our loading spinners
        try? await Task.sleep(nanoseconds: 500_000_000)
        var newImages: [ImageModel] = []
        let startIndex = (page - 1) * perPage + 1
        let endIndex = page * perPage
        
        for i in startIndex...endIndex
        {
            if let url = URL(string: "https://picsum.photos/3840/2160?random=\(i)") {
                newImages.append(ImageModel(url: url, title: "Capture \(i)"))
            }
        }
        return newImages
    }
}
