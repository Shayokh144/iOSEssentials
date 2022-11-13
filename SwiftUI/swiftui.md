# SwiftUI

- SwiftUI is primarily a UI framework
-  views are primarily declared as value types
-  swiftui view [lifecycle](https://www.swiftbysundell.com/articles/the-lifecycle-and-semantics-of-a-swiftui-view/)
- `onAppear` is similar of uikit's `viewWillAppear`

> :warning: In general, whenever we need to use the **return** keyword within a SwiftUI body, we’re likely doing something wrong, as the role of that property is to describe our view hierarchy using SwiftUI’s DSL — not to perform operations, and not to trigger side effects.

> :warning: It’s important to remember that SwiftUI views are not references to the actual UI components that are being rendered on screen, but rather lightweight values that describe our UI — so they don’t have the same kind of lifecycle as something like a UIView instance has.

- [state vs binding](https://stackoverflow.com/questions/59247183/swiftui-state-vs-binding)
- [state management](https://www.swiftbysundell.com/articles/swiftui-state-management-guide/)**(must read)**
- [property wrappers details](https://swiftuipropertywrappers.com/)**(must read)**

### @State

- A State property is connected to the view. A State property is permanently being read by the view. That means that every time the @State property gets changed/updated, the view gets re-rendered and eventually displays the content depending on the @State's data.
- State is accessible only to a particular view.
- Simple properties like strings, integers and booleans belongs to a single view - mark as private.
- All the fields marked as State are stored in special separated memory, where only corresponded view can access and update them.

### @Binding

- BindableObject protocol, which requires a didChange property. It makes possible to use it inside Environment and rebuild view as soon as it changes.
- The didChange property should be a Publisher, which is a part of a new Apple’s Reactive framework called Combine.
- The main goal of Publisher is to notify all subscribers when something changes. As soon as new values appear, SwiftUI will rebuild Views.

### @EnvironmentObject

- It is a part of feature called Environment. You can populate your Environment with all needed service classes and then access them from any view inside that Environment.
- @EnvironmentObject is accessible for every view inside the Environment.
- @EnvironmentObject Properties created elsewhere such as shared data. App crashes if it is missing.
- The Environment is the right way of Dependency Injection with SwiftUI.


## Resources

- [sundell swiftui](https://www.swiftbysundell.com/tags/swiftui/)