protocol PlayerAction {
    func findOpponent(_ person: Profile) -> Profile?
}

class Server: PlayerAction {

    let address: String
    var players: [Profile]

    init(url: String, players: [Profile] = []) {
        address = url
        self.players = players
    }

    func findOpponent(_ person: Profile) -> Profile? {
        let previousStatus = person.status
        person.status = .SEARCH
        print("""
        SearcherProfile:
        \(person.toString())
        ServerProfiles:
        \(showPlayers())
        
        Result Search
        SearcherProfile:
        \(person.toString())
        Opponent:
        """)
        let inSearchList = players.filter { i in i.status == .SEARCH && i.id != person.id}
        if inSearchList.count == 0 {
            person.status = previousStatus
            print("""
            nil
            ServerProfiles:
            \(showPlayers())
            """)
            return nil
        }
        
        let returnProfile = inSearchList[Int.random(in: 0..<inSearchList.count)]
        print(returnProfile.toString())
        returnProfile.status = .IN_PLAY
        person.status = .IN_PLAY
        print("""
        ServerProfiles:
        \(showPlayers())
        """)
        return returnProfile
    }

    func showPlayers() -> String {
        var output = "["
        players.forEach{ i in output += i.toString() + ", "}
        output.removeLast()
        output.removeLast()
        return output + "]"
    }
    
    func addProfile(_ profile: Profile) -> Bool {
        guard !players.contains(where: {i in i.id == profile.id}) else {
            return false
        }
        profile.playerActionDelegate = self
        players.append(profile)
        return true
    }
}
