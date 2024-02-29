public class Candidate {
    let name: String
    let profession: Profession
    let level: Level
    let salary: Int
    let skills: [String]

    init (name: String, profession: Profession, level: Level, salary: Int, skills: [String] = []) {
        self.name = name
        self.profession = profession
        self.level = level
        self.salary = salary
        self.skills = skills
    }
    
    func showInfo() {
        print("- Name: \(name)\n- Profession: \(profession)\n- Level: \(level.rawValue)\n- Salary: \(salary)\n- Skills: \(skills)\n")
    }
}

enum Level: String, CaseIterable {
    case junior = "junior"
    case middle = "middle"
    case senior = "senior"
}
