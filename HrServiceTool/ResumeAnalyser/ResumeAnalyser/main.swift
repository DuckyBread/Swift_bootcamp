import Foundation

enum CustomError: String, Error {
    case undefinedError = "unexpected error"
    case educationInitError = "error Education()"
    case workExpInitError = "error WorkExperience()"
    case candidateInitError = "error Candidate()"
}

let workDirPath = "/Users/silviaju/Swift_Piscine/Resume/HrServiceTool/ResumeAnalyser/ResumeAnalyser"


if FileManager.default.fileExists(atPath: workDirPath + "/resume.txt") {
    do {
        let fileContents = try String(contentsOfFile: workDirPath + "/resume.txt", encoding: .utf8).components(separatedBy: "\n")
        let lines = filterInputFile(fileContents)
        
        try parceTxt(lines)
    } catch CustomError.undefinedError {
        print(CustomError.undefinedError)
    } catch (CustomError.candidateInitError) {
        print(CustomError.candidateInitError)
    } catch {
        print("Error reading file: \(error)")
    }
} else {
    print("File not found.")
}

func isStrWithOnlyAlphas(str: String) -> Bool {
    return str.filter { (c) -> Bool in return Int(String(c)) != nil}.count == 0
}

func parceTxt(_ fileLines: [String]) throws {
    let indCandidatInfo = fileLines.firstIndex { $0.contains("Candidate info")}
    let indEducation = fileLines.firstIndex { $0.contains("Education")}
    let indJobs = fileLines.firstIndex { $0.contains("Job experience")}
    let indSummary = fileLines.firstIndex { $0.contains("Free block")}
    
    let canddidateInfoObj = CandidateInfo(initializeArr: fileLines[indCandidatInfo! + 1 ..< indEducation!])
    if canddidateInfoObj == nil {
        throw CustomError.candidateInitError
    }
    
    let educationObjs = parseToEduArr(arr: fileLines[indEducation! + 1 ..< indJobs!])
    let workExpObjs = parseToWEArr(arr: fileLines[indJobs! + 1 ..< indSummary!])
    let summary = joinSummary(fileLines[indSummary! + 1 ..< fileLines.count])
    let resume = Resume(candidateInfo: canddidateInfoObj!, education: educationObjs, workExperince: workExpObjs, description: summary)
    try resume.importResume(path: workDirPath)
    
    let tags = try String(contentsOfFile: workDirPath + "/tags.txt", encoding: .utf8).components(separatedBy: "\n")
    
    var dictionary: [String : Int] = [:]
    for job in workExpObjs {
        let str = job.description
        let words = str.components(separatedBy: " ").filter { (word) -> Bool in return isStrWithOnlyAlphas(str: word)}
        for w in words {
            if dictionary[w] == nil {
                dictionary[w] = 1
            } else {
                dictionary[w]! += 1
            }
        }
    }
    let words = summary.components(separatedBy: " ").filter { (word) -> Bool in return isStrWithOnlyAlphas(str: word)}
    for w in words {
        if dictionary[w] == nil {
            dictionary[w] = 1
        } else {
            dictionary[w]! += 1
        }
    }
    let sortedDictionary = dictionary.sorted { (f, s) -> Bool in return f.value > s.value }
    var analysisOut = "# Words\n"
    for i in sortedDictionary {
        analysisOut += i.key + " - " + String(i.value)  + "\n"
    }
    analysisOut += "\nMatched tags\n"
    let matches = sortedDictionary.filter { key, value in return tags.contains(key)}
    for (i, _) in matches {
        analysisOut += i + "\n"
    }
    let fileURL = URL(fileURLWithPath: workDirPath).appendingPathComponent("analysis.txt")

    if FileManager.default.fileExists(atPath: fileURL.path) {
        try FileManager.default.removeItem(at: fileURL)
    }

    FileManager.default.createFile(atPath: fileURL.path, contents: nil, attributes: nil)
    try analysisOut.write(to: fileURL, atomically: true, encoding: .utf8)
}

func filterInputFile(_ inputFile: [String]) -> [String] {
    return inputFile.filter { (s) -> Bool in
        return s != "..." && !s.isEmpty
    }
}

func parseToEduArr(arr: ArraySlice<String>) -> [Education] {
    var returnableList: [Education] = []
    let counter = arr.filter { (s) -> Bool in return s == "##"}.count
    let transformedArr = arr.map { (sub) -> String in return String(sub)}.filter { (s) -> Bool in return s != "##"}
    
    for i in 0 ..< counter - 1 {
        returnableList.append(Education(type: transformedArr[i * 3], period: transformedArr[i * 3 + 1], description: transformedArr[i * 3 + 2]))
    }
    
    return returnableList
}

func parseToWEArr(arr: ArraySlice<String>) -> [WorkExperience] {
    var returnableList: [WorkExperience] = []
    let counter = arr.filter { (s) -> Bool in return s == "##"}.count
    let transformedArr = arr.map { (sub) -> String in return String(sub)}.filter { (s) -> Bool in return s != "##"}
    
    for i in 0 ..< counter - 1 {
        returnableList.append(WorkExperience(period: transformedArr[i * 3], name: transformedArr[i * 3 + 1], description: transformedArr[i * 3 + 2]))
    }
    
    return returnableList
}

func joinSummary(_ arr: ArraySlice<String>) -> String {
    var resStr = String()
    let transformedArr = arr.map { (sub) -> String in return String(sub)}
    for i in transformedArr {
        resStr += i
    }
    
    return resStr
}
