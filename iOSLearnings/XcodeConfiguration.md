# [Xcode Project Configuration]()

## Why
A typical application environment hierarchy may look like:
- Debug – Used by the development team
- Development – Lastest approved development source
- QA / UAT – Latest development source from the previous sprint
- Stable / Production – Tested and approved source for deployment

Many different aspects of the application can change between environments such as:

- API host
- Provisioning Profiles
- Firebase Project
- Network debugging tools
- Development debugging tools
- Project Bundle Ids
- Application versions
- URL Types (Deep / Universal Links, etc)
- Application Features
- Other third-party SDK integrations

Ideally, we would like to specify how each of these aspects of the application can change depending on the selected environment. 


## Resources
- [Configuring scheme](https://shockoe.com/ideas/development/how-to-setup-configurations-and-schemes-in-xcode/)