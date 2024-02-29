import Foundation

class User {
  let name: String
  var surname: String
  var age: Int
  let hasIphone: Bool

  init(name: String, surname: String, age: Int, isIphone: Bool) {
    self.name = name
    self.surname = surname
    self.age = age
    self.hasIphone = isIphone
  }
}
