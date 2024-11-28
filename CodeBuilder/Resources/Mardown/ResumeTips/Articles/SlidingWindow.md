
# Sliding Window Technique

The sliding window technique is an efficient method used to solve problems involving substrings or subarrays in arrays and strings. It reduces the time complexity of brute-force solutions by using a dynamic range to process elements.

---

## Longest Substring Without Repeating Characters

Finding the longest substring without repeating characters is a common sliding window problem.

### Problem
Write a function to find the length of the longest substring without repeating characters.

### Example
Input:  
String: `"abcabcbb"`

Output:  
`3` (The substring is `"abc"`)

### Swift Implementation
```swift
func lengthOfLongestSubstring(_ s: String) -> Int {
    var charIndexMap = [Character: Int]()
    var maxLength = 0
    var start = 0

    for (i, char) in s.enumerated() {
        if let index = charIndexMap[char], index >= start {
            start = index + 1
        }
        charIndexMap[char] = i
        maxLength = max(maxLength, i - start + 1)
    }

    return maxLength
}
```

### Explanation
1. **Tracking Characters**: Use a dictionary `charIndexMap` to store the most recent index of each character.
2. **Sliding the Window**: Adjust the `start` pointer whenever a repeated character is found within the current window.
3. **Update Maximum Length**: Calculate the maximum length of the substring in each iteration.

---

## Maximum Sum Subarray of Fixed Size

Finding the maximum sum of a subarray of a fixed size `k` is another sliding window problem.

### Problem
Write a function to find the maximum sum of a subarray of size `k`.

### Example
Input:  
Array: `[2, 1, 5, 1, 3, 2]`  
`k = 3`

Output:  
`9` (The subarray is `[5, 1, 3]`)

### Swift Implementation
```swift
func maxSumSubarray(_ arr: [Int], k: Int) -> Int {
    guard arr.count >= k else { return 0 }

    var maxSum = 0
    var windowSum = 0

    for i in 0..<k {
        windowSum += arr[i]
    }
    maxSum = windowSum

    for i in k..<arr.count {
        windowSum += arr[i] - arr[i - k]
        maxSum = max(maxSum, windowSum)
    }

    return maxSum
}
```

### Explanation
1. **Initialize Window Sum**: Compute the sum of the first `k` elements.
2. **Slide the Window**: Add the next element and subtract the first element of the previous window.
3. **Update Maximum**: Track the maximum sum encountered.

---

## Minimum Window Substring

Finding the smallest substring containing all characters of another string is a more advanced sliding window problem.

### Problem
Write a function to find the minimum window substring containing all characters of a target string.

### Example
Input:  
String: `"ADOBECODEBANC"`  
Target: `"ABC"`

Output:  
`"BANC"`

### Swift Implementation
```swift
func minWindow(_ s: String, _ t: String) -> String {
    var dictT = [Character: Int]()
    for char in t {
        dictT[char, default: 0] += 1
    }

    var left = 0
    var right = 0
    var formed = 0
    let required = dictT.count
    var windowCounts = [Character: Int]()
    var ans: (length: Int, left: Int, right: Int) = (Int.max, 0, 0)

    while right < s.count {
        let char = s[s.index(s.startIndex, offsetBy: right)]
        windowCounts[char, default: 0] += 1

        if let count = dictT[char], windowCounts[char] == count {
            formed += 1
        }

        while left <= right && formed == required {
            if right - left + 1 < ans.length {
                ans = (right - left + 1, left, right)
            }

            let leftChar = s[s.index(s.startIndex, offsetBy: left)]
            windowCounts[leftChar]! -= 1
            if let count = dictT[leftChar], windowCounts[leftChar]! < count {
                formed -= 1
            }
            left += 1
        }

        right += 1
    }

    return ans.length == Int.max ? "" : String(s[s.index(s.startIndex, offsetBy: ans.left)...s.index(s.startIndex, offsetBy: ans.right)])
}
```

### Explanation
1. **Tracking Frequencies**: Use a dictionary to track the frequency of characters in the target string.
2. **Expand and Contract**: Expand the `right` pointer to include characters and contract the `left` pointer to minimize the window size while maintaining validity.
3. **Store Result**: Update the result whenever a valid window is found.

---

The sliding window technique optimizes problems by reducing redundant computations, making it a must-know approach for competitive programming and coding interviews!
