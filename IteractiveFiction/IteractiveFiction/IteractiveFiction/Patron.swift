import Foundation

enum PatronState: String {
    case blank = "blank"
    case loaded = "loaded"
}

class Patron {
    let num = UUID()
    let state: PatronState
    let caliber: Int

    func shoot() {
        print("Bang \(caliber)")
    }

    static func == (lhs: Patron, rhs: Patron) -> Bool {
        lhs.caliber == rhs.caliber
    }

    init(state: PatronState, caliber: Int) {
        self.state = state
        self.caliber = caliber
//        num = UUID()
    }
}

extension Patron {
    func toString() -> String {
        "Patron[\(num), \(state), \(caliber)]"
    }
}
