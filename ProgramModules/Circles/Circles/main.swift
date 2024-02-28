import Foundation

var data = GetData()
let dist = GetDistanceBtwPoints(x0: data[0], y0: data[1], x1: data[3], y1: data[4])

if IsIntersect(r1: data[2], r2: data[5], distance: dist) {
    print("The circles intersect")
} else if IsOneInside(r1: data[2], r2: data[5], distance: dist) {
    print("One circle is inside another")
} else {
    print("The circles is not intersect")
}

func GetData() -> [Double] {
    var data = [Double]()
    var inputLine: String! = String()

    for _ in 1...6 {
        inputLine = readLine()
        
        while Double(inputLine) == nil {
            print("Couldn't parse a number. Please, try again")
            inputLine = readLine()
        }
        
        data.append(Double(inputLine!)!)
    }
    return data
}

func GetDistanceBtwPoints(x0: Double, y0: Double, x1: Double, y1: Double) -> Double {
    return sqrt(pow(x0 - x1, 2) + pow(y0 - y1, 2))
}

func IsOneInside(r1: Double, r2: Double, distance: Double) -> Bool {
    return abs(r1 - r2) >= distance
}

func IsIntersect(r1: Double, r2: Double, distance: Double) -> Bool {
    return (r1 + r2 > distance) && (r1 + distance > r2) && (r2 + distance > r1)
}
