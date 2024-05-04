# UML

## Structural Modeling
- Related to things(concrete or concptual)
- Usually refer to Noun

### Structural Modeling Diagram Types

- Class
- Component(Plugable and Replaceble piece of Software)
- Package
- Deployment


## Behavioral Modeling
- Related to functionality
- Usually refer to Verb

### Behavioral Modeling Diagram Types

- Use Case
- Sequence
- State
- Activity


### Message types

- [Types](https://www.uml-diagrams.org/interaction-message.html)
- Need to write function names over the line
<img src="../staticresources/uml_message_type.png" alt="uml_message_type" />

- Return message
<img src="../staticresources/return_msg.png" alt="return_msg.png" />

### State
A state is a condition or situation during the life of an object during which it satisfies some condition, performs some activity, or waits for some event.


### Event
An event is the specification of a significant occurrence that has a location in time and space. In the context of state machines, an event is an occurrence of a stimulus that can trigger a state transition.

A guard condition is evaluated after the trigger event for the transition occurs. It is possible to have multiple transitions from the same source state and with the same event trigger, as long as the guard conditions don’t overlap. A guard condition is evaluated just once for the transition at the time the event occurs. The boolean expression may reference the state of the object.

### Transition
A transition is a relationship between two states indicating that an object in the first state will perform certain actions and enter the second state when a specified event occurs and specified conditions are satisfied. Activity is an ongoing non-atomic execution within a state machine.

### Action
An action is an executable atomic computation that results in a change in the state of the model or the return of a value.


### Relationships

#### Associations	
- Indicate that instances of one model element are connected to instances of another model element
- Example: 
	- 1..1: Only one
	- 0..*: Zero or more
	- 1..*:one or more
#### Dependencies	
- Indicate that a change to one model element can affect another model element
#### Generalizations	
- Indicate that one model element is a specialization of another model element
#### Realization / Implementation	
- Indicate that one model element provides a specification that another model element implements

<img src="../staticresources/uml_relationship.png" alt="uml_relationship.png" />


### Class Diagram

The UML Class diagram is a graphical notation used to construct and visualize object oriented systems. A class diagram in the Unified Modeling Language (UML) is a type of static structure diagram that describes the structure of a system by showing the system's:

- classes,
- their attributes,
- operations (or methods),
- and the relationships among objects.

#### When do we need Class Diagram

-  Class diagrams provide a visual representation of the structure of a system, showing the classes, attributes, operations, and relationships between them. This visual representation helps stakeholders understand the architecture and design of the system more easily.


- Class diagrams serve as a means of communication between different stakeholders such as developers, designers, testers, and business analysts. They provide a common language and visual representation that can be easily understood by everyone involved in the project.

- Class diagrams can reveal recurring patterns in the system design, such as inheritance, aggregation, association, and composition. Recognizing these patterns can lead to more efficient and reusable designs.

-  By visually representing the relationships and dependencies between classes, class diagrams can help in identifying potential errors or inconsistencies in the design early in the development process, before implementation begins.

- In the design phase, class diagrams are used to model the structural aspects of the system. They help in designing the class hierarchy, defining the attributes and methods of each class, and specifying the relationships between classes such as associations, aggregations, and inheritances.

- UML class diagrams serve as a means of communication between different stakeholders involved in the project, including developers, designers, testers, and business analysts. They provide a common visual language that can be easily understood by everyone, facilitating effective communication and collaboration.

- In some cases, class diagrams can be used to generate code automatically. Tools that support Model-Driven Development (MDD) can take UML diagrams, including class diagrams, and generate code in various programming languages, which can significantly speed up the development process.


#### Main components of class diagram

- Class: Represents a template or blueprint for objects. It consists of a name, attributes, and operations/methods.

- Attributes: Describes the properties or characteristics of a class. Attributes are usually depicted as name: type pairs. For example, "name: String".

- Operations/Methods: Represents the behavior or actions that objects of the class can perform. Operations are usually depicted as name(parameters): return type. For example, "calculatePrice(quantity: int): double".

- Visibility: Denotes the visibility or access level of attributes and methods. Common visibility modifiers include public (+), private (-), protected (#), and package (~).

- Relationships:

	- Association: Represents a relationship between two classes, indicating that objects of one class are connected to objects of another class. Associations can have multiplicities (e.g., 1..*).
	- Aggregation: Denotes a "whole-part" relationship between classes, where one class (the whole) contains or is composed of instances of another class (the part). Aggregation is depicted using a diamond-shaped hollow arrowhead.
	- Composition: Similar to aggregation but with stronger ownership semantics. In composition, the part class is dependent on the whole class, and the part cannot exist without the whole. Composition is depicted using a solid diamond-shaped arrowhead.
	- Inheritance/Generalization: Represents an "is-a" relationship between classes, where one class (subclass or child) inherits attributes and operations from another class (superclass or parent). Inheritance is depicted using a solid line with a hollow arrowhead pointing from the subclass to the superclass.
	- Realization/Implementation: Denotes a relationship between a class and an interface or abstract class, indicating that the class implements the behavior specified by the interface or abstract class. Realization is depicted using a dashed line with a hollow arrowhead pointing from the implementing class to the interface or abstract class.
- Multiplicity: Represents the cardinality or number of instances participating in a relationship. Multiplicity is specified using numerical values or symbols such as "", "0..1", "1..", etc.

- Dependency: Denotes a relationship where one class depends on another class in some way. Dependencies can be depicted using dashed lines with an arrowhead pointing from the dependent class to the independent class.

- [Resources](https://www.visual-paradigm.com/guide/uml-unified-modeling-language/uml-class-diagram-tutorial/)



### Component Diagram


UML Component diagrams are useful when you need to illustrate the components of a system and their dependencies, interactions, and relationships at a higher level of abstraction. They are particularly helpful in the following scenarios:


#### When do we need Component Diagram

- System Architecture Design: Component diagrams are used to model the high-level structure of a system, showing the various components that make up the system and how they interact with each other. This is especially valuable during the initial design phase of a software project to establish the overall architecture.
- Component-Based Development: In systems built using a component-based approach, where software is composed of reusable and interchangeable components, component diagrams help in visualizing these components and their relationships. This is common in distributed systems, service-oriented architectures (SOA), and microservices architectures.
- Dependency Management: Component diagrams can depict the dependencies between different components of a system, including both static and dynamic dependencies. This helps in understanding how changes to one component may impact other components, aiding in dependency management and modularization.
- System Integration: When integrating multiple subsystems or external components into a larger system, component diagrams provide a clear representation of the interfaces and interactions between these components. This facilitates the integration process by identifying potential points of integration and communication.
- Documentation: Component diagrams serve as a form of documentation for the system architecture, providing a visual overview of the components, their relationships, and their interactions. This documentation is valuable for communication among team members, as well as for onboarding new developers and stakeholders.
- Deployment Planning: Component diagrams can also be used to model the deployment of components onto physical or virtual hardware infrastructure. This includes specifying the deployment units, their locations, and the communication paths between them. It helps in planning the deployment strategy and ensuring scalability, reliability, and performance.
- System Maintenance and Refactoring: During system maintenance or refactoring efforts, component diagrams aid in understanding the existing architecture and identifying areas for improvement or optimization. They help in analyzing the impact of changes on different components and guiding the restructuring of the system.


#### Main components of component diagram

- **Component**: Represents a modular unit of software that encapsulates its implementation and exposes a set of interfaces for interacting with other components. Components can be physical (e.g., executable files, libraries) or conceptual (e.g., modules, subsystems).
- **Interface**: Represents a contract or specification that defines the externally visible operations provided by a component or required by a component. Interfaces define the communication points between components and can be realized by provided and required interfaces.
- **Provided Interface**: Represents the set of operations that a component offers to its environment or other components. It specifies the services or functionalities that the component exposes to its clients.
- **Required Interface**: Represents the set of operations that a component depends on or requires from its environment or other components. It specifies the services or functionalities that the component needs to fulfill its responsibilities.
- **Dependency**: Represents a relationship between two components, where one component relies on another component or uses its services. Dependencies are depicted as arrows pointing from the dependent component to the depended-on component.
- **Association**: Represents a relationship between two components that is not based on the component's behavior but rather on a structural or conceptual connection between them. Associations can represent physical connections, conceptual links, or any other kind of relationship between components.
- **Port**: Represents a connection point or endpoint of a component, through which the component interacts with its environment or other components. Ports are associated with interfaces and define the communication channels through which messages are exchanged.
- **Artifact**: Represents a physical or digital entity, such as a file, database, or document, that is used or produced by a component. Artifacts represent the tangible assets associated with a component and can be included in component diagrams to illustrate the deployment aspects of the system.

- [Example](https://www.drawio.com/blog/uml-component-diagrams)


### Package diagram

UML Package diagrams are useful when you need to organize and structure the elements of a system into cohesive groups, called packages. They are particularly helpful in the following scenarios:

#### When do we need Package Diagram

- **System Organization and Modularization:** Package diagrams are used to organize the various elements of a system, such as classes, interfaces, components, and other packages, into logical groups based on functionality, responsibility, or other criteria. This helps in modularizing the system, making it easier to manage, understand, and maintain.
- **Large-Scale System Design:** In large-scale software systems, managing the complexity of the system architecture is crucial. Package diagrams provide a high-level overview of the system's structure, showing the relationships and dependencies between different modules or subsystems. This aids in designing scalable, maintainable, and extensible systems.
- **Component-Based Development:** Package diagrams are often used in component-based development approaches, where software systems are composed of reusable and interchangeable components. Packages serve as containers for organizing and encapsulating related components, facilitating component reuse and composition.
- **Dependency Management:** Package diagrams depict the dependencies between packages, showing which packages depend on each other and how they are related. This helps in understanding the impact of changes to one package on other packages and guides dependency management and versioning strategies.
- **System Integration:** When integrating multiple subsystems or external components into a larger system, package diagrams provide a clear representation of the structure and dependencies of the integrated components. This aids in identifying integration points, managing inter-package communication, and ensuring compatibility and coherence in the integrated system.
- **Documentation:** Package diagrams serve as a form of documentation for the system architecture, providing a visual representation of the organization and structure of the system. They help in communicating the system's design to stakeholders, team members, and other interested parties, aiding in understanding and collaboration.
- **System Analysis and Planning:** Package diagrams are useful in system analysis and planning activities, such as requirements analysis, system modeling, and architectural design. They provide a visual framework for discussing and refining the system's structure, requirements, and constraints, guiding decision-making and planning efforts.


#### Main components of package diagram

- **Package:** Represents a namespace or container that groups together related elements, such as classes, interfaces, components, or other packages. Packages provide a way to organize and modularize the elements of a system, making it easier to manage and understand.
- **Class:** Represents a blueprint for creating objects in object-oriented programming. Classes define the structure and behavior of objects and can be contained within packages to organize them based on functionality or responsibility.
- **Interface:** Represents a contract or specification that defines a set of operations that a class or component must implement. Interfaces can be contained within packages to organize them and establish relationships between different parts of the system.
- **Component:** Represents a modular unit of software that encapsulates its implementation and exposes a set of interfaces for interacting with other components. Components can be contained within packages to organize them and define the structure of the system.
- **Dependency:** Represents a relationship between two packages, where one package depends on or uses elements from another package. Dependencies are depicted as arrows pointing from the dependent package to the depended-on package.
- **Association:** Represents a relationship between two classes, interfaces, or components that is not based on their behavior but rather on a structural or conceptual connection between them. Associations can be depicted between elements contained within the same package or across different packages.
- **Generalization/Inheritance:** Represents an "is-a" relationship between two classes or interfaces, where one class or interface inherits attributes, operations, and behaviors from another class or interface. Generalization relationships can be depicted within the same package or across different packages.
- **Import:** Represents a relationship between two packages, where one package imports elements from another package to use them within its own context. Import relationships allow packages to reuse elements defined in other packages without needing to redefine them.

- [Example](https://www.lucidchart.com/pages/uml-package-diagram)