import Foundation
import Swinject

print("Part #1\n")

let userRepo = UserRepository(networkService: NetworkServiceImpl(), databaseService: ReleaseDatabaseServiceImpl())
userRepo.update()

print("\n\nPart #2\n")

print("Part #2.1")
let container = Container()
container.register(NetworkService.self) { _ in NetworkServiceImpl() }
container.register(DatabaseService.self) { _ in ReleaseDatabaseServiceImpl() }
container.register(UserRepository.self) { repo in
    UserRepository(networkService: repo.resolve(NetworkService.self)!, databaseService: repo.resolve(DatabaseService.self)!)
}

let userRepository_v1 = container.resolve(UserRepository.self)!
let userRepository_v2 = container.resolve(UserRepository.self)!

if userRepository_v1 == userRepository_v2 {
    print("Instances are the same")
} else {
    print("Instances are different")
}


print("\n\nPart #2.2")
let container_v2 = Container()
container_v2.register(NetworkService.self) { _ in NetworkServiceImpl() }
container_v2.register(DatabaseService.self, name: "release") { _ in ReleaseDatabaseServiceImpl() }
container_v2.register(DatabaseService.self, name: "debug") { _ in DebugDatabaseServiceImpl() }

container_v2.register(UserRepository.self, name: "release") { repo in
    UserRepository(networkService: repo.resolve(NetworkService.self)!, databaseService: repo.resolve(DatabaseService.self, name: "release")!)
}
container_v2.register(UserRepository.self, name: "debug") { repo in
    UserRepository(networkService: repo.resolve(NetworkService.self)!, databaseService: repo.resolve(DatabaseService.self, name: "debug")!)
}

let release = container_v2.resolve(UserRepository.self, name: "release")!
release.update()
let debug = container_v2.resolve(UserRepository.self, name: "debug")!
debug.update()


print("\n\nPart #2.3")
let container_v3 = Container()
container_v3.register(NetworkService.self) { _ in NetworkServiceImpl() }
container_v3.register(DatabaseService.self) { _ in ReleaseDatabaseServiceImpl() }
container_v3.register(UserRepository.self) { repo in
    UserRepository(networkService: repo.resolve(NetworkService.self)!, databaseService: repo.resolve(DatabaseService.self)!)
}.inObjectScope(.container)

let userRepository_v3 = container_v3.resolve(UserRepository.self)!
userRepository_v3.update()
let userRepository_v4 = container_v3.resolve(UserRepository.self)!
userRepository_v4.update()

if userRepository_v3 == userRepository_v4 {
    print("Instances are the same")
} else {
    print("Instances are different")
}

