import Foundation

class Profile {
    let id = UUID()
    let nickname: String
    let age: Int
    let name: String
    var gun: RevolverMoonClip?
    let signUpDate: String
    var status: Status
    lazy var url: String  = {
            "http://gameserver.com/\(id)-\(nickname)"
    }()
    var playerActionDelegate: PlayerAction? = nil

    init(nickname: String, age: Int, name: String, gun: RevolverMoonClip? = nil, date: String, status: Status) {
        self.nickname = nickname
        self.age = age
        self.name = name
        self.gun = gun
        signUpDate = date
        self.status = status
    }

    func findOpponent() -> Profile? {
        return playerActionDelegate?.findOpponent(self)
    }
    
    func toString() -> String {"Profile(\"\(nickname)\", \(status))"}
}

enum Status: String, CaseIterable {
    case IN_PLAY = "IN_PLAY"
    case SEARCH = "SEARCH"
    case IDLE = "IDLE"
    case OFFLINE = "OFFLINE"
}
