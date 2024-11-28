
# String Manipulations

Strings are sequences of characters and form one of the most commonly used data types in programming. Manipulating strings is essential for solving real-world problems such as data parsing, validation, and text processing.

In this guide, we’ll cover key operations such as reversing strings, trimming whitespace, and checking specific indexes.

---

## Reverse a String

Reversing a string involves rearranging its characters in the opposite order. This operation is useful in scenarios like string-based algorithms or preparing text for display.

### Problem
Write a function that reverses the characters of a given string.

### Example
Input:  
`"hello"`

Output:  
`"olleh"`

### Swift Implementation
Here’s how you can reverse a string in Swift:
```swift
func reverseString(_ s: String) -> String {
    var reversed = ""
    for char in s {
        reversed = String(char) + reversed
    }
    return reversed
}
```

### Explanation
1. **Initialization**: Start with an empty string `reversed`.
2. **Iteration**: For each character in the input string `s`, prepend it to the `reversed` string. This ensures characters are added in reverse order.
3. **Return Result**: Once all characters are processed, return the reversed string.

### Optimization Tip
For better performance with large strings, use Swift’s `reversed()` method:
```swift
func reverseString(_ s: String) -> String {
    return String(s.reversed())
}
```

---

## Trim Whitespace from a String

Trimming removes unnecessary whitespace from the beginning and end of a string. This is helpful in user input validation or formatting.

### Problem
Write a function that trims leading and trailing whitespace from a string.

### Example
Input:  
`"   Swift is fun!   "`

Output:  
`"Swift is fun!"`

### Swift Implementation
Use Swift’s `trimmingCharacters(in:)` method to efficiently remove whitespace:
```swift
func trimWhitespace(_ s: String) -> String {
    return s.trimmingCharacters(in: .whitespacesAndNewlines)
}
```

### Explanation
1. **Method**: The `.trimmingCharacters(in:)` method removes characters from the specified character set.
2. **Parameter**: `.whitespacesAndNewlines` includes spaces, tabs, and newlines.

---

## Check Characters at Specific Indexes

Accessing characters at specific indexes is a common operation, whether you're validating input, comparing strings, or implementing algorithms.

### Problem
Write a function to return the character at a given index in a string.

### Example
Input:  
String: `"Hello"`  
Index: `1`

Output:  
`"e"`

### Swift Implementation
Use Swift’s `index(_:offsetBy:)` method to safely access characters:
```swift
func characterAt(_ s: String, index: Int) -> Character? {
    guard index >= 0 && index < s.count else {
        return nil // Index out of bounds
    }
    return s[s.index(s.startIndex, offsetBy: index)]
}
```

### Explanation
1. **Bounds Checking**: Use a `guard` statement to ensure the index is within valid bounds.
2. **Index Calculation**: Use `s.index(s.startIndex, offsetBy: index)` to calculate the position of the character in `s`.

### Example Usage
```swift
let word = "Hello"
if let char = characterAt(word, index: 1) {
    print("Character at index 1: \(char)") // Output: "e"
}
```

---

## Additional String Operations

### Palindrome Check
Check if a string reads the same backward and forward:
```swift
func isPalindrome(_ s: String) -> Bool {
    let cleaned = s.lowercased().filter { $0.isLetter }
    return cleaned == String(cleaned.reversed())
}
```

### Count Occurrences of a Character
Count how many times a specific character appears in a string:
```swift
func countOccurrences(of target: Character, in s: String) -> Int {
    return s.filter { $0 == target }.count
}
```

### Replace Substring
Replace all occurrences of a substring with another:
```swift
func replaceSubstring(_ s: String, target: String, replacement: String) -> String {
    return s.replacingOccurrences(of: target, with: replacement)
}
```

### Example
Input:  
String: `"Swift is fun!"`  
Target: `"fun"`  
Replacement: `"awesome"`

Output:  
`"Swift is awesome!"`

---

String manipulation is a foundational skill for solving complex problems. Mastering these operations will significantly improve your ability to write clean and efficient code!
