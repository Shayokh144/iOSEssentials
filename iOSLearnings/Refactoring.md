# Refactoring techniques

## Composing Methods

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
### [Substitute Algorithm](https://refactoring.guru/substitute-algorithm)

- Problem

```swift
func foundPerson(_ people: [String]) -> String {
    for person in people {
        if person == "Don" {
            return "Don"
        }
        if person == "John" {
            return "John"
        }
        if person == "Kent" {
            return "Kent"
        }
    }
    return ""
}
```


- Solution

```swift
func foundPerson(_ people: [String]) -> String {
    let candidates = ["Don", "John", "Kent"]
    for person in people {
        if candidates.contains(person) {
            return person
        }
    }
    return ""
}
```

## Remove Assignments to Parameters

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

### [Introduce Local Extension](https://refactoring.guru/introduce-local-extension)

- Problem:
    - A utility class doesn’t contain some methods that you need. But you can’t add these methods to the class.

```swift
class UtilityClass {
    func existingMethod() {
        print("This is the only method available in UtilityClass.")
    }
}

// You need to add a new method to this class, but you're not allowed to modify it directly.

// Usage
let utility = UtilityClass()
utility.existingMethod()

// You need a new method, but you can't modify UtilityClass to add it.

```
- Solution
    - Create a new class containing the methods and make it either the child or wrapper of the utility class.
- Subclassing the Utility Class
```swift
class UtilityClass {
    func existingMethod() {
        print("This is an existing method.")
    }
}

class ExtendedUtilityClass: UtilityClass {
    func newMethod() {
        print("This is a new method added by subclassing.")
    }
}

// Usage
let utility = ExtendedUtilityClass()
utility.existingMethod() // Prints: This is an existing method.
utility.newMethod()      // Prints: This is a new method added by subclassing.

```
- Wrapping the Utility Class
```swift
class UtilityClass {
    func existingMethod() {
        print("This is an existing method.")
    }
}

class UtilityWrapper {
    private let utility: UtilityClass
    
    init(utility: UtilityClass) {
        self.utility = utility
    }
    
    func existingMethod() {
        utility.existingMethod()
    }
    
    func newMethod() {
        print("This is a new method added by wrapping.")
    }
}

// Usage
let utility = UtilityClass()
let wrapper = UtilityWrapper(utility: utility)
wrapper.existingMethod() // Prints: This is an existing method.
wrapper.newMethod()      // Prints: This is a new method added by wrapping.

```

## Organizing Data

### [Self Encapsulate Field](https://refactoring.guru/self-encapsulate-field)

- Problem
    - You use direct access to private fields inside a class.


```swift

class Range {
    private var low: Int
    private var high: Int
    
    init(low: Int, high: Int) {
        self.low = low
        self.high = high
    }
    
    func includes(arg: Int) -> Bool {
        return arg >= low && arg <= high
    }
}

```

- Solution
    - Create a getter and setter for the field, and use only them for accessing the field.

```swift

class Range {
    private var low: Int
    private var high: Int
    
    init(low: Int, high: Int) {
        self.low = low
        self.high = high
    }
    
    func includes(arg: Int) -> Bool {
        return arg >= getLow() && arg <= getHigh()
    }
    
    func getLow() -> Int {
        return low
    }
    
    func getHigh() -> Int {
        return high
    }
}

```

### [Replace Data Value with Object](https://refactoring.guru/replace-data-value-with-object)

- Problem
    - A class (or group of classes) contains a data field. The field has its own behavior and associated data.

```swift
class Order {

    private let customerName: String
    ....
}

```
- Solution
    - Create a new class, place the old field and its behavior in the class, and store the object of the class in the original class.

```swift
class Order {

    ....
}

class Customer {

    private let name: String
}
```


### [Replace Array with Object](https://refactoring.guru/replace-array-with-object)

- Problem
    - You have an array that contains various types of data.

```swift
var row = [String](repeating: "", count: 2)
row[0] = "Liverpool"
row[1] = "15"

```

- Solution
    - Replace the array with an object that will have separate fields for each element.

```swift
let row = Performance()
row.setName("Liverpool")
row.setWins("15")
```

### [Duplicate Observed Data](https://refactoring.guru/duplicate-observed-data)
- Problem
    - Is domain data stored in classes responsible for the GUI?

```swift

class IntervalWindow {
    
    var startField: UITextField
    var endField: UITextField
    var lengthField: UITextField
    
    func StartField_FocusLost() {}
    func EndField_FocusLost() {}
    func LengthField_FocusLost() {}
    func calculateLength() {}
    func calculateEnd() {}
}

```

- Solution
    - Then it’s a good idea to separate the data into separate classes, ensuring connection and synchronization between the domain class and the GUI.


```swift
class IntervalWindow {
    
    var startField: UITextField
    var endField: UITextField
    var lengthField: UITextField
    var interval: Interval
    
    func StartField_FocusLost() {}
    func EndField_FocusLost() {}
    func LengthField_FocusLost() {}
}

class Interval {
    
    var start: String
    var end: String
    var length: String
    
    func calculateLength() {}
    func calculateEnd() {}
}

```

### [Change Unidirectional Association to Bidirectional](https://refactoring.guru/change-unidirectional-association-to-bidirectional)
- Problem
    - You have two classes that each need to use the features of the other, but the association between them is only unidirectional.

- Solution
    - Add the missing association to the class that needs it.

### [Change Bidirectional Association to Unidirectional](https://refactoring.guru/change-bidirectional-association-to-unidirectional)
- Problem
    - You have a bidirectional association between classes, but one of the classes doesn’t use the other’s features.
- Solution
    - Remove the unused association.

### [Replace Magic Number with Symbolic Constant](https://refactoring.guru/replace-magic-number-with-symbolic-constant)

- Problem
    - Your code uses a number that has a certain meaning to it.
```swift
func potentialEnergy(mass: Double, height: Double) -> Double {
    return mass * height * 9.81
}

```

- Solution
    - Replace this number with a constant that has a human-readable name explaining the meaning of the number.

```swift
let GRAVITATIONAL_CONSTANT = 9.81

func potentialEnergy(mass: Double, height: Double) -> Double {
    return mass * height * GRAVITATIONAL_CONSTANT
}

```

### [Encapsulate Field](https://refactoring.guru/encapsulate-field)

- Problem
    - You have a public field.
```swift
func potentialEnergy(mass: Double, height: Double) -> Double {
    return mass * height * 9.81
}

```

- Solution
    - Make the field private and create access methods for it.

```swift
class Person {
  private var name: String?

  func getName() -> String? {
    return name
  }

  func setName(_ arg: String) {
    name = arg
  }
}

```

### [Replace Type Code with Subclasses](https://refactoring.guru/replace-type-code-with-subclasses)


- Problem
    - You have a coded type that directly affects program behavior (values of this field trigger various code in conditionals).

```swift
class Employee {

	let engineer: Int
	let salesMan: Int
	let type: Int
}
```

- Solution
    - Create subclasses for each value of the coded type. Then extract the relevant behaviors from the original class to these subclasses. Replace the control flow code with polymorphism.

```swift
enum EmployeeType {
	case engineer, salesMan
}
class Employee {

	let type: EmployeeType
	init(type: EmployeeType) {
		self.type = type
	}
}

class Engineer: Employee {}
class SalesMan: Employee {}
```
## Simplifying Conditional Expressions

### [Decompose Conditional](https://refactoring.guru/decompose-conditional)


- Problem
    - You have a complex conditional (if-then/else or switch).

```swift
if date < SUMMER_START || date > SUMMER_END {
    charge = quantity * winterRate + winterServiceCharge
} else {
    charge = quantity * summerRate
}

```

- Solution
    - Decompose the complicated parts of the conditional into separate methods: the condition, then and else.

```swift
if isSummer(date) {
    charge = summerCharge(quantity)
} else {
    charge = winterCharge(quantity)
}

```

### [Consolidate Conditional Expression](https://refactoring.guru/consolidate-conditional-expression)

- Problem
    - You have multiple conditionals that lead to the same result or action.

```swift
func disabilityAmount(seniority: Int, monthsDisabled: Int, isPartTime: Bool) -> Double {
    if seniority < 2 {
        return 0
    }
    if monthsDisabled > 12 {
        return 0
    }
    if isPartTime {
        return 0
    }
    // Compute the disability amount.
    // ...
    return 0 // Placeholder for computed disability amount
}

```

- Solution
    - Consolidate all these conditionals in a single expression.

```swift
func disabilityAmount() -> Double {
    if isNotEligibleForDisability() {
        return 0
    }
    // Compute the disability amount.
    // ...
    return 0 // Placeholder for computed disability amount
}

```


### [Consolidate Duplicate Conditional Fragments](https://refactoring.guru/consolidate-duplicate-conditional-fragments)


- Problem
    - Identical code can be found in all branches of a conditional.


```swift
if isSpecialDeal() {
    total = price * 0.95
    send()
} else {
    total = price * 0.98
    send()
}

```

- Solution
    - Move the code outside of the conditional.

```swift
if isSpecialDeal() {
    total = price * 0.95
} else {
    total = price * 0.98
}
send()

```



### [Remove Control Flag](https://refactoring.guru/remove-control-flag)

- Problem
    - You have a boolean variable that acts as a control flag for multiple boolean expressions.

```swift
func processItems(items: [Int]) {
    var controlFlag = false

    for item in items {
        if item < 0 {
            controlFlag = true
        }

        if controlFlag {
            // Perform some action
            print("Negative number found, stopping further processing.")
            break
        }

        // Other processing logic
        print("Processing item: \(item)")
    }
    
    if controlFlag {
        // Additional actions if control flag is set
        print("Processing stopped due to control flag.")
    } else {
        print("All items processed without issues.")
    }
}

```


- Solution
    - Instead of the variable, use break, continue and return. 

```swift
func processItems(items: [Int]) {
    for item in items {
        if item < 0 {
            // Perform some action
            print("Negative number found, stopping further processing.")
            break
        }

        // Other processing logic
        print("Processing item: \(item)")
    }

    // Checking if the loop completed without finding a negative number
    if items.allSatisfy({ $0 >= 0 }) {
        print("All items processed without issues.")
    } else {
        print("Processing stopped due to a negative number.")
    }
}

```

### [Replace Nested Conditional with Guard Clauses](https://refactoring.guru/replace-nested-conditional-with-guard-clauses)

- Problem
    - You have a group of nested conditionals and it’s hard to determine the normal flow of code execution.

```swift
public func getPayAmount() -> Double {
    var result: Double
    if isDead {
        result = deadAmount()
    } else {
        if isSeparated {
            result = separatedAmount()
        } else {
            if isRetired {
                result = retiredAmount()
            } else {
                result = normalPayAmount()
            }
        }
    }
    return result
}

```

- Solution
    - Isolate all special checks and edge cases into separate clauses and place them before the main checks. Ideally, you should have a “flat” list of conditionals, one after the other.

```swift
public func getPayAmount() -> Double {
    if isDead {
        return deadAmount()
    }
    if isSeparated {
        return separatedAmount()
    }
    if isRetired {
        return retiredAmount()
    }
    return normalPayAmount()
}

```

### [Replace Conditional with Polymorphism](https://refactoring.guru/replace-conditional-with-polymorphism)

- Problem
    - You have a conditional that performs various actions depending on object type or properties.

```swift
class Bird {
    // ...
    func getSpeed() -> Double {
        switch type {
        case .EUROPEAN:
            return getBaseSpeed()
        case .AFRICAN:
            return getBaseSpeed() - getLoadFactor() * numberOfCoconuts
        case .NORWEGIAN_BLUE:
            return isNailed ? 0 : getBaseSpeed(voltage)
        default:
            fatalError("Should be unreachable")
        }
    }
}

```


- Solution
    - Create subclasses matching the branches of the conditional. In them, create a shared method and move code from the corresponding branch of the conditional to it. Then replace the conditional with the relevant method call. The result is that the proper implementation will be attained via polymorphism depending on the object class. 


```swift
protocol Bird {
  func getSpeed() -> Double
}

class European: Bird {
  func getSpeed() -> Double {
    return getBaseSpeed()
  }
  
  func getBaseSpeed() -> Double {
    // Implement base speed logic
  }
}

class African: Bird {
  var numberOfCoconuts: Double = 0
  
  func getSpeed() -> Double {
    return getBaseSpeed() - getLoadFactor() * numberOfCoconuts
  }
  
  func getBaseSpeed() -> Double {
    // Implement base speed logic
  }
  
  func getLoadFactor() -> Double {
    // Implement load factor logic
  }
}

class NorwegianBlue: Bird {
  var isNailed: Bool = false
  var voltage: Double = 0
  
  func getSpeed() -> Double {
    return isNailed ? 0 : getBaseSpeed()
  }
  
  func getBaseSpeed() -> Double {
    // Implement base speed logic
  }
}


```

### [Introduce Null Object](https://refactoring.guru/introduce-null-object)

- Problem
    - Since some methods return null instead of real objects, you have many checks for null in your code.

```swift
if customer == nil {
  plan = BillingPlan.basic()
}
else {
  plan = customer.getPlan()
}
```

- Solution
    - Instead of null, return a null object that exhibits the default behavior.

```swift
class NullCustomer: Customer {
    override var isNull: Bool {
        return true
    }
    
    override func getPlan() -> Plan {
        return NullPlan()
    }
    // Some other NULL functionality.
}

// Replace null values with Null-object.
let customer = (order.customer != nil) ? order.customer! : NullCustomer()

// Use Null-object as if it's a normal subclass.
let plan = customer.getPlan()
```

## Simplifying Method Calls

### [Rename Method](https://refactoring.guru/rename-method)

- Problem
    - The name of a method doesn’t explain what the method does.

- Solution
    - Rename the method.


### [Add Parameter](https://refactoring.guru/add-parameter)


- Problem
    - A method doesn’t have enough data to perform certain actions.

- Solution
    - Create a new parameter to pass the necessary data.


### [Remove Parameter](https://refactoring.guru/remove-parameter)
- Problem
    - A parameter isn’t used in the body of a method.

- Solution
    - Remove the unused parameter.

### [Separate Query from Modifier](https://refactoring.guru/separate-query-from-modifier)

- Problem
    - Do you have a method that returns a value but also changes something inside an object?

```swift
func getTotalOutstandingAndSetReadyForSummaries() -> Double
```

- Solution
    - Split the method into two separate methods. As you would expect, one of them should return the value and the other one modifies the object.
```swift
func getTotalOutstanding() -> Double
func setReadyForSummaries()
```

### [Parameterize Method](https://refactoring.guru/parameterize-method)

- Problem
    - Multiple methods perform similar actions that are different only in their internal values, numbers or operations.

```swift
func fivePercentRaise()
func tenPercentRaise()
```

- Solution
    - Combine these methods by using a parameter that will pass the necessary special value.
```swift
func percentRaise(percentValue: Double)

```

### [Replace Parameter with Explicit Methods](https://refactoring.guru/replace-parameter-with-explicit-methods)


- Problem
    - A method is split into parts, each of which is run depending on the value of a parameter.
```swift
func setValue(name: String, value: Int) {
  if name == "height" {
    height = value
    return
  }
  if name == "width" {
    width = value
    return
  }
  assert(false, "Should never reach here")
}

```

- Solution
    - Extract the individual parts of the method into their own methods and call them instead of the original method.
```swift
func setHeight(arg: Int) {
  height = arg
}

func setWidth(arg: Int) {
  width = arg
}

```


### [Preserve Whole Object](https://refactoring.guru/preserve-whole-object)
- Problem
    - You get several values from an object and then pass them as parameters to a method.
```swift
let low = daysTempRange.getLow()
let high = daysTempRange.getHigh()
let withinPlan = plan.withinRange(low: low, high: high)
```

- Solution
    - Instead, try passing the whole object.
```swift
let withinPlan = plan.withinRange(daysTempRange: daysTempRange)
```

### [Replace Parameter with Method Call](https://refactoring.guru/replace-parameter-with-method-call)

- Problem
    - Calling a query method and passing its results as the parameters of another method, while that method could call the query directly.
```swift
let basePrice = quantity * itemPrice
let seasonDiscount = self.getSeasonalDiscount()
let fees = self.getFees()
let finalPrice = discountedPrice(basePrice: basePrice, seasonDiscount: seasonDiscount, fees: fees)

```

- Solution
    - Instead of passing the value through a parameter, try placing a query call inside the method body.
```swift
let basePrice = quantity * itemPrice
let finalPrice = discountedPrice(basePrice: basePrice)
```

### [Introduce Parameter Object](https://refactoring.guru/introduce-parameter-object)

- Problem
    - Your methods contain a repeating group of parameters.
```swift
func amountInvoice(start: Date, end: Date)
func amountReceive(start: Date, end: Date)
```

- Solution
    - Replace these parameters with an object.
```swift
func amountInvoice(dateRange: Date, end: Date)
func amountReceive(start: Date, end: Date)
```

### [Hide Method](https://refactoring.guru/hide-method)
- Problem
    - A method isn’t used by other classes or is used only inside its own class hierarchy.
- Solution
    - Make the method private or protected.

### [Replace Constructor with Factory Method](https://refactoring.guru/replace-constructor-with-factory-method)

- Problem
    - You have a complex constructor that does something more than just setting parameter values in object fields.
```swift
class Employee {
    var type: Int
    
    init(type: Int) {
        self.type = type
    }
    // ...
}

```

- Solution
    - Create a factory method and use it to replace constructor calls.
```swift
class Employee {
    static func create(type: Int) -> Employee {
        let employee = Employee(type: type)
        // do some heavy lifting.
        return employee
    }
    // ...
}
```

### [Replace Error Code with Exception](https://refactoring.guru/replace-error-code-with-exception)

- Problem
    - A method returns a special value that indicates an error?
```swift
func withdraw(amount: Int) -> Int {
    if amount > _balance {
        return -1
    } else {
        _balance -= amount
        return 0
    }
}

```

- Solution
    - Throw an exception instead.
```swift
func withdraw(amount: Int) throws {
    if amount > _balance {
        throw BalanceException()
    }
    _balance -= amount
}

```


### [Replace Exception with Test](https://refactoring.guru/replace-exception-with-test)

- Problem
    - You throw an exception in a place where a simple test would do the job?
```swift
func getValueForPeriod(periodNumber: Int) -> Double {
    do {
        return values[periodNumber]
    } catch {
        return 0
    }
}


```

- Solution
    - Replace the exception with a condition test.
```swift
func getValueForPeriod(periodNumber: Int) -> Double {
    if periodNumber >= values.count {
        return 0
    }
    return values[periodNumber]
}

```

## Dealing with Generalization


### [Pull Up Field](https://refactoring.guru/pull-up-field)
- Problem
    - Two classes have the same field.

- Solution
    - Remove the field from subclasses and move it to the superclass.




### [Pull Up Method](https://refactoring.guru/pull-up-method)
- Problem
    - Your subclasses have methods that perform similar work.

- Solution
    - Make the methods identical and then move them to the relevant superclass.

### [Pull Up Constructor Body](https://refactoring.guru/pull-up-constructor-body)
- Problem
    - Your subclasses have constructors with code that’s mostly identical.
```swift
class Manager: Employee {
    var name: String
    var id: String
    var grade: Int
    
    init(name: String, id: String, grade: Int) {
        self.name = name
        self.id = id
        self.grade = grade
        super.init() // Call the initializer of the superclass (Employee)
    }
    // ...
}

```

- Solution
    - Create a superclass constructor and move the code that’s the same in the subclasses to it. Call the superclass constructor in the subclass constructors.

```swift
class Manager: Employee {
    var grade: Int
    
    init(name: String, id: String, grade: Int) {
        self.grade = grade
        super.init(name: name, id: id)
    }
    // ...
}
```


### [Push Down Method](https://refactoring.guru/push-down-method)
- Problem
    - Is behavior implemented in a superclass used by only one (or a few) subclasses?


- Solution
    - Move this behavior to the subclasses.


### [Push Down Field](https://refactoring.guru/push-down-field)
- Problem
    - Is a field used only in a few subclasses?


- Solution
    - Move the field to these subclasses.


### [Extract Subclass](https://refactoring.guru/extract-subclass)
- Problem
    - A class has features that are used only in certain cases.


- Solution
    - Create a subclass and use it in these cases.


### [Extract Superclass](https://refactoring.guru/extract-superclass)
- Problem
    - You have two classes with common fields and methods.


- Solution
    - Create a shared superclass for them and move all the identical fields and methods to it.

### [Extract Interface](https://refactoring.guru/extract-interface)


- Problem
    - Multiple clients are using the same part of a class interface. Another case: part of the interface in two classes is the same.


- Solution
    - Move this identical portion to its own interface.

### [Form Template Method](https://refactoring.guru/form-template-method)


- Problem
    - Your subclasses implement algorithms that contain similar steps in the same order.


- Solution
    - Move the algorithm structure and identical steps to a superclass, and leave implementation of the different steps in the subclasses.

### [Replace Inheritance with Delegation](https://refactoring.guru/replace-inheritance-with-delegation)

- Problem
    - You have a subclass that uses only a portion of the methods of its superclass (or it’s not possible to inherit superclass data).

```swift
class Vector {

	func isEmpty() -> Bool {}
}

class Stack: Vector {}

```
- Solution
    - Create a field and put a superclass object in it, delegate methods to the superclass object, and get rid of inheritance.

```swift
class Vector {

	func isEmpty() -> Bool {}
}

class Stack {

	let vector: Vector

	func isEmpty() -> Bool {
		vector.isEmpty()
	}
}

```

### [Replace Delegation with Inheritance](https://refactoring.guru/replace-delegation-with-inheritance)


- Problem
    - A class contains many simple methods that delegate to all methods of another class.


- Solution
    - Make the class a delegate inheritor, which makes the delegating methods unnecessary.



