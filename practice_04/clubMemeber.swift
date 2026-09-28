var codingClub: Set<String> = ["Dara", "Sok", "Bopha"]
let mathClub: Set<String> = ["Sok", "Rithy", "Bopha"]

// Try adding Dara again
codingClub.insert("Dara")

print("Coding club size: \(codingClub.count)")

// Students in both clubs
let bothClubs = codingClub.intersection(mathClub)

// Students in either club
let allMembers = codingClub.union(mathClub)

// Sort for predictable output
print("In both clubs: \(bothClubs.sorted())")
print("All members: \(allMembers.sorted())")