import Foundation

protocol NetworkService: AnyObject {
  func getUsers() -> [User]
}

class NetworkServiceImpl: NetworkService {
  func getUsers() -> [User] {
    return [
      User(name: "Artem",
           surname: "silviaju",
           age: 23,
           isIphone: true),
      User(name: "Manarbek",
           surname: "windhelg",
           age: 28,
           isIphone: false),
       User(name: "Danya",
           surname: "elenemar",
           age: 23,
           isIphone: true),
        User(name: "Disa",
            surname: "isigrin",
            age: 21,
            isIphone: false)
    ]
  }
}
