extension String {
    func Mask() -> String {
        guard (self.count == 11 && ["7", "8"].contains(self.first)) || (self.count == 12 && self.prefix(2) == "+7") else {
            return self
        }
        let lastPair = String(self.suffix(2))
        let firstPair = String(self.suffix(4).prefix(2))
        let lastTriple = String(self.suffix(7).prefix(3))
        let firstTriple = String(self.suffix(10).prefix(3))
        
        switch firstTriple {
        case "800":
            return "8 (800) " + lastTriple + " " + firstPair + " " +  lastPair
        default:
            return "+7 " + firstTriple + " " + lastTriple + "-" + firstPair + "-" + lastPair
        }
    }
}

enum AccidentType: String, CaseIterable {
    case fire = "fire"
    case gasLeak = "gas leak"
    case catOnTheTree = "cat on the tree"
}

enum ZoneForm: String {
    case quadrangular = "quadrangular"
    case triangular = "triangular"
    case circular = "circular"
}

enum Probability: String, CaseIterable {
    case low = "low"
    case medium = "medium"
    case high = "high"
}
