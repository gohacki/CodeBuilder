
# Searching and Sorting

Searching and sorting are critical concepts in computer science, used for organizing and retrieving data efficiently. Mastering these operations is essential for writing performant and scalable applications.

---

## Binary Search

Binary search is a highly efficient algorithm for finding an element in a sorted array. It works by repeatedly dividing the search interval in half.

### Problem
Write a function that performs binary search on a sorted array.

### Example
Input:
Array: `[1, 3, 5, 7, 9]`
Target: `5`

Output:
`2` (Index of the target element)

### Swift Implementation
```swift
func binarySearch(_ arr: [Int], target: Int) -> Int? {
    var left = 0
    var right = arr.count - 1
    while left <= right {
        let mid = left + (right - left) / 2
        if arr[mid] == target {
            return mid
        } else if arr[mid] < target {
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    return nil
}
```

### Explanation
1. **Initialize Pointers**: Start with pointers `left` and `right` representing the bounds of the search interval.
2. **Calculate Midpoint**: Use `(left + right) / 2` to find the middle index.
3. **Adjust Bounds**: Narrow the search interval based on comparisons with the target.
4. **Return Result**: If the target is found, return its index; otherwise, return `nil`.

---

## Bubble Sort

Bubble sort is a simple sorting algorithm that repeatedly steps through the list, compares adjacent elements, and swaps them if they are in the wrong order.

### Problem
Write a function to sort an array using the bubble sort algorithm.

### Example
Input:
Array: `[5, 3, 8, 4, 2]`

Output:
Array: `[2, 3, 4, 5, 8]`

### Swift Implementation
```swift
func bubbleSort(_ arr: inout [Int]) {
    let n = arr.count
    for i in 0..<n {
        for j in 0..<(n - i - 1) {
            if arr[j] > arr[j + 1] {
                arr.swapAt(j, j + 1)
            }
        }
    }
}
```

### Explanation
1. **Outer Loop**: Controls the number of passes.
2. **Inner Loop**: Compares adjacent elements and swaps them if necessary.
3. **Optimization**: After each pass, the largest unsorted element is in its correct position.

---

## Find the Second Largest Element

Finding the second largest element is a common problem in competitive programming and algorithmic challenges.

### Problem
Write a function to find the second largest element in an array.

### Example
Input:
Array: `[5, 8, 12, 7, 9]`

Output:
`9` (Second largest element)

### Swift Implementation
```swift
func secondLargest(_ arr: [Int]) -> Int? {
    var first: Int? = nil
    var second: Int? = nil
    for num in arr {
        if first == nil || num > first! {
            second = first
            first = num
        } else if (second == nil || num > second!) && num != first {
            second = num
        }
    }
    return second
}
```

### Explanation
1. **Initialization**: Use two variables `first` and `second` to track the largest and second largest elements.
2. **Update Logic**: Update `first` and `second` as you iterate through the array.
3. **Return Result**: Return `second`, which contains the second largest element.

---

## Merge Sorted Arrays

Merging sorted arrays is a fundamental operation in divide-and-conquer algorithms like merge sort.

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
1. **Pointers**: Use two pointers to track the current index of each array.
2. **Comparison**: Compare the elements at the pointers and append the smaller one to the result.
3. **Merge Remaining Elements**: Append any remaining elements from either array.

---

Searching and sorting are foundational techniques that form the basis for more advanced algorithms. Practicing these operations will significantly enhance your problem-solving skills!
