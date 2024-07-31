# Refactoring techniques

### [Extract Method](https://refactoring.guru/extract-method)

- Problem

```swift
func printOwing() {
    self.printBanner()

    // Print details
    print("name: \(self.name)")
    print("amount: \(self.getOutstanding())")
}
```

- Solution

```swift
func printOwing(name: String, outstanding: Double) {
    printBanner()
    printDetails(name: name, outstanding: outstanding)
}

func printDetails(name: String, outstanding: Double) {
    print("name: \(name)")
    print("amount: \(outstanding)")
}

```

### [Inline Method](https://refactoring.guru/inline-method)

- Problem

```swift
class PizzaDelivery {
    // ...

    func getRating() -> Int {
        return moreThanFiveLateDeliveries() ? 2 : 1
    }
  
    func moreThanFiveLateDeliveries() -> Bool {
        return numberOfLateDeliveries > 5
    }
}
```

- Solution
```swift
class PizzaDelivery {
    // ...

    func getRating(numberOfLateDeliveries: Int) -> Int {
    	return numberOfLateDeliveries > 5 ? 2 : 1
    }
}
```

### [Extract Variable](https://refactoring.guru/extract-variable)

- Problem

```swift
func renderBanner(platform: String, browser: String, resize: Int, wasInitialized: () -> Bool) {
    if platform.uppercased().contains("MAC") && 
       browser.uppercased().contains("IE") && 
       wasInitialized() && resize > 0 {
        // do something
    }
}
```

- Solution

```swift
func renderBanner(platform: String, browser: String, resize: Int, wasInitialized: () -> Bool) {
    let isMacOs = platform.uppercased().contains("MAC")
    let isIE = browser.uppercased().contains("IE")
    let wasResized = resize > 0

    if isMacOs && isIE && wasInitialized() && wasResized {
        // do something
    }
}
```

### [Inline Temp](https://refactoring.guru/inline-temp)

- Problem

```swift
func hasDiscount(order: Order) -> Bool {
    let basePrice = order.basePrice()
    return basePrice > 1000
}
```

- Solution

```swift
func hasDiscount(order: Order) -> Bool {
    return order.basePrice() > 1000
}

```


### [Replace Temp with Query](https://refactoring.guru/replace-temp-with-query)


- Problem

```swift
func calculateTotal() -> Double {
    let basePrice = quantity * itemPrice
    if basePrice > 1000 {
        return basePrice * 0.95
    } else {
        return basePrice * 0.98
    }
}
```


- Solution

```swift
func calculateTotal() -> Double {
    if basePrice() > 1000 {
        return basePrice() * 0.95
    } else {
        return basePrice() * 0.98
    }
}

func basePrice() -> Double {
    return quantity * itemPrice
}
```

### [Split Temporary Variable](https://refactoring.guru/split-temporary-variable)

- Problem

```swift
temp = 2 * (height + width)
print(temp)
temp = height * width
print(temp)
```

- Solution

```swift
perimeter = 2 * (height + width)
print(perimeter)
area = height * width
print(area)

```

### [Replace Method with Method Object](https://refactoring.guru/replace-method-with-method-object)

- Problem

```swift
class Order {
    // ...
    func price() -> Double {
        var primaryBasePrice = 0.0
        var secondaryBasePrice = 0.0
        var tertiaryBasePrice = 0.0
        // Perform long computation.
    }
}

```


- Solution


```swift
class Order {
    // ...
    func price() -> Double {
        return PriceCalculator(order: self).compute()
    }
}

class PriceCalculator {
    private var primaryBasePrice: Double
    private var secondaryBasePrice: Double
    private var tertiaryBasePrice: Double

    init(order: Order) {
        self.primaryBasePrice = 0.0
        self.secondaryBasePrice = 0.0
        self.tertiaryBasePrice = 0.0
        // Copy relevant information from the
        // order object.
    }

    func compute() -> Double {
        // Perform long computation.
    }
}
```


### [Move Method](https://refactoring.guru/move-method)


- Problem
	- A method is used more in another class than in its own class.
- Solution
	- Create a new method in the class that uses the method the most, then move code from the old method to there. Turn the code of the original method into a reference to the new method in the other class or else remove it entirely.

### [Move Field](https://refactoring.guru/move-field)


- Problem
	- A field is used more in another class than in its own class.
- Solution
	- Create a field in a new class and redirect all users of the old field to it.


### [Extract Class](https://refactoring.guru/extract-class)

- Problem
	- When one class does the work of two, awkwardness results.

```swift
class Person {
    
    let name: String
    let officeAreaCode: String
    let officeNumber: String
    
    init(name: String, officeAreaCode: String, officeNumber: String) {
        self.name = name
        self.officeAreaCode = officeAreaCode
        self.officeNumber = officeNumber
    }
    
    func getTelephoneNumber() -> String { return "T_N" }
}

```
- Solution
	- Instead, create a new class and place the fields and methods responsible for the relevant functionality in it.
 
```swift
class Person {
    
    let name: String
    let telePhoneNumber: TelephoneNumber
    // Other responsibilities
    
    init(name: String, telePhoneNumber: TelephoneNumber) {
        self.name = name
        self.telePhoneNumber = telePhoneNumber
    }
    
    func getTelephoneNumber() -> String {
        return telePhoneNumber.getTelephoneNumber()
    }
}

class TelephoneNumber {
    
    let officeAreaCode: String
    let officeNumber: String
    
    init(officeAreaCode: String, officeNumber: String) {
        self.officeAreaCode = officeAreaCode
        self.officeNumber = officeNumber
    }
    
    func getTelephoneNumber() -> String { return "T_N" }
}

```

### [Inline Class](https://refactoring.guru/inline-class)

- Problem
	- A class does almost nothing and isn’t responsible for anything, and no additional responsibilities are planned for it.

```swift
class Person {
    
    let name: String
    let telePhoneNumber: TelephoneNumber
    // No Other responsibilities
    
    init(name: String, telePhoneNumber: TelephoneNumber) {
        self.name = name
        self.telePhoneNumber = telePhoneNumber
    }
    
    func getTelephoneNumber() -> String {
        return telePhoneNumber.getTelephoneNumber()
    }
}

class TelephoneNumber {
    
    let officeAreaCode: String
    let officeNumber: String
    
    init(officeAreaCode: String, officeNumber: String) {
        self.officeAreaCode = officeAreaCode
        self.officeNumber = officeNumber
    }
    
    func getTelephoneNumber() -> String { return "T_N" }
}

```
- Solution
	- Move all features from the class to another one.
 
```swift
class Person {
    
    let name: String
    let officeAreaCode: String
    let officeNumber: String
    
    init(name: String, officeAreaCode: String, officeNumber: String) {
        self.name = name
        self.officeAreaCode = officeAreaCode
        self.officeNumber = officeNumber
    }
    
    func getTelephoneNumber() -> String { return "T_N" }
}

```

### [Hide Delegate](https://refactoring.guru/hide-delegate)

- Problem
	- The client gets object B from a field or method of object А. Then the client calls a method of object B.
 
```swift
class ClientClass {
    
    var person: Person?
    var department: Department?

    init(person: Person?, department: Department?) {
        self.person = person
        self.department = department
    }
}

class Person {
    
    var department: Department?

    init(department: Department?) {
        self.department = department
    }

    func getDepartment() -> Department? {
        return department
    }
}

class Department {
    
    var manager: Person?

    init(manager: Person?) {
        self.manager = manager
    }

    func getManager() -> Person? {
        return manager
    }
}

```

- Solution
	- Create a new method in class A that delegates the call to object B. Now the client doesn’t know about, or depend on, class B.

```swift
class ClientClass {
    
    var person: Person?

    init(person: Person?) {
        self.person = person
    }
}

class Person {
    
    var department: Department?

    init(department: Department?) {
        self.department = department
    }

    func getManager() -> Person? {
        return department?.manager
    }
}

class Department {
}
```


### [Remove Middle Man](https://refactoring.guru/remove-middle-man)

- Problem
	- A class has too many methods that simply delegate to other objects.


```swift
class ClientClass {
    
    var person: Person?

    init(person: Person?) {
        self.person = person
    }
}

class Person {
    
    var department: Department?

    init(department: Department?) {
        self.department = department
    }

    func getManager() -> Person? {
        return department?.manager
    }
}

class Department {
}
```
- Solution
	- Delete these methods and force the client to call the end methods directly.

```swift
class ClientClass {
    
    var person: Person?
    var department: Department?

    init(person: Person?, department: Department?) {
        self.person = person
        self.department = department
    }
}

class Person {
    
    var department: Department?

    init(department: Department?) {
        self.department = department
    }

    func getDepartment() -> Department? {
        return department
    }
}

class Department {
    
    var manager: Person?

    init(manager: Person?) {
        self.manager = manager
    }

    func getManager() -> Person? {
        return manager
    }
}

```


### [Introduce Foreign Method](https://refactoring.guru/introduce-foreign-method)
- Problem
    - A utility class doesn’t contain the method that you need and you can’t add the method to the class.

```swift
class Report {
    // ...
    func sendReport() {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.day = 1
        
        if let previousEnd = previousEnd {
            let nextDay = calendar.date(byAdding: dateComponents, to: previousEnd)
            // ...
        }
    }
}


```
- Solution
    - Add the method to a client class and pass an object of the utility class to it as an argument.

```swift
class Report {
    // ...
    func sendReport() {
        let newStart = Report.nextDay(arg: previousEnd)
        // ...
    }
    
    private static func nextDay(arg: Date) -> Date {
        var dateComponents = DateComponents()
        dateComponents.day = 1
        let calendar = Calendar.current
        return calendar.date(byAdding: dateComponents, to: arg)!
    }
}

```






















