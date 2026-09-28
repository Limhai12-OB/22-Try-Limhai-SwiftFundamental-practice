class Person {
    var name: String

    init(name: String) {
        self.name = name
    }

    func introduce() -> String {
        return "Hi, I'm \(name)."
    }
}

class Teacher: Person {
    var subject: String

    init(name: String, subject: String) {
        self.subject = subject
        super.init(name: name)
    }

    override func introduce() -> String {
        return "Hi, I'm \(name) and I teach \(subject)."
    }
}

let teacherA = Teacher(name: "Ms. Sophea", subject: "Swift")
let teacherB = teacherA

teacherB.name = "Ms. Sophea"

print(teacherA.introduce())
print(teacherB.introduce())