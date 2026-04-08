import Fluent

struct CreateReport: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("reports")
            .id()
            .field("pet_name", .string, .required)
            .field("energy_level", .int, .required)
            .field("meal_consumption", .string, .required)
            .field("best_friend", .string)
            .field("staff_notes", .string)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("reports").delete()
    }
}
