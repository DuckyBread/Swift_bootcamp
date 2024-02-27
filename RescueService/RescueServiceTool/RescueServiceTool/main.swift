import Foundation

print("""
- - - - - - - - - - - - - - - - - - -
|      Enter zone parameters:       |
- - - - - - - - - - - - - - - - - - -
""")
let zoneCoordinates = readLine()!

print("""

- - - - - - - - - - - - - - - - - - -
|       Enter the zone info:        |
- - - - - - - - - - - - - - - - - - -
Enter the shape of area:
""")
let zoneShape = readLine()!
print("Enter phone number:")
let zonePhone = readLine()!
print("Enter name:")
let zoneName = readLine()!
print("Enter emergency dept:")
let zoneDepartment = readLine()!
print("Enter danger level:")
let zoneDangerLevel = readLine()!

print("""

- - - - - - - - - - - - - - - - - - -
|  Enter an accident coordinates:   |
- - - - - - - - - - - - - - - - - - -
""")
let accCoordinates = readLine()!

print("""

- - - - - - - - - - - - - - - - - - -
|     Enter the accident info:      |
- - - - - - - - - - - - - - - - - - -
Enter description:
""")
let accDescription = readLine()!
print("Enter phone number:")
let accPhone = readLine()!
print("Enter type:")
let accType = readLine()!

var zone = Zone(coordinates: zoneCoordinates, phone: zonePhone, name: zoneName, department: zoneDepartment, probability: zoneDangerLevel)
var accident = Accident(coordinates: accCoordinates, description: accDescription, phone: accPhone, type: accType)

switch zone.IsInZone(acc: accident) {
    case true:
        print("""
        
        
        Area info
        Shape: \(zone.type.0.rawValue)
        Phone number: \(zone.phoneNumber)
        Name: \(zone.name)
        Emergency department: \(zone.departmentServiceCode)
        Danger level: \(zone.probability.rawValue)
        
        Accident info
        Description: \(accident.description!)
        Phone: \(accident.phone!)
        Type: \(accident.type == nil ? "n3;4 23;4 23;4 2il" : accident.type!.rawValue)
        """)
    case false:
        print("""
        An accident is not in \(zone.name)
        Switch the applicant to the common number: 88008473824
        """)
}
