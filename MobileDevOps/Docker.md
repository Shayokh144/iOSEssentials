# Docker
In simple terms, Docker is a software platform that simplifies the process of **building**, **running**, **managing** and **distributing** applications. It does this by virtualizing the operating system of the computer on which it is installed and running.

<img src="../staticresources/dockerhost.png" alt="docker host" style="height: 200px; width:500px;"/>

## Docker Host
The machine on which Docker is installed and running is usually referred to as a **Docker Host or Host** in simple terms.

## Docker Container
- A Docker container image is a lightweight, standalone, executable package of software that includes everything needed to run an application: code, runtime, system tools, system libraries and settings.

- A Docker Container doesn’t have any operating system installed and running on it. But it would have a virtual copy of the process table, network interface(s), and the file system mount point(s). These have been inherited from the operating system of the host on which the container is hosted and running. Whereas the kernel of the host’s operating system is shared across all the containers that are running on it. This allows each container to be isolated from the other present on the same host. Thus it supports multiple containers with different application requirements and dependencies to run on the same host, as long as they have the same operating system requirements.

## Advantages of using Docker

- Docker supports multiple applications with different application requirements and dependencies, to be hosted together on the same host, as long as they have the same operating system requirements.

- Storage Optimized. A large number of applications can be hosted on the same host, as containers are usually few megabytes in size and consume very little disk space.

- Robustness. A container does not have an operating system installed on it. Thus, it consumes very little memory in comparison to a virtual machine (which would have a complete operating system installed and running on it). This also reduces the bootup time to just a few seconds, as compared to a couple of minutes required to boot up a virtual machine.

- Reduces costs. Docker is less demanding when it comes to the hardware required to run it.

## Disadvantages of using Docker

- Applications with different operating system requirements cannot be hosted together on the same Docker Host. For example, let’s say we have 4 different applications, out of which 3 applications require a Linux-based operating system and the other application requires a Windows-based operating system. In such a scenario, the 3 applications that require Linux-based operating system can be hosted on a single Docker Host, whereas the application that requires a Windows-based operating system needs to be hosted on a different Docker Host.