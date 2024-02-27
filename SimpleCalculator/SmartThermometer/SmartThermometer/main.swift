import Foundation

func ReadData() -> [Any] {
  let measureReferences: [String] = ["Celsius", "Fahrenheit", "Kelvin"]
  let seasonReferences: [String] = ["S", "W"]

  var measureType: String = readLine()!
  while measureReferences.contains(measureType) == false {
    print("Incorrect input. Enter a measure type (Celsius, Fahrenheit, Kelvin)")
    measureType = readLine()!
  }

  var season: String = readLine()!
  while seasonReferences.contains(season) == false {
    print("Incorrect input. Enter a season (S / W)")
    season = readLine()!
  }

  var temperature = readLine()!
  while Double(temperature) == nil {
    print("Incorrect input. Enter a temperature")
    temperature = readLine()!
  }
    
    var humidity: String = readLine()!
    while Double(humidity) == nil {
      print("Incorrect input. Enter a humidity")
      humidity = readLine()!
    }
  
  var formatedTemp: Measurement<UnitTemperature> {
      switch measureType {
          case "Fahrenheit":
            return Measurement(value: Double(temperature)!, unit: UnitTemperature.celsius).converted(to: .fahrenheit)
          case "Kelvin":
            return Measurement(value: Double(temperature)!, unit: UnitTemperature.celsius).converted(to: .kelvin)
          default:
            return Measurement(value: Double(temperature)!, unit: UnitTemperature.celsius)
      }
  }
  
  return [season, formatedTemp, Double(humidity)!]
}


var data = ReadData()

var currentTemperature = (data[1] as? Measurement<UnitTemperature>)!
print("The temperature is \(String(format: "%.1f", currentTemperature.value)) \(currentTemperature.unit.symbol)")

var comfortableTemperature: [Measurement<UnitTemperature>] {
    switch (data[0] as? String)! {
        case "S":
            return [Measurement(value: 22, unit: UnitTemperature.celsius), Measurement(value: 25, unit: UnitTemperature.celsius)]
        default:
            return [Measurement(value: 20, unit: UnitTemperature.celsius), Measurement(value: 22, unit: UnitTemperature.celsius)]
    }
}
print("The comfortable temperature is from \(String(format: "%.1f", comfortableTemperature[0].converted(to: currentTemperature.unit).value)) \(currentTemperature.unit.symbol) to \(String(format: "%.1f", comfortableTemperature[1].converted(to: currentTemperature.unit).value)) \(currentTemperature.unit.symbol)")

if comfortableTemperature[0]...comfortableTemperature[1] ~= currentTemperature {
    print("The temperature is comfortable")
} else if comfortableTemperature[1] < currentTemperature {
    print("Please, make it colder by \(String(format: "%.1f", currentTemperature.value - comfortableTemperature[1].converted(to: currentTemperature.unit).value)) degrees.")
} else if comfortableTemperature[0] > currentTemperature {
    print("Please, make it warmer by \(String(format: "%.1f", comfortableTemperature[0].converted(to: currentTemperature.unit).value - currentTemperature.value)) degrees.")
}

var normalHumidity: [Double] {
    switch (data[0] as? String)! {
        case "S":
            return [30, 60]
        default:
            return [30, 45]
    }
}
print("The comfortable humidity is from \(String(format: "%.f", normalHumidity[0]))% to \(String(format: "%.f", normalHumidity[1]))%")

if normalHumidity[0]...normalHumidity[1] ~= (data[2] as? Double)! {
    print("The humidity is comfortable")
} else if normalHumidity[0] > (data[2] as? Double)! {
    print("Increase the humidity by \(String(format: "%.f", normalHumidity[0] - (data[2] as? Double)!))%")
} else if normalHumidity[1] < (data[2] as? Double)! {
    print("Decrease the humidity by \(String(format: "%.f", (data[2] as? Double)! - normalHumidity[1]))%")
}
