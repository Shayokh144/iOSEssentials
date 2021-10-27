# RxSwift Learnings

## Observable
- The observable emits a .next event for each element, then emits a .completed event and finally is terminated.
- Remember that an observable doesn’t do anything until it receives a subscription. It’s the subscription that triggers an observable's work, which emits new events, up until it emits an .error or .completed event and is terminated. You can manually cause an observable to terminate by canceling a subscription to it.

## Observable.of vs Observable.from
- Observable.of([one, two, three])     - an Observable of [Int]
- Observable.from([one, two, three])   - an Observable of Int
- The from operator only takes an array


