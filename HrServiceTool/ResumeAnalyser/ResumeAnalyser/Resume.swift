import Foundation

class Resume {
    let candidateInfo: CandidateInfo
    var education: [Education]
    var workExperince: [WorkExperience]
    var description: String
    
    init(candidateInfo: CandidateInfo, education: [Education] = [], workExperince: [WorkExperience] = [], description: String = "") {
        self.candidateInfo = candidateInfo
        self.education = education
        self.workExperince = workExperince
        self.description = description
    }
    
    func importResume(path: String) throws {
        var outputData = String()
        outputData += "# Candidate info\n"
        outputData += candidateInfo.name + "\n"
        outputData += candidateInfo.profession + "\n"
        outputData += candidateInfo.sex + "\n"
        outputData += candidateInfo.birth + "\n"
        outputData += candidateInfo.contacts + "\n"
        
        outputData += "\n# Education\n"
        for i in education {
            outputData += "##\n"
            outputData += i.type + "\n"
            outputData += i.period + "\n"
            outputData += i.description + "\n"
        }
        outputData += "##\n"
        
        outputData += "\n# Job experience\n"
        for i in workExperince {
            outputData += "##\n"
            outputData += i.period + "\n"
            outputData += i.companyInfo + "\n"
            outputData += i.description + "\n"
        }
        outputData += "##\n"
        
        outputData += "\n# Free block\n"
        outputData += description + "\n"
        
        let fileURL = URL(fileURLWithPath: path).appendingPathComponent("export.txt")

        if FileManager.default.fileExists(atPath: fileURL.path) {
            try FileManager.default.removeItem(at: fileURL)
        }

        FileManager.default.createFile(atPath: fileURL.path, contents: nil, attributes: nil)
        try outputData.write(to: fileURL, atomically: true, encoding: .utf8)
    }
}
