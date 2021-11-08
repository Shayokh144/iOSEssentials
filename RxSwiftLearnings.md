# RxSwift Learnings

## Observable
- Observable also known as Sequence
- The observable emits a .next event for each element, then emits a .completed event and finally is terminated.
- Remember that an observable doesn’t do anything until it receives a subscription. It’s the subscription that triggers an observable's work, which emits new events, up until it emits an .error or .completed event and is terminated. You can manually cause an observable to terminate by canceling a subscription to it.

## Observable.of vs Observable.from
- Observable.of([one, two, three])     - an Observable of [Int]
- Observable.from([one, two, three])   - an Observable of Int
- The from operator only takes an array

## Traits
- Traits are observables with a narrower set of behaviors than regular observables.
- There are three kinds of traits in RxSwift: Single, Maybe and Completable.
- Singles will emit either a .success(value) or .error event. .success(value) is actually a combination of the .next and .completed events. This is useful for one-time processes that will either succeed and yield a value or fail, such as downloading data or loading it from disk.
- A Completable will only emit a .completed or .error event. It doesn't emit any values. You could use a completable when you only care that an operation completed successfully or failed, such as a file write.
- Maybe is a mashup of a Single and Completable. It can either emit
a .success(value), .completed or .error. If you need to implement an operation that could either succeed or fail, and optionally return a value on success, then Maybe is your ticket.

## Subject
- can act as both an observable and as an observer
### PublishSubject
- like a newspaper publisher, it will receive information and then turn around and publish it to subscribers, possibly after modifying that information in some way first. 
