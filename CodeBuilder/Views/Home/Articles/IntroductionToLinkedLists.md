

# Introduction to Linked Lists

A linked list is a linear data structure in which elements (called nodes) are linked together using pointers. Unlike arrays, linked lists do not store elements in contiguous memory locations, making them highly dynamic and efficient for certain operations.

---

## What is a Linked List?

A linked list consists of nodes, where each node contains:
1. **Data**: The actual value stored in the node.
2. **Next Pointer**: A reference to the next node in the sequence.

### Types of Linked Lists
- **Singly Linked List**: Each node points to the next node, and the last node points to `null`.
- **Doubly Linked List**: Each node has pointers to both the next and the previous nodes.
- **Circular Linked List**: The last node points back to the head, forming a circle.

---

## Advantages of Linked Lists

1. **Dynamic Size**: Unlike arrays, linked lists can grow or shrink dynamically without the need for resizing.
2. **Efficient Insertions/Deletions**: Adding or removing nodes is efficient since no shifting of elements is required.
3. **Memory Utilization**: Memory is allocated as needed, avoiding wasted space.

---

## Common Operations

### 1. Traversal
Visiting each node in the list:
```swift
class ListNode {
    var value: Int
    var next: ListNode?
    init(_ value: Int) {
        self.value = value
    }
}

func traverseLinkedList(_ head: ListNode?) {
    var current = head
    while current != nil {
        print(current!.value)
        current = current?.next
    }
}
```

### 2. Insertion
Adding a new node at the beginning, middle, or end:
```swift
func insertAtHead(_ head: inout ListNode?, value: Int) {
    let newNode = ListNode(value)
    newNode.next = head
    head = newNode
}
```

### 3. Deletion
Removing a node from the list:
```swift
func deleteNode(_ head: inout ListNode?, value: Int) {
    var current = head
    var prev: ListNode? = nil

    while current != nil && current!.value != value {
        prev = current
        current = current?.next
    }

    if current == nil {
        print("Value not found")
        return
    }

    if prev == nil {
        head = current?.next // Delete head node
    } else {
        prev?.next = current?.next // Remove node
    }
}
```

---

## Real-World Applications of Linked Lists

1. **Dynamic Memory Management**: Used in operating systems for memory allocation (e.g., free lists).
2. **Implementing Data Structures**: Used to create stacks, queues, and hash tables.
3. **Undo/Redo Functionality**: Used in text editors and software to maintain a history of operations.

---

Linked lists are a versatile and fundamental data structure, making them an essential tool for solving problems that require dynamic memory and efficient insertions/deletions.
