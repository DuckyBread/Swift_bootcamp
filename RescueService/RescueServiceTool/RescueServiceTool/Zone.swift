import Foundation

class Zone {
    var type: (ZoneForm, [Int])
    var phoneNumber: String
    var name: String
    var departmentServiceCode: String
    var probability: Probability
    
    init(coordinates: String, phone: String, name: String, department: String, probability: String) {
        let parcedLine = coordinates.split(separator: " ")
        var numArr = [Int]()
        for i in parcedLine {
            let tmp = i.split(separator: ";").map{Int($0)}
            for j in tmp {
                numArr.append(j!)
            }
        }
        
        switch numArr.count {
        case 3:
            type = (ZoneForm.circular, numArr)
        case 6:
            type = (ZoneForm.triangular, numArr)
        default:
            type = (ZoneForm.quadrangular, numArr)
        }
        
        phoneNumber = phone.Mask()
        self.name = name
        departmentServiceCode = department
        
        self.probability = .low
        for i in Probability.allCases {
            if i.rawValue == probability {
                self.probability =  i
                break
            }
        }
    }
    
    func IsInZone(acc: Accident) -> Bool {
        func TriangleSquare(x1: Int, y1: Int, x2: Int, y2: Int, x3: Int, y3: Int) -> Double {
            let ab = sqrt(pow(Double(x1 - x2), 2) + pow(Double(y1 - y2), 2))
            let ac = sqrt(pow(Double(x1 - x3), 2) + pow(Double(y1 - y3), 2))
            let bc = sqrt(pow(Double(x2 - x3), 2) + pow(Double(y2 - y3), 2))
            
            let abcHalfP = 0.5 * (ab + bc + ac)
            
            return sqrt(abcHalfP * (abcHalfP - ab) * (abcHalfP - bc) * (abcHalfP - ac))
        }
        
        switch self.type.0 {
        case .circular:
            return pow(Double(acc.coordinates.0 - type.1.first!), 2) + pow(Double(acc.coordinates.1 - type.1[1]), 2) <= pow(Double(self.type.1.last!), 2)
        case .triangular:
            let abd = TriangleSquare(x1: self.type.1[0], y1: self.type.1[1], x2: self.type.1[2], y2: self.type.1[3], x3: acc.coordinates.0, y3: acc.coordinates.1)
            let acd = TriangleSquare(x1: self.type.1[0], y1: self.type.1[1], x2: self.type.1[4], y2: self.type.1[5], x3: acc.coordinates.0, y3: acc.coordinates.1)
            let bcd = TriangleSquare(x1: self.type.1[2], y1: self.type.1[3], x2: self.type.1[4], y2: self.type.1[5], x3: acc.coordinates.0, y3: acc.coordinates.1)
            let abc = TriangleSquare(x1: self.type.1[0], y1: self.type.1[1], x2: self.type.1[2], y2: self.type.1[3], x3: self.type.1[4], y3: self.type.1[5])
            
            return (abd + acd + bcd) <= abc
        case .quadrangular:
            let abd = TriangleSquare(x1: self.type.1[0], y1: self.type.1[1], x2: self.type.1[2], y2: self.type.1[3], x3: self.type.1[6], y3: self.type.1[7])
            let bcd = TriangleSquare(x1: self.type.1[2], y1: self.type.1[3], x2: self.type.1[4], y2: self.type.1[5], x3: self.type.1[6], y3: self.type.1[7])
            let bde = TriangleSquare(x1: self.type.1[2], y1: self.type.1[3], x2: self.type.1[6], y2: self.type.1[7], x3: acc.coordinates.0, y3: acc.coordinates.1)
            
            let abe = TriangleSquare(x1: self.type.1[0], y1: self.type.1[1], x2: self.type.1[2], y2: self.type.1[3], x3: acc.coordinates.0, y3: acc.coordinates.1)
            let bce = TriangleSquare(x1: self.type.1[2], y1: self.type.1[3], x2: self.type.1[4], y2: self.type.1[5], x3: acc.coordinates.0, y3: acc.coordinates.1)
            let cde = TriangleSquare(x1: self.type.1[4], y1: self.type.1[5], x2: self.type.1[6], y2: self.type.1[7], x3: acc.coordinates.0, y3: acc.coordinates.1)
            let dae = TriangleSquare(x1: self.type.1[6], y1: self.type.1[7], x2: self.type.1[0], y2: self.type.1[1], x3: acc.coordinates.0, y3: acc.coordinates.1)
            
            return (abe + bde + dae) <= abd || (bce + cde + bde) <= bcd
        }
    }
}
