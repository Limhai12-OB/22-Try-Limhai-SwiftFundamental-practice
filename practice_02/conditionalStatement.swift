// let score = 82
// let attendance = 95
// let gpa = 3.6

let score = 45
let attendance = 70
let gpa = 2.1

// Grade
let grade: String

if score >= 90 {
    grade = "A"
} else if score >= 80 {
    grade = "B"
} else if score >= 70 {
    grade = "C"
} else if score >= 50 {
    grade = "D"
} else {
    grade = "F"
}

// Result
let result: String

if score >= 50 {
    result = "Pass"
} else {
    result = "Fail"
}

// Message
let message: String

switch grade {
case "A":
    message = "Excellent!"
case "B", "C":
    message = "Good work, keep going!"
case "D":
    message = "You passed. Aim higher next time."
default:
    message = "Please see your instructor."
}

// Scholarship
let scholarship: String

if gpa >= 3.5 && attendance >= 90 {
    scholarship = "Eligible"
} else {
    scholarship = "Not eligible"
}

// Warning
let warning: String

if attendance < 75 || score < 50 {
    warning = "At risk"
} else {
    warning = "None"
}

// Output
print("Score: \(score)")
print("Grade: \(grade)")
print("Result: \(result)")
print("Message: \(message)")
print("Scholarship: \(scholarship)")
print("Warning: \(warning)")

