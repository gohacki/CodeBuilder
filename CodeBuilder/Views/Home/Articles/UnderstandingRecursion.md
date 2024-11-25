
# Understanding Recursion

Recursion is a method where the solution to a problem depends on solving smaller instances of the same problem.

## How It Works

In recursion, a function calls itself with a simpler or smaller input. Each recursive call brings the problem closer to a base case, which stops the recursion.

## Example: Factorial in Swift

```swift
func factorial(_ n: Int) -> Int {
    if n <= 1 {
        return 1 // Base case
    }
    return n * factorial(n - 1) // Recursive case
}

```

## Factorial Calculation:

factorial(3) → 3 * factorial(2)
factorial(2) → 2 * factorial(1)
factorial(1) → 1 (base case)


## When to Use Recursion

Recursion is useful when:

Problems can be broken down into smaller, similar sub-problems.
Iterative solutions are less intuitive or require additional data structures.
