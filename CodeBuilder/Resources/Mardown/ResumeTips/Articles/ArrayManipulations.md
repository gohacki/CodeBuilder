
# Array Manipulations

Arrays are fundamental data structures used to store collections of elements. Manipulating arrays is essential for solving problems in sorting, searching, and transforming data.

---

## Find the Maximum Element

Finding the maximum element in an array is one of the simplest and most common operations.

### Problem
Write a function to find the maximum element in a given array.

### Example
Input:  
Array: `[3, 7, 2, 8, 6]`

Output:  
`8` (Maximum element)

### Swift Implementation
```swift
func findMaximum(_ arr: [Int]) -> Int? {
    guard !arr.isEmpty else { return nil }
    var max = arr[0]
    for num in arr {
        if num > max {
            max = num
        }
    }
    return max
}
```

### Explanation
1. **Check for Empty Array**: Return `nil` if the array is empty.
2. **Iterate Through Array**: Compare each element with the current maximum.
3. **Update Maximum**: Update the maximum when a larger value is found.

---

## Count Occurrences of an Element

Counting occurrences of a specific element in an array is a common task in data analysis.

### Problem
Write a function to count the number of times a target element appears in an array.

### Example
Input:  
Array: `[1, 2, 3, 2, 2, 4]`  
Target: `2`

Output:  
`3` (Occurrences of `2`)

### Swift Implementation
```swift
func countOccurrences(_ arr: [Int], target: Int) -> Int {
    return arr.filter { $0 == target }.count
}
```

### Explanation
1. **Filter Elements**: Use `.filter` to create a new array containing only the elements that match the target.
2. **Count Elements**: Return the count of the filtered array.

---

## Find Intersection of Two Arrays

The intersection of two arrays is a set of elements that appear in both arrays.

### Problem
Write a function to find the intersection of two arrays.

### Example
Input:  
Array 1: `[1, 2, 3, 4]`  
Array 2: `[3, 4, 5, 6]`

Output:  
Intersection: `[3, 4]`

### Swift Implementation
```swift
func intersection(_ a: [Int], _ b: [Int]) -> [Int] {
    let setA = Set(a)
    let setB = Set(b)
    return Array(setA.intersection(setB))
}
```

### Explanation
1. **Convert to Sets**: Use `Set` to efficiently find common elements.
2. **Find Intersection**: Use `.intersection` to find common elements between two sets.
3. **Return as Array**: Convert the result back to an array.

---

## Merge Two Sorted Arrays

Merging sorted arrays is a fundamental operation used in divide-and-conquer algorithms.

### Problem
Write a function to merge two sorted arrays into one sorted array.

### Example
Input:  
Array 1: `[1, 3, 5]`  
Array 2: `[2, 4, 6]`

Output:  
Merged Array: `[1, 2, 3, 4, 5, 6]`

### Swift Implementation
```swift
func mergeSortedArrays(_ a: [Int], _ b: [Int]) -> [Int] {
    var merged = [Int]()
    var i = 0, j = 0
    while i < a.count && j < b.count {
        if a[i] < b[j] {
            merged.append(a[i])
            i += 1
        } else {
            merged.append(b[j])
            j += 1
        }
    }
    while i < a.count {
        merged.append(a[i])
        i += 1
    }
    while j < b.count {
        merged.append(b[j])
        j += 1
    }
    return merged
}
```

### Explanation
1. **Two Pointers**: Use two pointers to traverse the arrays.
2. **Compare Elements**: Append the smaller element to the result array.
3. **Merge Remaining Elements**: Append any remaining elements from either array.

---

## Transpose a Matrix

Transposing a matrix involves flipping rows and columns.

### Problem
Write a function to transpose a given matrix.

### Example
Input:  
Matrix:  
```
[[1, 2, 3],
 [4, 5, 6]]
```

Output:  
Transposed Matrix:  
```
[[1, 4],
 [2, 5],
 [3, 6]]
```

### Swift Implementation
```swift
func transpose(_ matrix: [[Int]]) -> [[Int]] {
    guard let firstRow = matrix.first else { return [] }
    var transposed = Array(repeating: Array(repeating: 0, count: matrix.count), count: firstRow.count)
    for (i, row) in matrix.enumerated() {
        for (j, val) in row.enumerated() {
            transposed[j][i] = val
        }
    }
    return transposed
}
```

### Explanation
1. **Empty Matrix Check**: Return an empty matrix if the input is empty.
2. **Transpose Logic**: Flip rows and columns using nested loops.
3. **Result**: Return the new transposed matrix.

---

Array manipulations are a cornerstone of solving algorithmic problems. Practicing these operations will help you develop a strong foundation for tackling more complex challenges!
