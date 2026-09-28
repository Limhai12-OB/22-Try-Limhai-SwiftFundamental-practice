let topics = ["Variables", "Conditionals", "Loops", "Collections"]

// 7 times table
for number in 1...10 {
    print("7 x \(number) = \(7 * number)")
}

print()

// Course topics
for index in 0..<topics.count {
    print("\(index + 1). \(topics[index])")
}