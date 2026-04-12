import Foundation

struct ImageModel: Identifiable {
    
    let id = UUID()
    let url: URL
    let title: String
}
