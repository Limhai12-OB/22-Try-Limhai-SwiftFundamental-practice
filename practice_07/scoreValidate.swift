enum ScoreError: Error {
    case notANumber
    case negative
    case above100
}

func parseScore(_ input: String) throws -> Int {
    guard let score = Int(input) else {
        throw ScoreError.notANumber
    }

    guard score >= 0 else {
        throw ScoreError.negative
    }

    guard score <= 100 else {
        throw ScoreError.above100
    }

    return score
}

let inputs = ["88", "-4", "120", "ninety"]

for input in inputs {
    do {
        let score = try parseScore(input)
        print("Saved score: \(score)")
    } catch ScoreError.notANumber {
        print("Error: \"\(input)\" is not a number.")
    } catch ScoreError.negative {
        print("Error: \(input) is negative.")
    } catch ScoreError.above100 {
        print("Error: \(input) is above 100.")
    } catch {
        print("Error: Unknown error.")
    }
}