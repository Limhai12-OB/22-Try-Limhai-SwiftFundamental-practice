var students = ["Dara", "Sok", "Bopha"]

// Add Rithy to the end
students.append("Rithy")

// Add Vicheka to the front
students.insert("Vicheka", at: 0)

// Print all data, count, and first name
print("All Data: \(students)")
print("Count: \(students.count)")
print("First: \(students[0])")

// Remove the name at position 2
students.remove(at: 2)

print("After removing: \(students)")

// Check if Dara is still in the list
print("Has Dara: \(students.contains("Dara"))")

// Print an alphabetically sorted copy
let sortedStudents = students.sorted()

print("Sorted: \(sortedStudents)")