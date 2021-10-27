# RxSwift Learnings

## Observable
- The observable emits a .next event for each element, then emits a .completed event and finally is terminated.

## Observable.of vs Observable.from
- Observable.of([one, two, three])     - an Observable of [Int]
- Observable.from([one, two, three])   - an Observable of Int
- The from operator only takes an array


