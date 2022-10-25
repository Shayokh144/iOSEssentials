# DANGER


# Add Danger locally
- Follow this [link](https://blog.bitrise.io/post/danger-danger-uh-that-is-using-danger-with-bitrise) to install and run Danger
- Make sure you run below command in your project folder to setup `Danger` loally. It will create `Danger` file in the folder.

		bundle exec danger init
- To run `Danger CI` locally first we need to add `DANGER_GITHUB_API_TOKEN` in our Envirnment variable using the below command:

		export DANGER_GITHUB_API_TOKEN=GENERATED_API_KEY_FROM_GITHUB
- To run `Danger CI` locally run below command, it will print warnins, failurs in your console:

		bundle exec danger pr LINK_OF_YOUR_PR


# SwiftFormat


- [Install](https://github.com/nicklockwood/SwiftFormat#how-do-i-install-it) first:

		brew install swiftformat
- To update to the latest version once installed:

		brew upgrade swiftformat
- Add swiftformat in project using [cocoapods](https://github.com/nicklockwood/SwiftFormat#using-cocoapods)

## [Add SwiftFormat locally in Xcode](https://github.com/nicklockwood/SwiftFormat#alternative-locally-installed-swiftformat)

- Click on your project in the file list, choose your target under `TARGETS`, click the `Build Phases` tab
- Add a `New Run Script` Phase by clicking the little `plus icon` in the top left
- Add below code to the script:

```bash
if which swiftformat >/dev/null; then
  swiftformat .
else
  echo "warning: SwiftFormat not installed, download from https://github.com/nicklockwood/SwiftFormat"
fi

```

# SwiftLint

- [Install](https://github.com/realm/SwiftLint#installation) first:

		brew install swiftlint
- Add to project using [cocoapods](https://github.com/realm/SwiftLint#using-cocoapods):

		pod 'SwiftLint'

## [Add SwiftLint locally in Xcode](https://github.com/realm/SwiftLint#xcode)
- Click on your project in the file list, choose your target under `TARGETS`, click the `Build Phases` tab
- Add a `New Run Script` Phase by clicking the little `plus icon` in the top left
- Add below code to the script:

```bash
export PATH="$PATH:/opt/homebrew/bin"
if which swiftlint > /dev/null; then
  swiftlint
else
  echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi

```
# Resources
- [SwiftLint](https://github.com/realm/SwiftLint)
- [SwiftFormat](https://github.com/nicklockwood/SwiftFormat)
