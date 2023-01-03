# Avoid Singleton

### Problems of Singleton

- **Singletons provide a globally mutable shared state.** The global accessibility of singletons makes shared resources accessible from anywhere, especially from code that should not have any access. Even value types like Swift structures and enumerations can access a singleton, which is a bad practice. When any part of an app can access or change the global state, you get weird and hard to fix bugs.

- **Singletons encourage code with unclear separation.** One of the fundamental principles of good software development is separation of concerns. Singletons make access to shared resources a widespread concern across many objects. When a concern is spread too wide, it’s hard to keep track of it when specifications change and code needs to be updated. This leads to inconsistencies in your code base that can lead to severe problems like data loss or corruption.

- **Singletons carry state around for the lifetime of the application.** There are cases in which you need to reset the shared state. When you can have multiple instances, you can discard the old one and then create a new one. In a singleton, instead, resetting state might not be so natural and might require specific and complex code.

- **Code that uses singletons is hard or impossible to test.** Unit testing treats tested code as a separate, independent unit. The internal state of a unit should change only when the testing code interacts with its interface. Additionally, the same sequence of method calls should always lead to the same internal state. Singletons break these two assumptions. Finally, the testing of complex objects often implies replacing dependencies with test doubles like stubs, spies and mocks. Some languages allow you to access the internal state of an object through a mocking framework. In Swift, this is not possible, so there is no way to replace a singleton with a test double.

### How to avoid
In any real app, shared resources are necessary and unavoidable. There are always parts of an app’s architecture that need to be accessed from many places. Some examples are:

- The current global state of the app.
- The disk storage where data is saved, be it the file system, a database, the user defaults of the app, or a Core Data managed object context.
- A URL session that groups related network requests.
- A shared operation queue to prioritize, sequence, and schedule the asynchronous tasks of the app.


**What makes singletons wrong is not the sharing of a resource. It’s the global accessibility.
So, the solution is not removing shared state, but using a different mechanism called dependency injection to share resources.**


#### Resources

- [singletn & dependency injection](https://matteomanferdini.com/swift-singleton/)
- [Testing iOS provided singleton like URLSession](https://www.swiftbysundell.com/articles/testing-swift-code-that-uses-system-singletons-in-3-easy-steps/)
- [avoid singleton](https://www.swiftbysundell.com/articles/avoiding-singletons-in-swift/)