import Foundation
struct Student {
    let name: String
    let score: Int
}

let students = [
    Student(name: "Dara", score: 88),
    Student(name: "Sok", score: 45),
    Student(name: "Bopha", score: 92),
    Student(name: "Rithy", score: 67),
    Student(name: "Vicheka", score: 73),
    Student(name: "Sophea", score: 39)
]

print("===== SCORE ANALYZER =====")
print("Students: \(students.count)")

if students.isEmpty {
    print("Class average: 0.00")
    print("\nNo students to analyze.")
} else {
    // Calculate average
    let total = students.reduce(0) { $0 + $1.score }
    let average = Double(total) / Double(students.count)

    print(String(format: "Class average: %.2f", average))

    // Results
    print("\n--- Results ---")

    for student in students {
        let result = student.score >= 50 ? "PASS" : "FAIL"
        print("\(student.name): \(student.score) \(result)")
    }

    // Highest and lowest
    if let highest = students.max(by: { $0.score < $1.score }),
       let lowest = students.min(by: { $0.score < $1.score }) {
        print("\nHighest: \(highest.name) (\(highest.score))")
        print("Lowest: \(lowest.name) (\(lowest.score))")
    }

    // Passing students
    let passingStudents = students.filter { $0.score >= 50 }

    print("\nPassing: \(passingStudents.map { $0.name }.joined(separator: ", "))")

    // Ranking
    let ranking = students.sorted { $0.score > $1.score }

    print("\n--- Ranking ---")

    for (index, student) in ranking.enumerated() {
        print("\(index + 1). \(student.name) - \(student.score)")
    }
}