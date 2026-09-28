import Foundation
struct Course {
    let code: String
    let title: String
    let capacity: Int
    var enrolledStudents: [String]
}

struct EnrollmentRequest {
    let studentName: String
    let courseCode: String
}

var courses = [
    Course(
        code: "SWE101",
        title: "Swift Fundamentals",
        capacity: 2,
        enrolledStudents: []
    ),
    Course(
        code: "UX110",
        title: "Intro to UX",
        capacity: 30,
        enrolledStudents: []
    )
]

let requests = [
    EnrollmentRequest(studentName: "Dara", courseCode: "SWE101"),
    EnrollmentRequest(studentName: "Sok", courseCode: "SWE101"),
    EnrollmentRequest(studentName: "Dara", courseCode: "SWE101"),
    EnrollmentRequest(studentName: "Bopha", courseCode: "SWE101"),
    EnrollmentRequest(studentName: "Rithy", courseCode: "CS999")
]

for request in requests {
    
    // Look for the course
    guard let courseIndex = courses.firstIndex(
        where: { $0.code == request.courseCode }
    ) else {
        print("Rejected \(request.studentName): \(request.courseCode) does not exist")
        continue
    }
    
    // Check duplicate enrollment
    if courses[courseIndex].enrolledStudents.contains(request.studentName) {
        print("Skipped: \(request.studentName) is already enrolled")
        continue
    }
    
    // Check capacity
    if courses[courseIndex].enrolledStudents.count >= courses[courseIndex].capacity {
        print("Rejected \(request.studentName): \(request.courseCode) is full")
        continue
    }
    
    // Enroll student
    courses[courseIndex].enrolledStudents.append(request.studentName)
    
    print("Enrolled \(request.studentName) in \(request.courseCode)")
}

// Find SWE101
if let sweIndex = courses.firstIndex(where: { $0.code == "SWE101" }) {
    
    let course = courses[sweIndex]
    
    // Sort roster alphabetically
    let roster = course.enrolledStudents.sorted()
    
    print("\n\(course.title): \(roster.joined(separator: ", "))")
    
    // Calculate seats left
    let seatsLeft = course.capacity - course.enrolledStudents.count
    
    print("Seats left: \(seatsLeft)")
}