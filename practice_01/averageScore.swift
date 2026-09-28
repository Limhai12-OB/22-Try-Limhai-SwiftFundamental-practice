let score1 = 80
let score2 = 90
let score3 = 85

// Total
let total = score1 + score2 + score3

// Average as a decimal
let average = Double(total) / 3.0

// Average rounded down to a whole number
let roundedAverage = Int(average)

// Label
let label = "Total: " + String(total)

// Print everything
print("Total: \(total)")
print("Average: \(average)")
print("Rounded average: \(roundedAverage)")
print("Label -> " + label)