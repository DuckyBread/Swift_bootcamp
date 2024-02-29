import Foundation
import RealmSwift

var db = RecipeDataSource()

var dbObj = db.read(property: Recipe.self)

print("""
    
----------TASK_1----------
Add data to DB
--------------------------

db.create(name: "Borsh'", instructions: "Add water and some vegtables", url: "http://borsh-v-edu.ru")
db.create(name: "Plov", instructions: "Сначала берем укропу", url: "http://plov-v-edu.ru")
db.create(name: "Shashlyk'", instructions: "На палки мясо и в костер", url: "http://shashlyk-v-edu.ru")
db.create(name: "Cake", instructions: "мука сахар соль яйцо", url: "http://cake-v-edu.ru")
db.create(name: "Pasta", instructions: "Кидаем лапшу в кипяток", url: "http://pasta-v-edu.ru")

""")

db.create(name: "Borsh'", instructions: "Add water and some vegtables", url: "http://borsh-v-edu.ru")
db.create(name: "Plov", instructions: "Сначала берем укропу", url: "http://plov-v-edu.ru")
db.create(name: "Shashlyk'", instructions: "На палки мясо и в костер", url: "http://shashlyk-v-edu.ru")
db.create(name: "Cake", instructions: "мука сахар соль яйцо", url: "http://cake-v-edu.ru")
db.create(name: "Pasta", instructions: "Кидаем лапшу в кипяток", url: "http://pasta-v-edu.ru")

print("""

----------TASK_2----------
Get added data and show it
--------------------------

""")

dbObj = db.read(property: Recipe.self)
for i in dbObj {
    print("""
    Name: \(i.name)
    Instructions: \(i.instructions)
    Url: \(i.url)
    
    """)
}

print("""

----------TASK_3-----------
Remove first note & show DB
---------------------------

db.delete(recipe: dbObj.first!)

""")

db.delete(recipe: dbObj.first!)

for i in dbObj {
    print("""
    Name: \(i.name)
    Instructions: \(i.instructions)
    Url: \(i.url)
    
    """)
}

print("""

----------TASK_4-----------
Update name of first recipe
---------------------------

dbObj = db.read(property: Recipe.self)

var firstDbObj = dbObj.first!
db.update(recipe: firstDbObj, newName: "Ukha")

""")

dbObj = db.read(property: Recipe.self)

var firstDbObj = dbObj.first!
db.update(recipe: firstDbObj, newName: "Ukha")

for i in dbObj {
    print("""
    Name: \(i.name)
    Instructions: \(i.instructions)
    Url: \(i.url)
    
    """)
}

print("""

----------TASK_5-----------
Update name of first recipe
---------------------------

let response = db.find(name: "Cake")

""")

let response = db.find(name: "Cake")
for i in response {
    print("""
    Name: \(i.name)
    Instructions: \(i.instructions)
    Url: \(i.url)
    
    """)
}

dbObj = db.read(property: Recipe.self)
if !dbObj.isEmpty {
    print("DB is not empty!")
    print("Clear DB? [Y/n]")
    switch readLine()!.lowercased() {
    case "y":
        for i in dbObj {
            db.delete(recipe: i)
        }
        break
    default:
        break
    }
}

