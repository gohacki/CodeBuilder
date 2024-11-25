
# Linked List Manipulations

A linked list is a linear data structure where each element (node) points to the next. Linked lists are widely used in scenarios where dynamic memory allocation and efficient insertions/deletions are required.

---

## Remove Nth Node from End

Removing the Nth node from the end of a linked list involves identifying the node’s position and updating the links accordingly.

### Problem
Write a function to remove the Nth node from the end of a linked list.

### Example
Input:  
Linked List: `1 -> 2 -> 3 -> 4 -> 5`  
N: `2`

Output:  
Linked List: `1 -> 2 -> 3 -> 5`

### Swift Implementation
```swift
class ListNode {
    var val: Int
    var next: ListNode?
    init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
    let dummy = ListNode(0)
    dummy.next = head
    var first: ListNode? = dummy
    var second: ListNode? = dummy
    for _ in 0..<n+1 {
        first = first?.next
    }
    while first != nil {
        first = first?.next
        second = second?.next
    }
    second?.next = second?.next?.next
    return dummy.next
}
```

### Explanation
1. **Dummy Node**: Use a dummy node to simplify edge cases, such as removing the first node.
2. **Two Pointers**: Maintain two pointers (`first` and `second`) separated by `n + 1` nodes.
3. **Traversal**: Move both pointers until `first` reaches the end. The `second` pointer will then be at the node before the target node.
4. **Remove Node**: Update the `next` pointer of `second` to skip the target node.

---

## Merge Two Sorted Linked Lists

Merging two sorted linked lists involves creating a new sorted list by selecting the smallest nodes from each input list.

### Problem
Write a function to merge two sorted linked lists.

### Example
Input:  
List 1: `1 -> 3 -> 5`  
List 2: `2 -> 4 -> 6`

Output:  
Merged List: `1 -> 2 -> 3 -> 4 -> 5 -> 6`

### Swift Implementation
```swift
func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
    let dummy = ListNode(0)
    var current = dummy
    var l1 = list1
    var l2 = list2

    while l1 != nil && l2 != nil {
        if l1!.val < l2!.val {
            current.next = l1
            l1 = l1?.next
        } else {
            current.next = l2
            l2 = l2?.next
        }
        current = current.next!
    }

    current.next = l1 ?? l2
    return dummy.next
}
```

### Explanation
1. **Dummy Node**: Use a dummy node to simplify the merging process.
2. **Comparison**: Compare the values of the current nodes in both lists and append the smaller one to the result.
3. **Merge Remaining Nodes**: Append any remaining nodes from one of the lists.

---

## Detect a Cycle in a Linked List

Detecting a cycle in a linked list is a classic problem in algorithmic challenges.

### Problem
Write a function to detect if a linked list contains a cycle.

### Example
Input:  
Linked List: `1 -> 2 -> 3 -> 4 -> 2 (cycle)`

Output:  
`true` (Cycle exists)

### Swift Implementation
```swift
func hasCycle(_ head: ListNode?) -> Bool {
    var slow = head
    var fast = head

    while fast != nil && fast?.next != nil {
        slow = slow?.next
        fast = fast?.next?.next
        if slow === fast {
            return true
        }
    }
    return false
}
```

### Explanation
1. **Two Pointers**: Use a slow pointer (moves 1 step at a time) and a fast pointer (moves 2 steps at a time).
2. **Cycle Detection**: If the pointers meet, a cycle exists.
3. **Termination**: If the `fast` pointer reaches the end of the list, there’s no cycle.

---

## Reverse a Linked List

Reversing a linked list involves reassigning the `next` pointers of each node to point to the previous node.

### Problem
Write a function to reverse a linked list.

### Example
Input:  
Linked List: `1 -> 2 -> 3 -> 4 -> 5`

Output:  
Reversed Linked List: `5 -> 4 -> 3 -> 2 -> 1`

### Swift Implementation
```swift
func reverseList(_ head: ListNode?) -> ListNode? {
    var prev: ListNode? = nil
    var current = head

    while current != nil {
        let next = current?.next
        current?.next = prev
        prev = current
        current = next
    }

    return prev
}
```

### Explanation
1. **Three Pointers**: Use `prev`, `current`, and `next` to manage the reversal process.
2. **Reassign Pointers**: Update the `next` pointer of each node to point to the previous node.
3. **Return Result**: Return the new head of the reversed list.

---

Linked list manipulations are crucial for solving problems in dynamic memory allocation and pointer-based operations. Practice these patterns to strengthen your algorithmic skills!
