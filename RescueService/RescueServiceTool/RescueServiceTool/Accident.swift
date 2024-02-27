class Accident {
    let coordinates: (Int, Int)
    var description: String?
    var phone: String?
    var type: AccidentType?
    
    init(coordinates: String, description: String?, phone: String?, type: String?) {
        let parcedLine = coordinates.split(separator: ";").map{Int($0)!}
        self.coordinates = (parcedLine[0], parcedLine[1])
        self.description = description ?? "nil"
        self.phone = phone?.Mask() ?? "nil"
        
        for i in AccidentType.allCases {
            if i.rawValue == type {
                self.type = i
                break
            }
        }
    }
}
