import Foundation
import RxSwift

func filterByE(collection: Observable<String>) async -> [String] {
    var output = [String]()
    collection.filter { i in
        i.contains("e")
    }.subscribe {output.append($0)}.disposed(by: DisposeBag())
    
    return output
}

func filterByThInBegin(collection: Observable<String>) async -> [String] {
    var output = [String]()
    collection.filter { i in
        i.starts(with: "th")
    }.subscribe { i in
        output.append(i)
    }.disposed(by: DisposeBag())
    
    return output
}

func checkLen(collection: Observable<String>) async -> Bool {
    try! await collection.values.allSatisfy { i in
        i.count <= 5
    }
}

func isStringsOverFiveLetters(collection: Observable<String>) async -> Bool {
    try! await collection.values.contains { i in
        i.count > 5
    }
}

func isEmptyStrings(collection: Observable<String>) async -> Bool {
    try! await collection.values.contains { i in
        i.isEmpty
    }
}

func generalLen(collection: Observable<String>) async -> Int {
    var output = 0
    collection.scan(0) { seed, value in
        seed + value.count
    }.subscribe { i in
        output = i
    }.disposed(by: DisposeBag())
    
    return output
}

func stringAmount(collection: Observable<String>) async -> Int {
    var output = 0
    collection.subscribe(onNext: { _ in
        output += 1
    }).disposed(by: DisposeBag())
    
    return output
}

func getStrings(observable: Observable<Sample>) async -> [String] {
    var textFields = [String]()
    _ = observable.subscribe(onNext: { sample in
        textFields.append(sample.text)
    })
    
    return textFields
}


async let task1 = filterByE(collection: firstCollection)
print("Task1: \(await task1)")

async let task2 = filterByThInBegin(collection: firstCollection)
print("Task2: \(await task2)")

async let task3 = checkLen(collection: firstCollection)
print("Task3: \(await task3)")

async let task4 = isStringsOverFiveLetters(collection: firstCollection)
print("Task4: \(await task4)")

async let task5 = isEmptyStrings(collection: firstCollection)
print("Task5: \(await task5)")

async let task6 = generalLen(collection: firstCollection)
print("Task6: \(await task6)")

async let task7 = stringAmount(collection: firstCollection)
print("Task7: \(await task7)")

async let task8 = getStrings(observable: secondCollection)
print("Task8: \(await task8)")
