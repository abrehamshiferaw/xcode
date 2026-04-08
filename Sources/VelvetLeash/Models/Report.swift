import Fluent
import Vapor

final class Report: Model, Content {
    static let schema = "reports"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "pet_name")
    var petName: String
    
    @Field(key: "energy_level")
    var energyLevel: Int
    
    @Field(key: "meal_consumption")
    var mealConsumption: String
    
    // Changed to @OptionalField for macOS 11 compatibility
    @OptionalField(key: "best_friend")
    var bestFriend: String?
    
    // Changed to @OptionalField
    @OptionalField(key: "staff_notes")
    var staffNotes: String?
    
    init() { }
    
    init(id: UUID? = nil, petName: String, energyLevel: Int, mealConsumption: String, bestFriend: String?, staffNotes: String?) {
        self.id = id
        self.petName = petName
        self.energyLevel = energyLevel
        self.mealConsumption = mealConsumption
        self.bestFriend = bestFriend
        self.staffNotes = staffNotes
    }
}
