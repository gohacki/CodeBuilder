
# Two-Pointer Technique

The two-pointer technique is a powerful and efficient approach used to solve problems involving arrays or strings. It involves using two pointers to traverse or manipulate data in a single pass, reducing the time complexity compared to brute-force solutions.

---

## How the Two-Pointer Technique Works

1. **Initialization**:
   - Place one pointer at the start of the array (or string) and the other at the end, or both at specific positions.
2. **Movement**:
   - Move the pointers toward or away from each other based on certain conditions.
3. **Goal**:
   - Solve the problem by processing the data between the pointers.

---

## Common Applications of the Two-Pointer Technique

### 1. **Finding a Pair with a Given Sum**

### Problem
Find two numbers in a sorted array that sum up to a target value.

### Example
Input:  
Array: `[1, 2, 3, 4, 6]`, Target: `6`

Output:  
Pair: `(2, 4)`

### Swift Implementation
```swift
func findPairWithSum(_ arr: [Int], _ target: Int) -> (Int, Int)? {
    var left = 0
    var right = arr.count - 1

    while left < right {
        let sum = arr[left] + arr[right]
        if sum == target {
            return (arr[left], arr[right])
        } else if sum < target {
            left += 1
        } else {
            right -= 1
        }
    }
    return nil
}
```

### Explanation
1. Start with one pointer at the beginning (`left`) and another at the end (`right`).
2. Calculate the sum of the elements at the two pointers.
3. Adjust the pointers:
   - If the sum is less than the target, move `left` to the right.
   - If the sum is greater, move `right` to the left.

---

### 2. **Removing Duplicates in Place**

### Problem
Remove duplicates from a sorted array in place, returning the new length.

### Example
Input:  
Array: `[1, 1, 2, 2, 3, 4, 4]`

Output:  
New Length: `4`, Array: `[1, 2, 3, 4]`

### Swift Implementation
```swift
func removeDuplicates(_ arr: inout [Int]) -> Int {
    if arr.isEmpty { return 0 }
    var index = 0

    for i in 1..<arr.count {
        if arr[i] != arr[index] {
            index += 1
            arr[index] = arr[i]
        }
    }
    return index + 1
}
```

### Explanation
1. Use one pointer to track the last unique element (`index`).
2. Iterate through the array with a second pointer.
3. Replace duplicates with unique elements as needed.

---

### 3. **Trapping Rainwater**

### Problem
Calculate the amount of rainwater that can be trapped between bars of different heights.

### Example
Input:  
Array: `[0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]`

Output:  
Trapped Water: `6`

### Swift Implementation
```swift
func trapRainWater(_ heights: [Int]) -> Int {
    var left = 0
    var right = heights.count - 1
    var leftMax = 0
    var rightMax = 0
    var waterTrapped = 0

    while left < right {
        if heights[left] < heights[right] {
            if heights[left] >= leftMax {
                leftMax = heights[left]
            } else {
                waterTrapped += leftMax - heights[left]
            }
            left += 1
        } else {
            if heights[right] >= rightMax {
                rightMax = heights[right]
            } else {
                waterTrapped += rightMax - heights[right]
            }
            right -= 1
        }
    }
    return waterTrapped
}
```

### Explanation
1. Use two pointers to traverse the array from both ends.
2. Keep track of the maximum height on the left and right.
3. Calculate trapped water based on the minimum of the two maximums.

---

## Complexity of the Two-Pointer Technique

1. **Time Complexity**:
   - Most two-pointer solutions run in O(n) because each pointer moves through the array at most once.
2. **Space Complexity**:
   - O(1), as the technique does not require additional space for traversal.

---

The two-pointer technique is a versatile tool for solving a variety of problems involving arrays or strings efficiently. By mastering this approach, you can tackle many algorithmic challenges with confidence.

