//: [Previous](@previous)

import Foundation
import Combine

print("COMBINE TEST")
var subscriptions = Set<AnyCancellable>()
func exampleOfJust() {
    print("Running example Of Just")
    let _ = Just(5)
        .map { value -> String in
            // do something with the incoming value here
            // and return a string
            return "a square of \(value) is \(value * value)"
        }
        .sink { receivedValue in
            // sink is the subscriber and terminates the pipeline
            print("The end result was \(receivedValue)")
        }.store(in: &subscriptions)
}
//exampleOfJust()
func exampleOfAssign() {
    // 1
    class SomeObject {
        var value: String = "" {
            didSet {
                print(value)
            }
        } }
    // 2
    let object = SomeObject()
    // 3
    let publisher = ["Hello", "world!"].publisher
    // 4
    _ = publisher
        .assign(to: \.value, on: object).cancel()
}
//exampleOfAssign()
var futureSubscription: AnyCancellable?
func exampleOfFuture() {
    let ftr = Future<String, Never> { promise in
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {

            promise(.success("world"))
        }
    }
    futureSubscription = ftr.sink {
        print("hello \($0)")
    }
}
//exampleOfFuture()

func exampleOfPassthroughSubject() {
    print("exampleOfPassthroughSubject")
    // 1
    let subject = PassthroughSubject<String, Never>()
    // 2
    subject.sink(receiveCompletion: { _ in
        print("finished")
    }, receiveValue: { value in
        print(value)
    })
    // 3
    subject.send("Hello,")
    subject.send("World!")
    subject.send(completion: .finished) // 4
}
//exampleOfPassthroughSubject()

func exampleOfCurrentValueSubject() {
    print("exampleOfCurrentValueSubject")
    // 1
    let subject = CurrentValueSubject<String, Never>("Hello")
    // 2
    subject.sink(receiveCompletion: { _ in
        print("finished")
    }, receiveValue: { value in
        print(value)
    })
    // 3
    subject.send("World!")
    subject.send(completion: .finished) // 4
}
exampleOfCurrentValueSubject()
