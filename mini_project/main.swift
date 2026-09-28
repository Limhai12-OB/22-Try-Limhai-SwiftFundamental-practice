import Foundation

struct Student {
    let id: Int
    var name: String
    var age: Int
    var email: String?
    var scores: [Int] = []

    var average: Double? {
        guard !scores.isEmpty else { return nil }
        return Double(scores.reduce(0, +)) / Double(scores.count)
    }

    var grade: String {
        guard let average else { return "—" }
        switch average {
        case 90...100: return "A"
        case 80..<90: return "B"
        case 70..<80: return "C"
        case 50..<70: return "D"
        default: return "F"
        }
    }
}

var students: [Int: Student] = [:]

func prompt(_ text: String) -> String? {
    FileHandle.standardOutput.write(Data(text.utf8))
    return readLine()
}

func readStudentID() -> Int? {
    while true {
        guard let input = prompt("Student ID: ") else { return nil }
        let value = input.trimmingCharacters(in: .whitespacesAndNewlines)

        guard let id = Int(value), id > 0 else {
            print("Error: ID must be a whole number greater than 0.")
            continue
        }
        return id
    }
}

func readUniqueStudentID() -> Int? {
    while true {
        guard let id = readStudentID() else { return nil }
        guard students[id] == nil else {
            print("Error: ID \(id) already exists.")
            continue
        }
        return id
    }
}

func readName(promptText: String = "Name: ") -> String? {
    while true {
        guard let input = prompt(promptText) else { return nil }
        let name = input.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !name.isEmpty else {
            print("Error: Name cannot be empty.")
            continue
        }
        return name
    }
}

func readAge(promptText: String = "Age: ") -> Int? {
    while true {
        guard let input = prompt(promptText) else { return nil }
        let value = input.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let age = Int(value), (16...60).contains(age) else {
            print("Error: Age must be a whole number from 16 to 60.")
            continue
        }
        return age
    }
}

func readEmail(promptText: String = "Email (optional): ") -> String?? {
    while true {
        guard let input = prompt(promptText) else { return nil }
        let email = input.trimmingCharacters(in: .whitespacesAndNewlines)
        if email.isEmpty { return .some(nil) }
        guard email.contains("@") else {
            print("Error: Email must contain @, or press Enter to leave it blank.")
            continue
        }
        return .some(email)
    }
}

func readScore() -> Int? {
    while true {
        guard let input = prompt("Score: ") else { return nil }
        let value = input.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let score = Int(value), (0...100).contains(score) else {
            print("Error: Score must be between 0 and 100.")
            continue
        }
        return score
    }
}

func display(_ student: Student) {
    let average = student.average.map { String(format: "%.2f", $0) } ?? "—"
    let email = student.email ?? "not provided"
    print(padded(String(student.id), width: 5) + padded(student.name, width: 18)
        + padded(String(student.age), width: 5) + padded(email, width: 18)
        + padded(average, width: 8) + student.grade)
}

func padded(_ value: String, width: Int) -> String {
    value + String(repeating: " ", count: max(1, width - value.count))
}

func displayTableHeader() {
    print(padded("ID", width: 5) + padded("Name", width: 18)
        + padded("Age", width: 5) + padded("Email", width: 18)
        + padded("Average", width: 8) + "Grade")
}

func studentsInIDOrder() -> [Student] {
    students.values.sorted { $0.id < $1.id }
}

func viewStudents(_ list: [Student]? = nil) {
    let selectedStudents = list ?? studentsInIDOrder()
    guard !selectedStudents.isEmpty else {
        print(students.isEmpty ? "No students yet." : "No matching students.")
        return
    }

    displayTableHeader()
    for student in selectedStudents {
        display(student)
    }
}

func addStudent() {
    guard let id = readUniqueStudentID() else { return }
    guard let name = readName(), let age = readAge(), let email = readEmail() else { return }

    students[id] = Student(id: id, name: name, age: age, email: email)
    print("Student added.")
}

func searchStudents() {
    guard let input = prompt("Enter student ID or name: ") else { return }
    let query = input.trimmingCharacters(in: .whitespacesAndNewlines)
    guard !query.isEmpty else {
        print("Not found.")
        return
    }

    if let id = Int(query) {
        guard let student = students[id] else {
            print("Not found.")
            return
        }
        displayTableHeader()
        display(student)
        return
    }

    let matches = studentsInIDOrder().filter {
        $0.name.localizedCaseInsensitiveContains(query)
    }
    guard !matches.isEmpty else {
        print("Not found.")
        return
    }
    viewStudents(matches)
}

func updateStudent() {
    guard let id = readStudentID() else { return }
    guard var updatedStudent = students[id] else {
        print("Not found.")
        return
    }

    print("Press Enter to keep the current value. Enter - for email to clear it.")

    while true {
        guard let input = prompt("Name [\(updatedStudent.name)]: ") else { return }
        if input.isEmpty { break }
        let name = input.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !name.isEmpty else {
            print("Error: Name cannot be empty.")
            continue
        }
        updatedStudent.name = name
        break
    }

    while true {
        guard let input = prompt("Age [\(updatedStudent.age)]: ") else { return }
        if input.isEmpty { break }
        let value = input.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let age = Int(value), (16...60).contains(age) else {
            print("Error: Age must be a whole number from 16 to 60.")
            continue
        }
        updatedStudent.age = age
        break
    }

    while true {
        let currentEmail = updatedStudent.email ?? "not provided"
        guard let input = prompt("Email [\(currentEmail)]: ") else { return }
        if input.isEmpty { break }
        let email = input.trimmingCharacters(in: .whitespacesAndNewlines)
        if email == "-" {
            updatedStudent.email = nil
            break
        }
        guard email.contains("@") else {
            print("Error: Email must contain @, or press Enter to keep the current value.")
            continue
        }
        updatedStudent.email = email
        break
    }

    students[id] = updatedStudent
    print("Student updated.")
}

func deleteStudent() {
    guard let id = readStudentID() else { return }
    guard let student = students[id] else {
        print("Not found.")
        return
    }

    while true {
        guard let answer = prompt("Delete \(student.name) (y/n)? ") else { return }
        switch answer.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() {
        case "y":
            students.removeValue(forKey: id)
            print("Student deleted.")
            return
        case "n":
            print("Deletion cancelled.")
            return
        default:
            print("Please enter y or n.")
        }
    }
}

func addScore() {
    guard let id = readStudentID() else { return }
    guard var student = students[id] else {
        print("Not found.")
        return
    }
    guard let score = readScore() else { return }

    student.scores.append(score)
    students[id] = student
    print("Score added.")
}

func classReport() {
    guard !students.isEmpty else {
        print("No students yet.")
        return
    }

    let allScores = students.values.flatMap(\.scores)
    guard !allScores.isEmpty else {
        print("No scores recorded.")
        viewStudents()
        return
    }

    let classAverage = Double(allScores.reduce(0, +)) / Double(allScores.count)
    print("Class average: \(String(format: "%.2f", classAverage))")
    print("Students: \(students.count) | Scores recorded: \(allScores.count)")

    let scoredStudents = studentsInIDOrder().filter { $0.average != nil }
    let gradeCounts = Dictionary(grouping: scoredStudents, by: \.grade)
    print("Grade counts: " + ["A", "B", "C", "D", "F"].map {
        "\($0): \(gradeCounts[$0, default: []].count)"
    }.joined(separator: "  "))
    viewStudents()
}

func filterAndSort() {
    print("\n===== FILTER & SORT =====")
    print("1. Filter by grade")
    print("2. Passing students")
    print("3. Failing students")
    print("4. Sort by name (A-Z)")
    print("5. Sort by average (high-low)")
    print("0. Back")

    guard let input = prompt("Choose an option: "), let choice = Int(input) else {
        print("Invalid option.")
        return
    }

    switch choice {
    case 1:
        while true {
            guard let input = prompt("Grade (A-F): ") else { return }
            let grade = input.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
            guard ["A", "B", "C", "D", "F"].contains(grade) else {
                print("Error: Enter a grade from A to F.")
                continue
            }
            viewStudents(studentsInIDOrder().filter { $0.grade == grade })
            return
        }
    case 2:
        viewStudents(studentsInIDOrder().filter { ($0.average ?? 0) >= 50 && $0.average != nil })
    case 3:
        viewStudents(studentsInIDOrder().filter { $0.average != nil && ($0.average ?? 0) < 50 })
    case 4:
        viewStudents(students.values.sorted {
            $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
        })
    case 5:
        viewStudents(students.values.sorted {
            switch ($0.average, $1.average) {
            case let (left?, right?): return left > right
            case (_?, nil): return true
            case (nil, _?): return false
            case (nil, nil): return $0.id < $1.id
            }
        })
    case 0:
        return
    default:
        print("Invalid option.")
    }
}

func printMenu() {
    print("\n===== ACADEMIC MANAGER =====")
    print("1. Add student")
    print("2. View all students")
    print("3. Search student")
    print("4. Update student")
    print("5. Delete student")
    print("6. Add score")
    print("7. Class report")
    print("8. Filter & sort")
    print("0. Exit")
}

var isRunning = true
while isRunning {
    printMenu()
    guard let input = prompt("Choose an option: ") else { break }

    switch Int(input.trimmingCharacters(in: .whitespacesAndNewlines)) {
    case 0:
        print("Goodbye!")
        isRunning = false
    case 1:
        addStudent()
    case 2:
        viewStudents()
    case 3:
        searchStudents()
    case 4:
        updateStudent()
    case 5:
        deleteStudent()
    case 6:
        addScore()
    case 7:
        classReport()
    case 8:
        filterAndSort()
    default:
        print("Invalid option.")
    }
}