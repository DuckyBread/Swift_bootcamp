class Company {
    let name: String
    let activity: String
    let description: String
    var vacancy: [Vacancy]
    var skills: [String]
    let contacts: String
    
    init(name: String, activity: String, description: String = "", vacancy: [Vacancy] = [], skills: [String] = [], contacts: String = "") {
        self.name = name
        self.activity = activity
        self.description = description
        self.vacancy = vacancy
        self.skills = skills
        self.contacts = contacts
    }
    
    func vacanciesForCandidate(candidate: Candidate) -> Int {
        let result = vacancy.filter { (v) -> Bool in
            return v.salary >= candidate.salary && v.level == candidate.level && v.profession == candidate.profession
        }
        if !result.isEmpty {
            return vacancy.firstIndex(where: { $0.profession == result[0].profession && $0.level == result[0].level && $0.salary == result[0].salary})!
        }
        
        return -1
    }
    
    func interview(vacationNum: Int, candidate: Candidate) -> Bool {
        let sameSkills = self.skills.filter { (sk) -> Bool in
            return candidate.skills.contains(sk)
        }
        if sameSkills.count < self.skills.count / 2 {
            return false
        } else {
            return Bool.random()
        }
    }
}
