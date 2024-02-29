import Foundation

class UserRepository: Equatable {
    typealias Services = NetworkService & DatabaseService
    
    var databaseService: DatabaseService
    var networkService: NetworkService
    
    init(networkService: NetworkService, databaseService: DatabaseService) {
        self.networkService = networkService
        self.databaseService = databaseService
    }
    
    func update() {
        let tmp = networkService.getUsers()
        databaseService.saveUsers(tmp)
    }
    
    static func == (lhs: UserRepository, rhs: UserRepository) -> Bool {
        return lhs.networkService === rhs.networkService &&
            lhs.databaseService === rhs.databaseService
    }
}
