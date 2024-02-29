protocol DatabaseService: AnyObject {
    func saveUsers(_ userList: [User])
}

class ReleaseDatabaseServiceImpl: DatabaseService {
    func saveUsers(_ userList: [User]) {
        print("Realease: \(userList.map { i in i.name }) were saved")
    }
}

class DebugDatabaseServiceImpl: DatabaseService {
    func saveUsers(_ userList: [User]) {
        print("Debug: \(userList.map { i in i.name }) were saved")
    }
}
