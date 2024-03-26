# Demystify SwiftUI

### When SwiftUI looks at your code, what does it see? 

- Three things: identity, lifetime, and dependencies.
- Identity is how SwiftUI recognizes elements as the same or distinct across multiple updates of your app.
- Lifetime is how SwiftUI tracks the existence of views and data over time.
- And dependencies are how SwiftUI understands when your interface needs to be updated and why.

### Identity
- 2 types: Explicit, Implicit

## Explicit

- Set id to a view
```
SomeView()
    .id(ViewId)
```

- Use that id

```
scrollViewProxy.scrollTo(ViewId, anchor: .topLeading)
```

## Implicit(Structural identity)
- SwiftUI uses the structure of your view hierarchy to generate implicit identities for your views so you don't have to.
- Structural identity distinguishing views by their type and position in the view hierarchy.




## Resources

- https://developer.apple.com/videos/play/wwdc2021/10022/
- https://developer.apple.com/videos/play/wwdc2019/216/
