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
