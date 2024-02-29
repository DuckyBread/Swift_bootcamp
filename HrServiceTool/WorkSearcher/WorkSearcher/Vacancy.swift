class Vacancy {
    let profession: Profession
    let level: Level
    let salary: Int
    
    init(profession: Profession, level: Level, salary: Int) {
        self.profession = profession
        self.level = level
        self.salary = salary
    }
    
}

enum Profession: String, CaseIterable {
    case Developer = "Developer"
    case Designer = "Designer"
    case Project  = "Project"
    case Manager = "Manager"
    case Analyst = "Analyst"
    case QA = "QA"
}
