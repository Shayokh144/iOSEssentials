# SwiftUI Modern Concurrency — Actors, MainActor, CPU-Intensive Work

## Contents

1. Main Actor vs Main Thread
2. What is an Actor?
3. What are actors?
4. What can we do with actors?
5. Why actors are used and how to use them
6. Why MainActor is special
7. Problems without actors and how actors solve them
8. Best practices for actors
9. `@MainActor` on a whole ViewModel vs a single method
10. How to manage CPU-heavy synchronous work
11. Best way to run CPU-intensive work in modern SwiftUI
12. Why `await apiCall()` is okay but CPU-heavy `await` work is not
13. `Task.detached` explained step by step

---

# 1. Main Actor vs Main Thread

### Question

In SwiftUI what is the difference between Main Actor and Main Thread?

### Answer

The simplest way to think about it:

> **Main Thread = a physical execution thread.**  
> **Main Actor = a Swift concurrency isolation mechanism.**

## Main Thread

The main thread is an actual thread managed by the operating system.

UIKit and SwiftUI perform UI work on the main thread.

For example:

```swift
DispatchQueue.main.async {
    // Runs on the main thread
}
```

You can check it with:

```swift
Thread.isMainThread
```

So:

```swift
print(Thread.isMainThread)
```

tells you whether the current code is executing on the main thread.

## Main Actor

`@MainActor` is part of Swift Concurrency.

It tells Swift:

> "This code must be isolated to the Main Actor."

For example:

```swift
@MainActor
final class MyViewModel {
    var title = ""

    func updateTitle() {
        title = "Hello"
    }
}
```

Or:

```swift
@MainActor
func updateUI() {
    // Main-actor isolated code
}
```

The important point is that **Main Actor is not simply another name for Main Thread**.

An actor is a concurrency construct that provides **isolation**. It prevents multiple concurrent tasks from accessing actor-isolated state in an unsafe way.

## Why do they seem like the same thing?

Because the Main Actor is generally associated with the main thread.

For example:

```swift
@MainActor
func updateUI() {
    print(Thread.isMainThread)
}
```

You will normally see:

```text
true
```

So in practical iOS development:

```swift
@MainActor
```

usually means:

> "Run this UI-related work on the main actor, which is serviced by the main thread."

But conceptually, they are different.

## Important difference

### GCD

```swift
DispatchQueue.main.async {
    self.title = "Hello"
}
```

You're explicitly saying:

> Execute this closure on the main dispatch queue.

### Swift Concurrency

```swift
@MainActor
func updateTitle() {
    title = "Hello"
}
```

You're saying:

> This function is isolated to the Main Actor.

This gives the compiler much more information about concurrency.

## SwiftUI example

```swift
@Observable
@MainActor
final class UserViewModel {
    var name = ""

    func loadUser() async {
        let user = await api.fetchUser()
        name = user.name
    }
}
```

When this reaches:

```swift
await api.fetchUser()
```

the task can suspend while the network operation happens.

The main thread is therefore free to do other work.

When the network operation completes, execution resumes and:

```swift
name = user.name
```

happens with Main Actor isolation.

## Mental model

```text
             Swift Concurrency
                    │
                 Actor
                    │
              Main Actor
                    │
          ┌─────────┴─────────┐
          │                   │
     UI/state isolation    Scheduling
                              │
                         Main Thread
```

Do not interpret this as "Main Actor = Main Thread."

Instead:

> **Main Thread is a thread. Main Actor is a concurrency isolation domain.**

---

# 2. What is an Actor?

### Question

Explain with code example:

- What is actor
- What are the actors
- What can we do with actors
- Why they are used and how to use them
- Why MainActor is special
- What problem can occur if we do not use actor, and how actor can solve them
- What are the best practices of using actor

### Answer

The easiest way to understand Swift actors is to start with the problem they solve:

> **Shared mutable state accessed concurrently.**

## What is an Actor?

An `actor` is a Swift concurrency type that **protects its mutable state from concurrent access**.

Think of an actor as:

> A class whose mutable data can only be accessed safely through the actor's isolation boundary.

Example:

```swift
actor BankAccount {
    private var balance = 0

    func deposit(_ amount: Int) {
        balance += amount
    }

    func withdraw(_ amount: Int) {
        balance -= amount
    }

    func getBalance() -> Int {
        balance
    }
}
```

Use it like this:

```swift
let account = BankAccount()

Task {
    await account.deposit(100)
    let balance = await account.getBalance()

    print(balance)
}
```

Notice:

```swift
await account.deposit(100)
```

Because `BankAccount` is an actor, Swift needs to respect its isolation boundary.

---

# 3. What Problem Are Actors Solving?

Imagine a normal class:

```swift
final class BankAccount {
    var balance = 0

    func deposit(_ amount: Int) {
        balance += amount
    }
}
```

Now two tasks access it concurrently:

```swift
let account = BankAccount()

Task {
    account.deposit(100)
}

Task {
    account.deposit(100)
}
```

You might expect:

```text
Task 1 → balance = 100
Task 2 → balance = 200
```

But:

```swift
balance += 100
```

is conceptually:

```text
read balance
    ↓
add 100
    ↓
write balance
```

Two tasks could interleave:

```text
Task 1: read balance = 0
Task 2: read balance = 0

Task 1: calculate 100
Task 2: calculate 100

Task 1: write 100
Task 2: write 100
```

Final result:

```text
100
```

instead of:

```text
200
```

This is a **data race**.

---

# 4. How Does Actor Solve This?

Change the class to an actor:

```swift
actor BankAccount {
    private var balance = 0

    func deposit(_ amount: Int) {
        balance += amount
    }
}
```

Then:

```swift
let account = BankAccount()

Task {
    await account.deposit(100)
}

Task {
    await account.deposit(100)
}
```

The actor ensures that access to its isolated state is properly serialized.

Conceptually:

```text
                BankAccount Actor
                       │
              ┌────────┴────────┐
              │                 │
           Task 1             Task 2
              │                 │
              └───────┬─────────┘
                      ↓
                ┌───────────┐
                │ balance   │
                └───────────┘
                      ↑
               protected state
```

The operations effectively become:

```text
Task 1 → balance 0 → 100
Task 2 → balance 100 → 200
```

---

# 5. What Exactly Is Protected?

Consider:

```swift
actor Counter {
    private var value = 0

    func increment() {
        value += 1
    }

    func getValue() -> Int {
        value
    }
}
```

`value` is **actor-isolated state**.

Code outside the actor cannot freely access it.

For example:

```swift
actor Counter {
    var value = 0
}
```

Then:

```swift
Task {
    print(counter.value) // actor-isolated property
}
```

requires crossing the actor boundary:

```swift
Task {
    print(await counter.value)
}
```

The `await` acknowledges:

> "I'm crossing the actor's isolation boundary."

---

# 6. What Are "The Actors"?

There are several important concepts.

## Regular Actor

You create your own:

```swift
actor ImageCache {
    private var images: [String: UIImage] = [:]

    func store(_ image: UIImage, for key: String) {
        images[key] = image
    }

    func image(for key: String) -> UIImage? {
        images[key]
    }
}
```

## MainActor

Swift provides a special global actor:

```swift
@MainActor
```

Example:

```swift
@MainActor
final class UserViewModel {
    var username = ""

    func updateUsername(_ username: String) {
        self.username = username
    }
}
```

The Main Actor is the actor associated with UI/main-actor work.

## Global Actors

Swift allows global actors.

`MainActor` is one of them.

You can define your own:

```swift
@globalActor
actor DatabaseActor {
    static let shared = DatabaseActor()
}
```

Then:

```swift
@DatabaseActor
final class DatabaseManager {
    // ...
}
```

Now the class is isolated to your custom global actor.

---

# 7. What Can We Do With Actors?

Actors are particularly useful for objects that own **mutable state**.

## Image cache

```swift
actor ImageCache {
    private var cache: [URL: UIImage] = [:]

    func set(_ image: UIImage, for url: URL) {
        cache[url] = image
    }

    func get(_ url: URL) -> UIImage? {
        cache[url]
    }
}
```

## Token manager

```swift
actor TokenManager {
    private var token: String?

    func save(_ token: String) {
        self.token = token
    }

    func getToken() -> String? {
        token
    }
}
```

## Download manager

```swift
actor DownloadManager {
    private var activeDownloads: Set<URL> = []

    func start(_ url: URL) {
        activeDownloads.insert(url)
    }

    func finish(_ url: URL) {
        activeDownloads.remove(url)
    }
}
```

## Database state

```swift
actor DatabaseManager {
    private var users: [User] = []

    func add(_ user: User) {
        users.append(user)
    }

    func allUsers() -> [User] {
        users
    }
}
```

The common characteristic is:

```text
                    Actor
                      │
                      ↓
              Mutable shared state
                      │
          ┌───────────┼───────────┐
          ↓           ↓           ↓
        Task A      Task B      Task C
```

The actor becomes the **owner of that state**.

---

# 8. Actors vs Classes

A normal class:

```swift
final class Counter {
    var value = 0
}
```

doesn't automatically protect `value` from concurrent access.

An actor:

```swift
actor Counter {
    var value = 0
}
```

does.

Before Swift Concurrency, you might use:

```swift
NSLock
NSRecursiveLock
DispatchQueue
DispatchSemaphore
```

For example:

```swift
final class Counter {
    private var value = 0
    private let lock = NSLock()

    func increment() {
        lock.lock()
        value += 1
        lock.unlock()
    }
}
```

With an actor:

```swift
actor Counter {
    private var value = 0

    func increment() {
        value += 1
    }
}
```

Much simpler.

---

# 9. Why Don't Actors Need Locks?

With a lock:

```text
Thread
  ↓
acquire lock
  ↓
modify state
  ↓
release lock
```

You manually manage synchronization.

With an actor:

```text
Task
 ↓
Actor isolation
 ↓
modify state
```

Swift's concurrency model handles the synchronization.

You don't normally need:

```swift
NSLock()
```

or:

```swift
DispatchQueue(label: "some.queue")
```

just to protect actor state.

---

# 10. Actor ≠ Thread

An actor is **not a thread**.

This:

```swift
actor ImageCache {
    // ...
}
```

doesn't mean:

> "ImageCache has its own dedicated thread."

Instead, Swift schedules actor-isolated work using the concurrency runtime.

Conceptually:

```text
                Swift Concurrency Runtime
                         │
             ┌───────────┴───────────┐
             ↓                       ↓
          Actor A                 Actor B
             │                       │
             └───────────┬───────────┘
                         ↓
                    Threads
                 managed by system
```

Actors are about **isolation**, not dedicated threads.

---

# 11. What Does `await` Mean?

Suppose:

```swift
actor Counter {
    var value = 0

    func increment() {
        value += 1
    }
}
```

Then:

```swift
let counter = Counter()

Task {
    await counter.increment()
}
```

`await` means the operation may need to **suspend while waiting for the actor**.

It does NOT mean:

> "Block this thread."

Conceptually:

```text
Task
 │
 ├── requests Counter actor
 │
 ├── actor currently busy
 │
 ├── Task suspends
 │
 │   Thread becomes available
 │
 ├── actor becomes available
 │
 └── Task resumes
```

---

# 12. Actor Reentrancy

Actors have an important gotcha: **reentrancy**.

Consider:

```swift
actor BankAccount {
    private var balance = 100

    func withdraw(_ amount: Int) async -> Bool {
        guard balance >= amount else {
            return false
        }

        await someAsyncOperation()

        balance -= amount

        return true
    }
}
```

At:

```swift
await someAsyncOperation()
```

the actor can become available for another task.

Possible sequence:

```text
Task A
  ↓
balance >= 100
  ↓
await
  ↓
        Task B
          ↓
       withdraw 100
          ↓
       balance = 0
  ↓
Task A resumes
  ↓
balance -= 100
```

This is called **actor reentrancy**.

Actors protect individual isolated operations, but an `await` creates a suspension point where other work can enter the actor.

---

# 13. `Sendable` and Actors

Actors protect mutable state. `Sendable` helps protect values crossing concurrency boundaries.

Example:

```swift
struct User: Sendable {
    let id: Int
    let name: String
}
```

Think:

```text
Actor
  ↓
protects mutable state

Sendable
  ↓
safe values across concurrency boundaries
```

These concepts work together.

---

# 14. Best Practices for Actors

## Keep actor state small

Good:

```swift
actor ImageCache {
    private var images: [URL: UIImage] = [:]

    func get(_ url: URL) -> UIImage? {
        images[url]
    }

    func save(_ image: UIImage, for url: URL) {
        images[url] = image
    }
}
```

Avoid:

```swift
actor EverythingManager {
    // networking
    // database
    // analytics
    // image cache
    // authentication
    // UI state
    // business logic
}
```

Prefer focused actors such as:

```text
ImageCacheActor
TokenManagerActor
DatabaseActor
DownloadManagerActor
```

rather than one giant actor.

## Don't use actors unnecessarily

If data is immutable:

```swift
struct User: Sendable {
    let id: Int
    let name: String
}
```

you may not need an actor.

Actors are particularly valuable for:

```text
shared
+
mutable
+
concurrently accessed
```

state.

## Use MainActor for UI state

```swift
@MainActor
@Observable
final class UserViewModel {
    var name = ""
    var isLoading = false
}
```

Use separate actors for shared non-UI mutable state:

```swift
actor UserCache {
    // ...
}
```

## Don't use `@MainActor` for everything

Putting a database or cache manager on Main Actor doesn't make it "better."

Instead:

```swift
actor DatabaseManager {
    // database state
}
```

while:

```swift
@MainActor
final class ViewModel {
    // UI state
}
```

## Don't block Main Actor

Avoid:

```swift
@MainActor
func loadData() {
    let data = expensiveCalculation()
    result = data
}
```

if the calculation takes a significant amount of CPU time.

---

# 15. `@MainActor` on a Whole ViewModel vs One Method

### Question

What is the difference between:

```swift
@MainActor
final class UserViewModel {
    var name = ""

    func updateName(_ name: String) {
        self.name = name
    }
}
```

and:

```swift
final class UserViewModel {
    var name = ""

    @MainActor
    func updateName(_ name: String) {
        self.name = name
    }
}
```

Which one should be used when?

### Answer

The key difference is **what gets isolated to the Main Actor**.

## `@MainActor` on the entire class

```swift
@MainActor
final class UserViewModel {
    var name = ""

    func updateName(_ name: String) {
        self.name = name
    }

    func clearName() {
        name = ""
    }
}
```

This means:

> **The entire instance is Main Actor-isolated.**

So `name` is Main Actor-isolated, and all instance methods are Main Actor-isolated.

Conceptually:

```text
UserViewModel
      │
      ├── name          → MainActor
      ├── updateName()  → MainActor
      └── clearName()   → MainActor
```

## `@MainActor` only on a method

```swift
final class UserViewModel {
    var name = ""

    @MainActor
    func updateName(_ name: String) {
        self.name = name
    }
}
```

Now only `updateName()` is Main Actor-isolated.

Conceptually:

```text
UserViewModel
      │
      ├── name          → NOT MainActor-isolated
      │
      └── updateName()  → MainActor
```

Other methods remain nonisolated.

```swift
final class UserViewModel {
    var name = ""

    @MainActor
    func updateName(_ name: String) {
        self.name = name
    }

    func calculateSomething() -> Int {
        return 10 + 20
    }
}
```

## Important consequence

With:

```swift
@MainActor
final class UserViewModel {
    var name = ""
}
```

the property itself is Main Actor-isolated.

With:

```swift
final class UserViewModel {
    var name = ""

    @MainActor
    func updateName(_ name: String) {
        self.name = name
    }
}
```

`name` itself isn't protected by Main Actor isolation.

Another method can access it:

```swift
func printName() {
    print(name)
}
```

That method isn't Main Actor-isolated.

## For SwiftUI ViewModels, usually prefer the whole class

```swift
@MainActor
@Observable
final class UserViewModel {
    var name = ""
    var isLoading = false
    var errorMessage: String?

    func loadUser() async {
        isLoading = true

        let user = await fetchUser()

        name = user.name
        isLoading = false
    }

    func clearError() {
        errorMessage = nil
    }
}
```

These properties represent UI state, so giving them the same isolation is usually appropriate.

## When method-level `@MainActor` makes sense

For a service:

```swift
final class SomeService {

    func performWork() async {
        // Doesn't need MainActor
    }

    @MainActor
    func updateUI() {
        // Needs MainActor
    }
}
```

The general rule:

> **If the object's state itself is UI state, use class-level `@MainActor`.**

> **If only a specific operation needs Main Actor isolation, use method-level `@MainActor`.**

---

# 16. How to Manage CPU-Heavy Synchronous Work

### Question

How to manage CPU-heavy synchronous work properly?

Example:

```swift
@MainActor
final class UserViewModel {

    func processHugeDataset(_ data: [Data]) {
        // 5 seconds of CPU-heavy synchronous work
    }
}
```

### Answer

The goal is:

> **Keep UI state on `@MainActor`, but move CPU-heavy computation outside the Main Actor.**

A useful architecture is:

```text
              MainActor
                  │
                  │ start processing
                  ↓
          ┌─────────────────┐
          │ CPU-heavy work  │
          │  outside actor  │
          └────────┬────────┘
                   │
                   │ result
                   ↓
              MainActor
                   │
                   ↓
              Update UI
```

## Separate the CPU-heavy processor

```swift
struct DataProcessor: Sendable {

    func process(_ data: [Data]) -> ProcessedResult {
        // CPU-heavy work
    }
}
```

Then:

```swift
@MainActor
final class UserViewModel {

    var result: ProcessedResult?
    var isProcessing = false

    private let processor = DataProcessor()

    func process(_ data: [Data]) async {
        isProcessing = true

        let result = await Task.detached {
            processor.process(data)
        }.value

        self.result = result
        isProcessing = false
    }
}
```

However, `Task.detached` should be used deliberately rather than as a generic "background thread" API.

## Network/I/O vs CPU work

### Asynchronous I/O

Examples:

```swift
await api.fetchUsers()
await database.loadUsers()
await URLSession.shared.data(for: request)
```

These generally don't require manually moving to a background thread.

### CPU-heavy synchronous work

Examples:

```swift
for _ in 0..<10_000_000 {
    // calculations
}
```

or:

```swift
imageProcessing()
```

or:

```swift
machineLearningInference()
```

or:

```swift
largeJSONTransformation()
```

These can consume CPU continuously and shouldn't run synchronously on Main Actor.

---

# 17. `Task {}` Is Not Automatically a Background Task

You might write:

```swift
@MainActor
func process(_ data: [Data]) {
    Task {
        let result = expensiveCalculation(data)
        self.result = result
    }
}
```

Be careful.

`Task {}` inherits the surrounding actor context.

Since you're inside `@MainActor`, it can inherit Main Actor isolation.

So:

```swift
Task {
    expensiveCalculation()
}
```

doesn't mean:

> "Run this on a background thread."

Conceptually:

```text
@MainActor
    │
    └── Task { }
           │
           └── inherits MainActor
                    │
                    ↓
             CPU-heavy work
```

---

# 18. `Task.detached`

If you explicitly need to leave the current actor context:

```swift
Task.detached {
    expensiveCalculation()
}
```

A detached task does not inherit the current actor context.

Conceptually:

```text
                  MainActor
                     │
                     │ Task.detached
                     ↓
              Swift runtime
              thread pool
                     │
                     ↓
              CPU-heavy work
```

But `Task.detached` has trade-offs. It does not inherit the surrounding actor isolation, task-local values, or cancellation relationship in the same structured way.

Use it deliberately.

---

# 19. Actor vs CPU Worker

An actor is primarily for **state isolation**:

```swift
actor ImageCache {
    private var images: [URL: UIImage] = [:]
}
```

It doesn't mean:

> "Run this on a dedicated background thread."

For pure CPU processing:

```swift
struct DataProcessor: Sendable {
    func process(_ data: [Data]) -> Result {
        // CPU work
    }
}
```

is often a better abstraction.

---

# 20. Chunking CPU Work

If a large operation can be broken into smaller pieces:

```swift
func process(_ data: [Data]) async -> Result {
    var result = Result()

    for chunk in data.chunked(into: 1_000) {
        result.merge(processChunk(chunk))

        await Task.yield()
    }

    return result
}
```

`Task.yield()` allows other tasks opportunities to run.

But:

> `Task.yield()` does not magically move work to a background thread.

If the function is Main Actor-isolated, the computation remains within that isolation domain.

---

# 21. Parallel CPU Processing

If the work is genuinely parallelizable:

```swift
func process(_ data: [Data]) async -> [Result] {
    await withTaskGroup(of: Result.self) { group in

        for chunk in chunks {
            group.addTask {
                processChunk(chunk)
            }
        }

        var results: [Result] = []

        for await result in group {
            results.append(result)
        }

        return results
    }
}
```

Conceptually:

```text
1,000,000 items
        │
        ├── Chunk 1
        ├── Chunk 2
        ├── Chunk 3
        └── Chunk 4
```

The runtime decides how to schedule those tasks.

Don't create thousands of tasks blindly. Use reasonable chunks.

---

# 22. Cancellation

Long-running CPU work should cooperate with cancellation.

Instead of:

```swift
for record in records {
    process(record)
}
```

use:

```swift
for record in records {
    try Task.checkCancellation()

    process(record)
}
```

Then a task can be cancelled:

```swift
task.cancel()
```

This is important for operations that may run for seconds or minutes.

---

# 23. Best Way to Run CPU-Intensive Work in Modern SwiftUI

### Question

In SwiftUI and modern concurrency what is the best way to run CPU intensive work in a background thread or a separate custom thread?

### Answer

In modern Swift Concurrency, the best approach is usually **not to create a custom `Thread` yourself**.

The preferred approach is:

> **Use `Task` / structured concurrency and let Swift's concurrency runtime schedule the work on its executor/thread pool.**

The important part is making sure the CPU-heavy function isn't MainActor-isolated.

## Don't manually create a thread for normal CPU work

You could do:

```swift
Thread {
    let result = expensiveCalculation()
    // ...
}.start()
```

But this is generally not the preferred modern SwiftUI approach.

You take responsibility for:

- thread lifecycle
- synchronization
- cancellation
- priority
- communicating results back
- avoiding thread explosion

Swift Concurrency already provides infrastructure for this.

Think:

```text
Swift Task
     ↓
Swift Concurrency Runtime
     ↓
System-managed thread pool
     ↓
CPU-intensive work
```

---

# 24. Simple Modern CPU-Work Pattern

```swift
struct DataProcessor: Sendable {

    func process(_ data: [Data]) -> ProcessedResult {
        // CPU-intensive synchronous work
        ...
    }
}
```

Then:

```swift
@MainActor
@Observable
final class UserViewModel {

    var result: ProcessedResult?
    var isProcessing = false

    func process(_ data: [Data]) async {
        isProcessing = true

        let processor = DataProcessor()

        let result = await Task.detached {
            processor.process(data)
        }.value

        self.result = result
        isProcessing = false
    }
}
```

The CPU-heavy work is deliberately outside Main Actor isolation.

---

# 25. Why `nonisolated` Is Not the Same as Background Execution

Suppose:

```swift
@MainActor
final class UserViewModel {

    nonisolated func process(_ data: [Data]) -> Result {
        // CPU-heavy work
    }
}
```

`nonisolated` means:

> This method does not require Main Actor isolation.

It does **not** mean:

> Run this on a background thread.

If you call a synchronous method from the Main Actor, the work can still execute synchronously on the caller's executor.

So:

```text
nonisolated
    ≠
background thread
```

---

# 26. MainActor ViewModel Architecture

A useful architecture is:

```text
                     User taps button
                           │
                           ↓
                    ┌─────────────┐
                    │  ViewModel  │
                    │ @MainActor  │
                    └──────┬──────┘
                           │
                     Start operation
                           │
                           ↓
                 ┌───────────────────┐
                 │ CPU-heavy worker  │
                 │ outside MainActor │
                 └─────────┬─────────┘
                           │
                     Result ready
                           │
                           ↓
                    ┌─────────────┐
                    │  ViewModel  │
                    │ @MainActor  │
                    └──────┬──────┘
                           │
                           ↓
                           UI
```

The ViewModel should generally coordinate UI state rather than perform large CPU-heavy synchronous calculations itself.

---

# 27. Why `await apiCall()` Is Okay but `await CPU_IntensiveTask()` Is Not

### Question

Given:

```swift
@MainActor
@Observable
final class UserViewModel {

    var result: ProcessedResult?
    var isProcessing = false

    private let processor = DataProcessor()

    func process(_ data: [Data]) async {
        isProcessing = true

        let user = await apiCall()

        let processed = await cpuIntensiveTask(data)

        self.result = processed
        isProcessing = false
    }
}
```

Why is:

```swift
let user = await apiCall()
```

okay, but:

```swift
let processed = await cpuIntensiveTask(data)
```

not okay?

### Answer

The key is:

> **`await` means "this operation may suspend." It does not mean "run this operation on a background thread."**

## API call

Suppose:

```swift
func apiCall() async throws -> User {
    let (data, _) = try await URLSession.shared.data(for: request)

    return try JSONDecoder().decode(User.self, from: data)
}
```

At:

```swift
try await URLSession.shared.data(for: request)
```

the task can suspend while the network request is in progress.

Conceptually:

```text
MainActor
   │
   ├── isProcessing = true
   │
   ├── await apiCall()
   │
   │      ↓
   │    SUSPEND
   │
   │    MainActor can do other work
   │
   │    Network request happens
   │
   │      ↓
   │    response arrives
   │
   ├── resume
   │
   └── update UI
```

The Main Actor isn't sitting there waiting.

## CPU-intensive work

Suppose:

```swift
func cpuIntensiveTask(_ data: [Data]) -> ProcessedResult {
    var result = ProcessedResult()

    for item in data {
        result.process(item)
    }

    return result
}
```

If this takes 5 seconds, it is synchronous CPU work.

Also, if the function is written as:

```swift
func cpuIntensiveTask(_ data: [Data]) async -> ProcessedResult {
    return performHugeCalculation(data)
}
```

the `async` keyword alone doesn't move the calculation off the Main Actor.

The CPU-heavy calculation can still execute within the Main Actor isolation domain.

---

# 28. `await` Does Not Mean Background

This:

```swift
await something()
```

doesn't mean:

> Run `something()` on a background thread.

It means:

> The current task may need to suspend while waiting for the asynchronous operation.

Therefore:

```swift
async
```

and:

```text
background
```

are not synonyms.

A function can be `async` while doing CPU-heavy synchronous work:

```swift
func calculate() async -> Int {
    var total = 0

    for i in 0..<100_000_000 {
        total += i
    }

    return total
}
```

If called from a Main Actor context, this can still block the Main Actor.

---

# 29. `Task.detached` Step by Step

Consider:

```swift
@MainActor
@Observable
final class UserViewModel {

    var result: ProcessedResult?
    var isProcessing = false

    func process(_ data: [Data]) async {
        isProcessing = true

        let processor = DataProcessor()

        let processed = await Task.detached {
            processor.process(data)
        }.value

        self.result = processed
        isProcessing = false
    }
}
```

## Step 1 — Start on Main Actor

Because the ViewModel is:

```swift
@MainActor
```

we start here:

```text
             MainActor
                 │
                 ↓
           process(data)
```

Then:

```swift
isProcessing = true
```

is UI state and belongs on Main Actor.

## Step 2 — Create detached task

```swift
Task.detached {
    processor.process(data)
}
```

The detached task does not inherit Main Actor isolation.

Conceptually:

```text
MainActor
    │
    └── Task.detached
              │
              ↓
       no MainActor isolation
```

## Step 3 — CPU work runs independently

Inside:

```swift
Task.detached {
    processor.process(data)
}
```

the CPU-intensive synchronous operation can be scheduled outside the Main Actor.

Conceptually:

```text
MainActor
    │
    │ await
    ↓
Detached Task
    │
    ↓
CPU-heavy work
    │
    ↓
Swift executor/thread pool
```

You don't manually select an OS thread.

## Step 4 — Wait for `.value`

```swift
let processed = await Task.detached {
    processor.process(data)
}.value
```

`.value` gives the result of the task.

The current task can suspend until the detached task finishes.

Conceptually:

```text
Start detached task
       │
       ↓
CPU work begins
       │
       ↓
Current task suspends
       │
       │ CPU work continues
       │
       ↓
Detached task finishes
       │
       ↓
Current task resumes
```

## Step 5 — Update UI on Main Actor

After the `await`, the Main Actor-isolated ViewModel method resumes in its Main Actor isolation domain:

```swift
self.result = processed
isProcessing = false
```

So the complete flow is:

```text
                MainActor
                    │
             isProcessing = true
                    │
                    ↓
             Detached Task
                    │
                    ↓
             CPU-heavy work
                    │
                    ↓
                  result
                    │
                    ↓
                MainActor
                    │
             result = processed
                    │
             isProcessing = false
```

---

# 30. Why Not Capture the MainActor ViewModel in a Detached Task?

Avoid:

```swift
@MainActor
final class UserViewModel {

    var users: [User] = []

    func process() async {
        let result = await Task.detached {
            self.users
        }.value
    }
}
```

You're trying to capture a Main Actor-isolated object in a detached task.

Instead, extract the data first:

```swift
@MainActor
final class UserViewModel {

    var users: [User] = []

    func process() async {
        let users = self.users

        let result = await Task.detached {
            processUsers(users)
        }.value

        self.result = result
    }
}
```

Even better, make the worker independent:

```swift
struct DataProcessor: Sendable {

    func process(_ data: [Data]) -> ProcessedResult {
        // CPU-heavy work
    }
}
```

Then:

```swift
@MainActor
final class UserViewModel {

    var result: ProcessedResult?

    func process(_ data: [Data]) async {
        let processor = DataProcessor()

        let result = await Task.detached {
            processor.process(data)
        }.value

        self.result = result
    }
}
```

The detached task should ideally operate on independent, `Sendable` data and not reach back into the Main Actor ViewModel.

---

# 31. `Task` vs `Task.detached`

## `Task {}`

```swift
Task {
    ...
}
```

creates a task that participates in the surrounding concurrency context and can inherit actor isolation.

For example:

```swift
@MainActor
func buttonTapped() {
    Task {
        await loadUser()
    }
}
```

This is normal SwiftUI code.

But:

```swift
@MainActor
func start() {
    Task {
        expensiveCalculation()
    }
}
```

can inherit Main Actor isolation, so it is not a generic "background task."

## `Task.detached`

```swift
Task.detached {
    ...
}
```

creates an independent task without inheriting the surrounding actor context.

This is useful when you deliberately need to escape Main Actor isolation for independent CPU-heavy work.

But it also means you must think carefully about:

- `Sendable`
- cancellation
- task priority
- ownership
- error handling
- data crossing the concurrency boundary

---

# 32. Don't Use `Task.detached` for Every Background Operation

For a network call:

```swift
@MainActor
func loadUser() async {
    let user = await apiCall()
    self.user = user
}
```

you normally do **not** need:

```swift
Task.detached {
    await apiCall()
}
```

The API already provides asynchronous suspension.

Use detached tasks when you have a specific reason to escape the current actor context.

---

# 33. Background Thread vs Custom Thread

For ordinary CPU-heavy work, modern Swift generally wants:

```text
CPU-intensive work
        ↓
Swift Concurrency
        ↓
system-managed executor/thread pool
```

rather than:

```text
CPU-intensive work
        ↓
Thread()
        ↓
manually managed thread
```

A custom `Thread` is appropriate when you have a specific thread-affinity requirement, not merely because the work is CPU-intensive.

---

# 34. Final Mental Model

There are several distinct concepts:

```text
                 ASYNC / AWAIT
                       │
              "Can this task suspend?"
                       │
                       ↓
                 Task scheduling


                    ACTOR
                       │
              "Who owns this state?"
                       │
                       ↓
                State isolation


                     THREAD
                       │
             "Where is code executing?"
                       │
                       ↓
                 OS execution
```

Therefore:

```swift
let user = await apiCall()
```

primarily means:

> "The task may suspend while waiting for the asynchronous API."

While:

```swift
let result = await Task.detached {
    processor.process(data)
}.value
```

means:

> "Run this independent computation outside my current actor context, and asynchronously wait for its result."

And:

```swift
@MainActor
final class UserViewModel
```

means:

> "This object's state belongs to the Main Actor."

---

# 35. Practical Rules

For a modern SwiftUI application:

| Situation | Preferred approach |
|---|---|
| UI state | `@MainActor` |
| SwiftUI ViewModel | Usually `@MainActor` |
| Network/API request | `async/await` |
| Async database operation | `async/await` |
| Shared mutable cache | `actor` |
| Shared mutable token state | `actor` |
| CPU-heavy synchronous algorithm | Run outside Main Actor |
| Independent CPU-heavy work | Consider `Task.detached` |
| Parallel CPU work | `withTaskGroup` / structured concurrency |
| Large cancellable computation | Check `Task.checkCancellation()` |
| Immutable values crossing concurrency domains | `Sendable` |
| Dedicated OS thread | Only when a specific thread-affinity requirement exists |
| `Task {}` inside MainActor | Remember it can inherit Main Actor |
| `nonisolated` | Removes actor isolation; does not itself mean background execution |

The central principle is:

> **`@MainActor` should own UI state. Asynchronous I/O can naturally suspend. CPU-heavy synchronous work should not run synchronously in the Main Actor's isolation domain. For independent CPU-intensive computation, separate the worker from the ViewModel and use Swift Concurrency to schedule that work outside the UI actor.**
