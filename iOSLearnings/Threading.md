# What is a serial queue?

- A serial Dispatch Queue performs only one task at the time. Serial queues are often used to synchronize access to a specific value or resource to prevent data races to occur.

# What is a concurrent queue?
- A concurrent queue allows us to execute multiple tasks at the same time. Tasks will always start in the order they’re added but they can finish in a different order as they can be executed in parallel. Tasks will run on distinct threads that are managed by the dispatch queue. The number of tasks running at the same time is variable and depends on system conditions.

# What is a data race?
- A data race can occur when multiple threads access the same memory without synchronization and at least one access is a write. You could be reading values from an array from the main thread while a background thread is adding new values to that same array.

- Data races can be the root cause behind flaky tests and weird crashes. Therefore, it’s good practice to regularly spend time using the Thread Sanitizer.

# Asynchronous vs synchronous tasks
- A DispatchQueue task can be run synchronously or asynchronously. The main difference occurs when you create the task.

- Synchronously starting a task will block the calling thread until the task is finished
- Asynchronously starting a task will directly return on the calling thread without blocking
Say you would add a task to the queue from the main thread, you want to prevent yourself from using the sync method for long-running tasks. This would block the main thread and makes your UI unresponsive.

# Main thread?
- The main dispatch queue is a globally available serial queue executing tasks on the application’s main thread. As the main thread is used for UI updates it’s important to be conscious when executing tasks on this queue. Therefore, it’s valuable to use the earlier described dispatch APIs to perform tasks on a different thread.

You can start doing the heavy lifting on a background queue and dispatch back to the main queue when you’re done

# Concurrency

- Creating a concurrent queue:
```Swift
let customConcurrentQueue = DispatchQueue(label: "asif.conQ.com", qos: .background,attributes: .concurrent)
```

- A DispatchQueue task can be run synchronously or asynchronously. The main difference occurs when you create the task.

- Synchronously starting a task will block the calling thread until the task is finished
- Asynchronously starting a task will directly return on the calling thread without blocking
- Say you would add a task to the queue from the main thread, you want to prevent yourself from using the sync method for long-running tasks. This would block the main thread and makes your UI unresponsive.
- Though its a concurrent queue this code will block the UI if it is called from UI/Main thread as we use `sync`. If we make it `async` it will work fine:

```
customConcurrentQueue.sync {
   print("Task 1 started")
   var sum = 0
   for i in 1...90000000 {
      sum += i
   }
   print(sum)
   print("Task 1 finished")
}
```
#### Resources

- [Concurrent vs Serial](https://www.avanderlee.com/swift/concurrent-serial-dispatchqueue/)
