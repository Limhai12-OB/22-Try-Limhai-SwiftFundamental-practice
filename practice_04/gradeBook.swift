var gradeBook: [String: Int] = [
    "Dara": 88,
    "Sok": 74
]

// Add Bopha
gradeBook["Bopha"] = 91

// Change Sok's score
gradeBook["Sok"] = 79

// Remove Dara
gradeBook.removeValue(forKey: "Dara")

// Print Bopha's score
print("Bopha: \(gradeBook["Bopha"] ?? 0)")

// Print 0 if Rithy doesn't exist
print("Rithy: \(gradeBook["Rithy"] ?? 0)")

// Number of entries
print("Entries: \(gradeBook.count)")

// Loop through every name and score
for (name, score) in gradeBook {
    print("\(name) -> \(score)")
}