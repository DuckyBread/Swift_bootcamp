import Foundation

let searcherProfile = Profile(nickname: "coolpicker", age: 28, name: "StereoLol", date: "02/02/2022", status: .IDLE)
let server = Server(url: "https://v-edu-s.ru")
server.addProfile(Profile(nickname: "super3228", age: 15, name: "Kebab", date: "02/02/2012", status: .IDLE))
server.addProfile(Profile(nickname: "lrdxg", age: 19, name: "Oleg", date: "02/02/2011", status: .SEARCH))
server.addProfile(Profile(nickname: "kmaw", age: 35, name: "John", date: "02/02/2009", status: .IN_PLAY))
server.addProfile(Profile(nickname: "aveelyr", age: 17, name: "Alex", date: "02/02/2016", status: .SEARCH))
server.addProfile(searcherProfile)

//
// Testcase, when there are no players with .SEARCH status on server
//

//server.addProfile(Profile(nickname: "super3228", age: 15, name: "Kebab", date: "02/02/2012", status: .IDLE))
//server.addProfile(Profile(nickname: "lrdxg", age: 19, name: "Oleg", date: "02/02/2011", status: .OFFLINE))
//server.addProfile(Profile(nickname: "kmaw", age: 35, name: "John", date: "02/02/2009", status: .IN_PLAY))
//server.addProfile(Profile(nickname: "aveelyr", age: 17, name: "Alex", date: "02/02/2016", status: .OFFLINE))
//server.addProfile(searcherProfile)


print("""
      SearcherProfile:
      \(searcherProfile.toString())

      ServerProfiles:
      \(server.showPlayers())
      
      Start Search
      """)

let res = searcherProfile.findOpponent()
