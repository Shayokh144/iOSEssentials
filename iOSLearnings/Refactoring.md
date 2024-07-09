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






 
