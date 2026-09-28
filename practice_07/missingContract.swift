struct Student {
    let name: String
    var email: String?
    
    func sendReminder(to student: Student) {
        guard let email = student.email else {
            print("Cannot remind \(student.name): missing email.")
            return
        }
        
        print("Reminder sent to \(email).")
    }
}

let dara = Student(name: "Dara", email: "dara@school.edu")
let sok = Student(name: "Sok", email: nil)

// 1. Safely print email using if let
if let email = dara.email {
    print("Dara: \(email)")
}

if let email = sok.email {
    print("Sok: \(email)")
} else {
    print("Sok: no email on file")
}

// 2. Use ?? for a fallback value
print("Sok's contact: \(sok.email ?? "not provided")")

// 3. Safely access .count using optional chaining
print("Dara's email length: \(dara.email?.count ?? 0)")

// 4. Send reminders
sok.sendReminder(to: dara)
dara.sendReminder(to: dara)