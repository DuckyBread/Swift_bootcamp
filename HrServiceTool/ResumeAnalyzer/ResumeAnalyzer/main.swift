import Foundation

let candidate = Candidate(name: "Anna",
                          profession: Profession.Analyst,
                          level: Level.junior,
                          salary: 100_000,
                          skills: ["SQL", "GIT", "C++"]
)
var companies: [Company] = []

companies.append(Company(name: "Sper",
                         activity: "Baking",
                         vacancy: [Vacancy(profession: Profession.Developer,
                                           level: Level.junior,
                                           salary: 50_000),
                                   Vacancy(profession: Profession.Manager,
                                           level: Level.junior,
                                           salary: 105_000),
                                   Vacancy(profession: Profession.Analyst,
                                           level: Level.senior,
                                           salary: 150_000)
                                  ],
                         skills: ["SQL", "excel"],
                         contacts: "sber@fake-mail.ya")
)
companies.append(Company(name: "Sigma",
                         activity: "Pranking",
                         vacancy: [Vacancy(profession: Profession.Designer,
                                           level: Level.junior,
                                           salary: 7_000),
                                   Vacancy(profession: Profession.Analyst,
                                           level: Level.middle,
                                           salary: 99_000),
                                   Vacancy(profession: Profession.Manager,
                                           level: Level.senior,
                                           salary: 150_000)
                                  ],
                         skills: ["SQL", "C++"],
                         contacts: "sigma@fake-mail.ya")
)
companies.append(Company(name: "Sovok",
                         activity: "Cleaning",
                         vacancy: [Vacancy(profession: Profession.QA,
                                           level: Level.junior,
                                           salary: 45_000),
                                   Vacancy(profession: Profession.Project,
                                           level: Level.junior,
                                           salary: 300_000),
                                   Vacancy(profession: Profession.Analyst,
                                           level: Level.junior,
                                           salary: 150_000)
                                  ],
                         skills: ["MSQL", "word", "GIT"],
                         contacts: "sovok@fake-mail.ya")
)
companies.append(Company(name: "BTV",
                         activity: "Dancing",
                         vacancy: [Vacancy(profession: Profession.Manager,
                                           level: Level.senior,
                                           salary: 75_000),
                                   Vacancy(profession: Profession.Analyst,
                                           level: Level.middle,
                                           salary: 165_000),
                                   Vacancy(profession: Profession.Analyst,
                                           level: Level.senior,
                                           salary: 150_000)
                                  ],
                         skills: ["SQL", "excel", "nginx"],
                         contacts: "btv@fake-mail.ya")
)
companies.append(Company(name: "Tonkon",
                         activity: "Parking",
                         vacancy: [Vacancy(profession: Profession.QA,
                                           level: Level.senior,
                                           salary: 90_000),
                                   Vacancy(profession: Profession.Analyst,
                                           level: Level.junior,
                                           salary: 140_000),
                                   Vacancy(profession: Profession.Analyst,
                                           level: Level.senior,
                                           salary: 166_000)
                                  ],
                         skills: ["MSQL", "excel", "csharp"],
                         contacts: "tonkon@fake-mail.ya")
)
candidate.showInfo()
print("Banking. \(candidate.profession). \(candidate.level.rawValue[candidate.level.rawValue.startIndex].uppercased() + candidate.level.rawValue[candidate.level.rawValue.index(after: candidate.level.rawValue.startIndex)...]). >= \(candidate.salary)")
print("The list of suitable vacancies:\n")

let filteredCompanies: [String : [Int]] = filterCompanies(companies: companies, candidate: candidate)

for i in filteredCompanies {
    print(String(i.value[0] + 1) + ".")
    print("\(candidate.level.rawValue[candidate.level.rawValue.startIndex].uppercased() + candidate.level.rawValue[candidate.level.rawValue.index(after: candidate.level.rawValue.startIndex)...]) \(candidate.profession)     ---     >= \(candidate.salary)")
    let company = companies.first(where: { $0.name == i.key})
    print(company!.name)
    print(company!.activity)
    print(company!.skills)
    print("---------------------------------------\n")
}

var vacancyNum = readLine()
while Int(vacancyNum!) != nil && !isDictionaryContainNumber(dict: filteredCompanies, number: Int(vacancyNum!)! - 1) {
    print("It doesn't look like a correct input.")
    vacancyNum = readLine()
}

print("\nProcessing Interview...")
let ind = Int(vacancyNum!)!

let companyName = filteredCompanies.first(where: { $0.value.contains(ind - 1)})!.key
let answer = companies.first(where: { $0.name == companyName})!.interview(vacationNum: ind - 1 , candidate: candidate)

if answer {
    print("Success, candidate was applied.")
} else {
    print("Candidate was rejected.")
}

func filterCompanies(companies: [Company], candidate: Candidate) -> [String : [Int]] {
    var result: [String : [Int]] = [:]
    for c in companies {
        let ind = c.vacanciesForCandidate(candidate: candidate)
        if  ind != -1 {
            result[c.name, default: []].append(ind)
        }
    }
    return result
}

func isDictionaryContainNumber(dict: [String : [Int]], number: Int) -> Bool {
    for (_, array) in dict {
        if array.contains(number) {
            return true
        }
    }
    return false
}
