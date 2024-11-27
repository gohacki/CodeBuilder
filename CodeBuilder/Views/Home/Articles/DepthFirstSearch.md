
# Depth-First Search (DFS)

Depth-First Search (DFS) is a graph traversal algorithm used to explore all nodes and edges in a graph or tree. It works by starting at a root node and exploring as far as possible along each branch before backtracking.

---

## How DFS Works

1. **Start at the Root**: Begin at a designated starting node.
2. **Traverse Deep**: Move to adjacent nodes recursively until no more unvisited nodes are available.
3. **Backtrack**: Return to the previous node to explore other paths.

DFS can be implemented using either recursion or an explicit stack.

---

## Recursive Implementation of DFS

### Problem
Traverse all nodes in a graph using DFS.

### Example
```swift
func dfs(_ node: Int, _ graph: [[Int]], _ visited: inout [Bool]) {
    visited[node] = true
    print("Visited node: \(node)")

    for neighbor in graph[node] {
        if !visited[neighbor] {
            dfs(neighbor, graph, &visited)
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
var visited = Array(repeating: false, count: graph.count)
dfs(0, graph, &visited)
```

### Explanation
1. **Visited Array**: Track nodes that have been visited to avoid infinite loops.
2. **Recursive Calls**: For each unvisited neighbor, recursively call DFS.

---

## Iterative Implementation of DFS

### Problem
Traverse all nodes using an explicit stack.

### Example
```swift
func iterativeDFS(_ start: Int, _ graph: [[Int]]) {
    var stack = [start]
    var visited = Array(repeating: false, count: graph.count)

    while !stack.isEmpty {
        let node = stack.removeLast()
        if !visited[node] {
            visited[node] = true
            print("Visited node: \(node)")

            for neighbor in graph[node].reversed() {
                if !visited[neighbor] {
                    stack.append(neighbor)
                }
            }
        }
    }
}

// Example Usage
let graph = [
    [1, 2],
    [0, 3, 4],
    [0],
    [1],
    [1]
]
iterativeDFS(0, graph)
```

### Explanation
1. **Stack Usage**: Use a stack to simulate recursion.
2. **Visit Nodes**: Pop nodes from the stack and mark them as visited.
3. **Add Neighbors**: Push unvisited neighbors to the stack.

---

## Applications of DFS

1. **Cycle Detection**:
   - Detect cycles in undirected or directed graphs.
   ```swift
   func hasCycle(_ node: Int, _ parent: Int, _ graph: [[Int]], _ visited: inout [Bool]) -> Bool {
       visited[node] = true
       for neighbor in graph[node] {
           if !visited[neighbor] {
               if hasCycle(neighbor, node, graph, &visited) {
                   return true
               }
           } else if neighbor != parent {
               return true
           }
       }
       return false
   }
   ```

2. **Path Finding**:
   - Determine if a path exists between two nodes.

3. **Topological Sorting**:
   - Order nodes in a Directed Acyclic Graph (DAG).

4. **Connected Components**:
   - Identify clusters of connected nodes.

---

## Complexity of DFS

1. **Time Complexity**:
   - O(V + E), where V is the number of vertices and E is the number of edges.
2. **Space Complexity**:
   - O(V) for the recursion stack or explicit stack.

---

Depth-First Search is a versatile algorithm used in a variety of problems, including graph traversal, pathfinding, and detecting cycles. Understanding DFS is essential for solving many graph-related challenges efficiently.

