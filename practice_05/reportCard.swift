func average(of scores: [Int]) -> Double {
    let total = scores.reduce(0, +)
    return Double(total) / Double(scores.count)
}

func letterGrade(for average: Double) -> String {
    if average >= 90 {
        return "A"
    } else if average >= 80 {
        return "B"
    } else if average >= 70 {
        return "C"
    } else if average >= 50 {
        return "D"
    } else {
        return "F"
    }
}

func printReport(_ name: String, scores: [Int]) {
    let avg = average(of: scores)
    let grade = letterGrade(for: avg)

    print("\(name): average \(avg), grade \(grade)")
}

printReport("Dara", scores: [80, 90, 85])
printReport("Sok", scores: [60, 70, 65])