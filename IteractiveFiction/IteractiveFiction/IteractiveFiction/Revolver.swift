import Foundation

class RevolverMoonClip {
    var clip: [Patron?] = []
    var caliber: Int?
    static var usedPatrons = Set<UUID>()

    init(_ arr: [Patron?] = [Patron?](repeating: nil, count: 6)) throws {
        guard arr.count == 6 else {
            throw CustomError.initializationError
        }
        for i in arr {
            if let v = i {
                if !RevolverMoonClip.usedPatrons.contains(v.num) {
                    clip.append(v)
                    RevolverMoonClip.usedPatrons.insert(v.num)
                }
            } else {
                clip.append(i)
            }
        }

        if let ind = arr.firstIndex(where: { i in i != nil }) {
            caliber = arr[ind]!.caliber
        } else {
            throw CustomError.initializationError
        }
    }

    init() {
        clip = [Patron?](repeating: nil, count: 6)
        caliber = nil
    }

    var pointer: Patron? {
        get {
            clip[0]
        }
    }

    func add(_ item: Patron) -> Bool {
        guard clip.contains(where: { bullet in bullet == nil }) || clip.first(where: { i in i != nil })!?.caliber != item.caliber else {
            return false
        }
        if RevolverMoonClip.usedPatrons.contains(item.num) {
            return false
        }
        RevolverMoonClip.usedPatrons.insert(item.num)
        if clip.filter({i in i == nil}).count == 6 {
            caliber = item.caliber
        }

        let ind = clip.firstIndex(where: { bullet in bullet == nil })!
        clip.remove(at: ind)
        clip.insert(item, at: ind)
        return true
    }

    func unload(index: Int) throws -> Patron? {
        guard 0..<6 ~= index else {
            throw CustomError.incorrectIndexError
        }
        let bullet = clip[index]
        clip[index] = nil
        return bullet
    }

    func unloadAll() -> [Patron?] {
        let result = clip
        clip = [Patron?](repeating: nil, count: 6)
        return result
    }

    func shoot() -> Patron? {
        let result = pointer
        clip.remove(at: 0)
        clip.append(nil)
        if result != nil {
            if result?.state != PatronState.blank {
                result?.shoot()
            } else {
                print("Click")
            }
        }
        return result
    }

    func scroll() {
        var shift = Int.random(in: 1...6)
        while shift % 6 == 0 {
            shift = Int.random(in: 1...6)
        }
        let leftPart = clip[0..<shift]
        clip.removeFirst(shift)
        clip.insert(contentsOf: leftPart, at: clip.endIndex)
    }

    func getSize() -> Int {
        clip.filter({ b in b != nil }).count
    }

    subscript(index: Int) -> Patron? {
        get throws {
            guard index < 6 else {
                throw CustomError.incorrectIndexError
            }
            return clip[index]
        }
    }

    func clipToStr() -> String {
        var obj = String()
        clip.forEach({i in
            if let p = i {
                obj += "\(p.toString()), "
            } else {
                obj += "nil, "
            }
        })
        obj.removeLast()
        obj.removeLast()
        return obj
    }
}

extension RevolverMoonClip {
    func toStringDescription() {
        var caliberStr: String {
            switch (caliber == nil) {
            case true:
                return "nil"
            case false:
                return "\(caliber)"
            }
        }
        print("Structure: \(type(of: self)) \(caliberStr) caliber")
        print("Objects: [\(clipToStr())]")
        if let p = pointer {
            print("Pointer: " + p.toString())
        } else {
            print("Pointer: nil")
        }
    }
}

enum CustomError: Error {
    case incorrectIndexError
    case undefinedError
    case initializationError
}
