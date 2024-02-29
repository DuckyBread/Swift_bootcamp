import RealmSwift

final class Recipe: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var name: String
    @Persisted var instructions: String
    @Persisted var url: String
    
    override init() {
        super.init()
    }
    
    init (name: String, instructions: String, url: String) {
        self.name = name
        self.instructions = instructions
        self.url = url
        super.init()
    }
}
