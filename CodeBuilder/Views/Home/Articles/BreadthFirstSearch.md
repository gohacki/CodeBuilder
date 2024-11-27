
# Breadth-First Search (BFS)

Breadth-First Search (BFS) is a graph traversal algorithm that explores all neighbors at the current depth level before moving to nodes at the next depth level. It is particularly useful for finding the shortest path in an unweighted graph.

---

## How BFS Works

1. **Start at the Root**: Begin at the starting node.
2. **Explore Neighbors**: Visit all adjacent nodes at the current depth.
3. **Use a Queue**: Keep track of nodes to visit using a queue.

BFS ensures that nodes are explored level by level, making it ideal for finding the shortest path in unweighted graphs.

---

## Iterative Implementation of BFS

### Problem
Traverse all nodes in a graph using BFS.

### Example
```swift
func bfs(_ start: Int, _ graph: [[Int]]) {
    var visited = Array(repeating: false, count: graph.count)
    var queue = [start]

    visited[start] = true

    while !queue.isEmpty {
        let node = queue.removeFirst()
        print("Visited node: \(node)")

        for neighbor in graph[node] {
            if !visited[neighbor] {
                visited[neighbor] = true
                queue.append(neighbor)
            }
        }
    }
}

// Example Usage
let graph = [
    [1, 2],    // Node 0 is connected to nodes 1 and 2
    [0, 3, 4], // Node 1 is connected to nodes 0, 3, and 4
    [0],       // Node 2 is connected to node 0
    [1],       // Node 3 is connected to node 1
    [1]        // Node 4 is connected to node 1
]
bfs(0, graph)
```

### Explanation
1. **Visited Array**: Keeps track of nodes that have already been visited.
2. **Queue**: Ensures nodes are visited in the correct order (FIFO).
3. **Node Exploration**: For each node, add its unvisited neighbors to the queue.

---

## Applications of BFS

1. **Shortest Path in Unweighted Graphs**:
   BFS finds the shortest path by exploring all nodes at the current depth before moving deeper.

   Example:
   ```swift
   func shortestPath(_ start: Int, _ end: Int, _ graph: [[Int]]) -> Int {
       var visited = Array(repeating: false, count: graph.count)
       var queue: [(node: Int, distance: Int)] = [(start, 0)]

       visited[start] = true

       while !queue.isEmpty {
           let (node, distance) = queue.removeFirst()

           if node == end {
               return distance
           }

           for neighbor in graph[node] {
               if !visited[neighbor] {
                   visited[neighbor] = true
                   queue.append((neighbor, distance + 1))
               }
           }
       }

       return -1 // Path not found
   }
   ```

2. **Connected Components**:
   BFS can determine clusters of connected nodes in a graph.

3. **Cycle Detection**:
   Detect if a cycle exists in an undirected graph.

4. **Level-Order Traversal in Trees**:
   BFS is used to traverse trees level by level.

---

## Complexity of BFS

1. **Time Complexity**:
   - O(V + E), where V is the number of vertices and E is the number of edges.
2. **Space Complexity**:
   - O(V) for the queue and visited array.

---

Breadth-First Search is a foundational algorithm in graph theory, offering efficient solutions for pathfinding, connectivity, and traversal problems. Mastering BFS equips you to tackle a wide range of graph-related challenges.

