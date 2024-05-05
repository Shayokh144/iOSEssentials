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




### Deployment Diagram

A UML deployment diagram is a diagram that shows the configuration of run time processing nodes and the components that live on them.

They are particularly helpful in the following scenarios:

#### When do we need Deployment Diagram
- **System Architecture Design:** Deployment diagrams are used to design the physical architecture of a system, showing how software components are distributed across hardware nodes or servers. This helps in understanding the system's deployment topology and the relationship between software and hardware components.
- **Infrastructure Planning:** Deployment diagrams aid in planning the infrastructure requirements for deploying a software system. They provide insights into the hardware resources needed, such as servers, networks, storage devices, and other infrastructure components, helping in capacity planning and resource allocation.
- **System Integration:** When integrating multiple software systems or subsystems into a larger system, deployment diagrams help in visualizing the deployment configuration and the interactions between different components. This aids in identifying integration points, managing dependencies, and ensuring interoperability between systems.
- **Deployment Automation:** Deployment diagrams can be used as a basis for automating the deployment process, including provisioning hardware resources, configuring software components, and managing deployment workflows. They provide a blueprint for orchestrating deployment tasks and streamlining the deployment process.
- **Scalability and Performance Analysis:** Deployment diagrams assist in analyzing the scalability and performance of a system by visualizing the distribution of software components across hardware nodes. They help in identifying bottlenecks, optimizing resource utilization, and designing scalable and high-performance architectures.
- **Fault Tolerance and Disaster Recovery:** Deployment diagrams aid in designing fault-tolerant and resilient systems by visualizing redundant components, failover mechanisms, and disaster recovery strategies. They help in planning for system failures, minimizing downtime, and ensuring business continuity.
- **Documentation:** Deployment diagrams serve as a form of documentation for the system's deployment architecture, providing a visual representation of the deployment configuration and topology. They help in communicating deployment requirements, dependencies, and constraints to stakeholders, operations teams, and other interested parties.



#### Main components of deployment diagram

- **Node:** Represents a physical hardware device or computing resource on which software components are deployed. Nodes can range from individual servers, desktop computers, and mobile devices to virtual machines, containers, and cloud instances.
- **Component:** Represents a modular unit of software that encapsulates its implementation and functionality. Components are deployed onto nodes and interact with other components to perform specific tasks or provide services.
- **Artifact:** Represents a physical or digital entity, such as a file, database, or executable, that is used or produced by a software component. Artifacts are deployed onto nodes and represent the tangible assets associated with the software system.
- **Dependency:** Represents a relationship between two nodes or between a node and an artifact, indicating that one element depends on or requires another element to function properly. Dependencies specify the relationships and interactions between different parts of the deployment architecture.
- **Association:** Represents a relationship between a node and a component or between two components, indicating that one element is hosted or deployed on another element. Associations specify the deployment configuration and topology of the software components on the hardware nodes.
- **Communication Path:** Represents the communication channels or connections between nodes, indicating how data and messages are exchanged between different parts of the deployment architecture. Communication paths specify the network infrastructure and protocols used for communication.
- **Deployment Specification:** Represents a configuration or set of parameters that define how a component or artifact is deployed onto a node. Deployment specifications specify the deployment settings, environment variables, runtime options, and other deployment-related attributes.

- [Example](https://www.lucidchart.com/pages/uml-deployment-diagram)



### UseCase Diagram

UML UseCase diagrams are useful when you need to model the interactions between users (actors) and a system in terms of the system's behavior and functionality. They are particularly helpful in the following scenarios:

#### When do we need UseCase Diagram
- **Requirements Analysis:** Use Case diagrams are commonly used during the requirements analysis phase to identify and define the functional requirements of a system. They help in capturing the goals, tasks, and interactions of the system's users, providing a basis for understanding what the system needs to do.
- **System Design and Architecture:** Use Case diagrams aid in designing the system's architecture by identifying the main functionalities and features that the system must provide to its users. They help in defining the scope of the system, organizing its functionality into coherent units, and establishing the boundaries of the system's responsibilities.
- **Communication with Stakeholders:** Use Case diagrams serve as a means of communication between developers, designers, testers, and other stakeholders involved in the project. They provide a visual representation of the system's behavior and functionality in a format that is easily understandable by non-technical stakeholders.
- **User Interface Design:** Use Case diagrams help in designing the user interface of the system by - identifying the various use cases (user tasks or goals) that users need to perform and the interactions required to accomplish those tasks. They provide insights into the user's perspective and help in designing intuitive and user-friendly interfaces.
- **Testing and Validation:** Use Case diagrams serve as a basis for testing and validating the system's functionality by providing a set of test cases derived from the identified use cases. They help in ensuring that the system meets the user's requirements and expectations and that it behaves as intended in different scenarios.
- **System Documentation:** Use Case diagrams serve as a form of documentation for the system's functionality and behavior, providing a high-level overview of the system's use cases, actors, and interactions. They help in documenting the system's requirements, design decisions, and user workflows for future reference and maintenance.
- **System Evolution and Iterative Development:** Use Case diagrams support iterative and incremental development approaches by providing a flexible framework for refining and evolving the system's functionality over time. They allow for the addition, modification, or removal of use cases based on changing requirements and feedback from users.


#### Main components of UseCase diagram

- **Use Case:** Represents a specific goal, task, or functionality that a system provides to its users (actors). Use cases describe the interactions between the system and its users and capture the system's behavior from the user's perspective. Each use case represents a discrete unit of functionality that delivers value to the user.

- **Actor:** Represents a role played by a user, external system, or entity that interacts with the system to achieve a specific goal or perform a specific task. Actors are external to the system and interact with the system by initiating and participating in use cases. They are connected to use cases through associations.

- **System Boundary:** Represents the boundary of the system under consideration in the Use Case diagram. It delineates the scope of the system and defines the context in which the use cases and actors operate. The system boundary encloses all the use cases and actors relevant to the system being modeled.

- **Association:** Represents a relationship between an actor and a use case, indicating that the actor is involved in or interacts with the use case. Associations are depicted as lines connecting actors to use cases and represent the communication and collaboration between actors and use cases.

- **Include Relationship:** Represents a relationship between two use cases, indicating that one use case includes the functionality of another use case. Include relationships are depicted as dashed arrows from the including use case to the included use case and represent the common or shared functionality between use cases.

- **Extend Relationship:** Represents a relationship between two use cases, indicating that one use case extends the behavior of another use case under certain conditions or scenarios. Extend relationships are depicted as dashed arrows from the extending use case to the extended use case and represent optional or alternative behavior.

- **Generalization/Inheritance:** Represents an "is-a" relationship between two use cases, indicating that one use case inherits behavior from another use case. Generalization relationships are depicted as solid arrows from the specialized (child) use case to the generalized (parent) use case and represent specialization and inheritance of behavior.

- [Example](https://www.visual-paradigm.com/guide/uml-unified-modeling-language/what-is-use-case-diagram/)




### Sequence Diagram

UML Sequence Diagrams are interaction diagrams that detail how operations are carried out. They capture the interaction between objects in the context of a collaboration. Sequence Diagrams are time focus and they show the order of the interaction visually by using the vertical axis of the diagram to represent time what messages are sent and when. They are particularly helpful in the following scenarios:

#### When do we need Sequence Diagram

- Behavioral Modeling: Sequence diagrams are commonly used to model the dynamic behavior of a system by illustrating the sequence of messages exchanged between objects or components during the execution of a use case or scenario. They provide insights into how objects collaborate and interact to achieve a particular functionality.

- Requirements Analysis: Sequence diagrams are used during requirements analysis to capture and refine the interactions and communication patterns between objects or components in a system. They help in understanding the flow of control and data between objects and in refining the requirements based on the identified interactions.

- System Design and Architecture: Sequence diagrams aid in designing the system's architecture by specifying the interactions and collaborations between objects or components within the system. They help in defining the structure and behavior of the system and in identifying the responsibilities and interactions of different components.

- Communication with Stakeholders: Sequence diagrams serve as a means of communication between developers, designers, testers, and other stakeholders involved in the project. They provide a visual representation of the system's behavior and interactions in a format that is easily understandable by both technical and non-technical stakeholders.

- Design Validation and Verification: Sequence diagrams are used to validate and verify the design of a system by simulating and analyzing the interactions between objects or components under different scenarios and conditions. They help in identifying potential issues, bottlenecks, or inconsistencies in the system's design and architecture.

- System Testing: Sequence diagrams serve as a basis for designing and executing system tests by specifying the expected interactions and behaviors of the system under test. They help in generating test cases, designing test scenarios, and validating the correctness and completeness of the system's implementation.

- System Documentation: Sequence diagrams serve as a form of documentation for the system's behavior and interactions, providing a visual representation of the sequence of events and messages exchanged between objects or components. They help in documenting the system's design decisions, requirements, and implementation details for future reference and maintenance.



#### Main components of Sequence diagram

- **Actor:** Represents an external entity, such as a user, system, or component, that interacts with the system being modeled. Actors are depicted as stick figures and participate in sequence diagrams by sending and receiving messages to and from objects.

- **Object:** Represents an instance of a class or component within the system being modeled. Objects are depicted as rectangles with the name of the object inside. They participate in sequence diagrams by sending and receiving messages to and from other objects.

- **Lifeline:** Represents the existence of an object over a period of time within the sequence diagram. Lifelines are depicted as vertical dashed lines extending from the top to the bottom of the diagram, with the object's name or reference at the top.

- **Message:** Represents a communication or interaction between objects in the sequence diagram. Messages are depicted as arrows that flow between lifelines, indicating the flow of control or data between objects. Messages can be synchronous (denoted by a solid arrow), asynchronous (denoted by an open arrow), or self-referential (loop arrow).

- **Activation:** Represents the period of time during which an object is actively processing or executing a message. Activations are depicted as narrow rectangles or bars along the lifeline, indicating when the object is processing the message and when it is idle.

- **Return Message:** Represents a response or return value sent by an object in response to a message received from another object. Return messages are depicted as dashed arrows flowing back along the lifeline from the receiving object to the sending object.

- **Interaction Fragment:** Represents a portion of the sequence diagram that groups together related messages or interactions. Interaction fragments include alternatives (alt), options (opt), loops (loop), and parallel combined fragments, which help in representing conditional and repetitive behavior within the sequence diagram.

- [Example](https://www.visual-paradigm.com/guide/uml-unified-modeling-language/what-is-sequence-diagram/)


### State Diagram

A state diagram consists of states, transitions, events, and activities. You use state diagrams to illustrate the dynamic view of a system. They are especially important in modeling the behavior of an interface, class, or collaboration. State diagrams emphasize the event-ordered behavior of an object, which is especially useful in modeling reactive systems. They are particularly helpful in the following scenarios:


#### When do we need State Diagram

- **Behavioral Modeling:** State diagrams are commonly used to model the behavior of complex systems by representing their various states and transitions between states. They provide insights into how a system responds to events and changes its behavior over time, helping in understanding the system's dynamic behavior.

- **System Design and Architecture:** State diagrams aid in designing the system's architecture by specifying the states, transitions, and behaviors of the system's components. They help in defining the structure and behavior of the system and in identifying the responsibilities and interactions of different components.

- **Requirements Analysis:** State diagrams are used during requirements analysis to capture and refine the behavior and functionality of a system. They help in identifying the different states that the system can be in, the events that trigger state transitions, and the actions that occur in each state.

- **User Interface Design: **State diagrams help in designing the user interface of the system by specifying the different states and transitions that the user interface can go through. They provide insights into the user's interactions with the system and help in designing intuitive and user-friendly interfaces.

- **Communication with Stakeholders:** State diagrams serve as a means of communication between developers, designers, testers, and other stakeholders involved in the project. They provide a visual representation of the system's behavior and interactions in a format that is easily understandable by both technical and non-technical stakeholders.

- **Design Validation and Verification:** State diagrams are used to validate and verify the design of a system by simulating and analyzing its behavior under different scenarios and conditions. They help in identifying potential issues, edge cases, or inconsistencies in the system's behavior and design.

- **System Testing:** State diagrams serve as a basis for designing and executing system tests by specifying the expected behavior and states of the system under test. They help in generating test cases, designing test scenarios, and validating the correctness and completeness of the system's implementation.

- **System Documentation:** State diagrams serve as a form of documentation for the system's behavior and state transitions, providing a visual representation of the system's dynamic behavior. They help in documenting the system's requirements, design decisions, and implementation details for future reference and maintenance.

#### Main components of State diagram

- **State:** Represents a condition or situation in the behavior of a system. States represent the different modes or configurations in which the system can exist at any given time. Each state defines a specific set of behaviors or actions that the system performs while in that state.

- **Transition:** Represents a change of state in response to an event or condition. Transitions specify the conditions under which a state change occurs and the actions or behaviors that are triggered as a result of the transition. Transitions are depicted as arrows between states and are labeled with the triggering event or condition.

- **Initial State:** Represents the starting point of the state diagram, indicating the initial state of the system when it first enters the diagram. The initial state is depicted as a filled circle with an incoming arrow and is labeled with the name of the initial state.

- **Final State:** Represents the end point of the state diagram, indicating the final state of the system when it exits the diagram. The final state is depicted as a filled circle with no outgoing transitions and is labeled with the name of the final state.

- **Event:** Represents an occurrence or happening that triggers a state transition. Events can be internal or external to the system and can include user actions, system inputs, environmental changes, or timer expirations. Events are associated with transitions and specify the conditions under which a transition occurs.

- **Guard Condition:** Represents a Boolean expression that must be satisfied for a transition to occur. Guard conditions specify additional constraints or criteria that must be met before a transition can take place. Guard conditions are associated with transitions and are evaluated when the transition is triggered by an event.

- **Action:** Represents a behavior or activity that occurs in response to a state transition. Actions specify the operations or tasks that are performed when a transition occurs and can include updates to internal data, interactions with external systems, or changes to the system's behavior. Actions are associated with transitions and are executed when the transition is triggered by an event.

