# GeometryReader

- By default, GeometryReader places its children in the top left corner, which is very unusual for SwiftUI views. Usually, SwiftUI views place content in the center of its coordinate space.

- GeometryReader’s @ViewBuilder closure has the parameter called geometry. This parameter is an instance of GeometryProxy struct. You can use an instance of GeometryProxy to access information about the coordinate space using the following properties.

    - size - The size of space available to GeometryReader.
    - safeAreaInsets - An instance of EdgeInsets struct that provides safe area insets of GeometryReader.
- GeometryProxy also has a frame function that allows you to access the frame of the GeometryReader by converting it into a correct coordinate space. You can also create your own coordinate spaces by using coordinateSpace modifier on any view.

- GeometryReader fills all the available space.
- GeometryReader needs to offer all the space available to its child, it first needs to expand to occupy as much as possible. Then, as we’ve seen, the child may decide to use less area. However, GeometryReader will still remain large.
- If you use GeometryReader as a full-screen view, that is great, and you don’t need to do anything. In other cases, try to limit the available space of GeometryReader by using frame or aspectRatio modifiers. These modifiers allow you to keep GeometryReader under control.
- The second tip is to use GeometryReader inside an overlay or background of any view. SwiftUI keeps overlay and background views in the same size as the view that you apply them. It limits the size of GeometryReader and doesn’t allow it to grow and fill all the available space.




## Resources
- https://swiftui-lab.com/geometryreader-to-the-rescue/
- https://swiftui-lab.com/communicating-with-the-view-tree-part-1/
- https://swiftui-lab.com/communicating-with-the-view-tree-part-2/
- https://swiftui-lab.com/communicating-with-the-view-tree-part-3/
- https://swiftwithmajid.com/2020/11/04/how-to-use-geometryreader-without-breaking-swiftui-layout/
- https://developer.apple.com/videos/play/wwdc2019/237/


























