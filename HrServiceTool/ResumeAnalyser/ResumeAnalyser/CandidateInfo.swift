class CandidateInfo {
    let name: String
    let profession: String
    let sex: String
    let birth: String
    let contacts: String
    
    init(name: String, profession: String, sex: String, birth: String, contacts: String) {
        self.name = name
        self.profession = profession
        self.sex = sex
        self.birth = birth
        self.contacts = contacts
    }
    
    init?(initializeArr: ArraySlice<String>) {
        guard initializeArr.count == 5  else {
            return nil
        }
        
        var i = Int(initializeArr.startIndex)
        
        self.name = initializeArr[i]
        i += 1
        self.profession = initializeArr[i]
        i += 1
        self.sex = initializeArr[i]
        i += 1
        self.birth = initializeArr[i]
        i += 1
        self.contacts = initializeArr[i]
    }
}
