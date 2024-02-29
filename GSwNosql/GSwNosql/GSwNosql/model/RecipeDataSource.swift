import RealmSwift

final class RecipeDataSource {
    let realm: Realm
    var objects: Results <Recipe> {
        get {
            return realm.objects(Recipe.self)
        }
    }
    
    init() {
        do {
            let conf = Realm.Configuration()
            self.realm = try Realm(configuration: conf)
        } catch {
            fatalError("ERROR: Could not access init object: \(error)")
        }
    }
    
    func create (name: String, instructions: String, url: String) {
        do {
            try realm.write {
                realm.add(Recipe(name: name, instructions: instructions, url: url))
            }
        } catch {
            print("ERROR: Could not access create object: \(error)")
        }
    }
    
    func read (property: Recipe.Type) -> Results <Recipe> {
        return realm.objects(property)
    }
    
    func update (recipe: Recipe, newName: String = "", newInstructions: String = "", newUrl: String = "") {
        do {
            try realm.write {
                recipe.name = !newName.isEmpty ? newName : recipe.name
                recipe.instructions = !newInstructions.isEmpty ? newInstructions : recipe.instructions
                recipe.url = !newUrl.isEmpty ? newUrl : recipe.url
                
                realm.add(recipe, update: .modified)
            }
        } catch {
            print("ERROR: Could not access update object: \(error)")
        }
    }
    
    func delete (recipe: Recipe) {
        do {
            try realm.write {
                realm.delete(recipe)
            }
        } catch {
            print("ERROR: Could not access delete object: \(error)")
        }
    }
    
    func find(name: String) -> Results <Recipe> {
        return realm.objects(Recipe.self).filter("name == %@", name)
    }
}
