# [Projects and Workspaces](https://developer.apple.com/documentation/xcode/projects-and-workspaces?changes=_8)

## [Definations](https://stackoverflow.com/a/20637892/4245112)

### Workspace 
- Contains one or more projects. These projects usually relate to one another
- An Xcode workspace always exists in your project. It may be external to an .xcodeproj, or embedded within one.
- A workspace is just a list of contained projects. there is no other metadata in it.
- Xcode workspaces are directories with the .xcworkspace extension that is present as packages.
- Workspace is responsible for dependencies between projects.

### Project
- Contains code and resources, etc. (You'll be used to these!)
- like workspace, an Xcode project is a bundle containing one or more files.
- The most important and only required file is the project.pbxproj file.

### Target
- Each project has one or more targets.
	- Each target defines a list of build settings for that project
	- Each target also defines a list of classes, resources, custom scripts etc to include/ use when building.
	- Targets are usually used for different distributions of the same project.
		- For example, my project has two targets, a "normal" build and an "office" build that has extra testing features and may contain several background music tracks and a button to change the track (as it currently does).
		- You'll be used to adding classes and resources to your default target as you add them.
		- You can pick and choose which classes / resources are added to which target.
		- In my example, I have a "DebugHandler" class that is added to my office build
		- If you add tests, this also adds a new target.

### Scheme
- A scheme defines what happens when you press "Build", "Test", "Profile", etc.
- Usually, each target has at least one scheme.
- You can autocreate schemes for your targets by going to Scheme > Manage Schemes and pressing "Autocreate Schemes Now"

## [Managing Multiple Projects and their Dependencies](https://developer.apple.com/documentation/xcode/managing-multiple-projects-and-their-dependencies?changes=_8)

### Advantages to distributing content among multiple projects

- Multiple smaller projects are easier to navigate. With fewer files, fewer targets, and fewer products in the project, it’s easier for you to navigate the project’s content and see what’s there.

- Multiple projects make it easier to distribute work. If you have multiple teams, giving each one a separate project makes it easier for them to work independently.

- Multiple independent projects can result in faster build times. Separating content into multiple, independent projects forces you to eliminate or minimize dependencies between those projects. When you limit dependencies, Xcode has more flexibility to build projects in parallel, rather than serially.

### Use Case
- Consider a situation that you have one application that will be published in various countries with some different features but also it have some same features. Instead of keeping duplicate work, you can work similar feature as framework and you can use it in your app.

- One more use case is :- If you’re working in a big team / your app is very big, it’s better to keep separate project for each work. It helps for CI/CD integration to alert particular team about issues. I’m explain more about this in my next blog.

> When you separate content into independent projects, there might still be dependencies between them. For example, if an app team and framework team are developing their content in tandem, they each need access to the latest changes from both projects. Workspaces and cross-project references help you manage these dependencies between projects.

### [Example of Using Multiple Project In A Single Workspace](https://medium.com/orion-innovation-turkey/xcode-workspace-with-multiple-projects-1b42f5182c45)

