let scores = [72, 45, 90, 61, 38, 85]

// Keep passing scores
let passing = scores.filter { score in
    score > 50
}

// Add 5 bonus points
let bonusScores = scores.map { $0 + 5 }

// Sort highest to lowest
let sortedScores = scores.sorted { $0 > $1 }

// Full closure syntax
let isPassing: (Int) -> Bool = { (score: Int) -> Bool in
    score > 50
}

// Count passing scores
let passingCount = scores.filter(isPassing).count

print("Passing: \(passing)")
print("Add 5 bonus points to every score: \(bonusScores)")
print("Sort Highest first: \(sortedScores)")
print("Passing count: \(passingCount)")