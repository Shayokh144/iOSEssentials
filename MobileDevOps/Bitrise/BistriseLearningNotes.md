# [Setting Up Bitrise](https://devcenter.bitrise.io/en/getting-started/getting-started-with-ios-apps.html)

# Debug Bitrise build locally
- Need to install Bitrise CLI using following command:

		brew install bitrise
- To run Bitrise build:
	- Go to project and checkout desired branch in loacl pc
	- Download `bitrise.yml` file from Bitrise app's workflow page and paste it inside the repository
	- Run following command to:
	
			bitrise run WORK_FLOW_NAME

- If error occurs like this: `You don't have write permissions for the /Library/Ruby/Gems/2.3.0 directory.` check [here](https://stackoverflow.com/a/53949737/4245112).
- [Use repository's yml file instead of bitrise's given one](https://www.youtube.com/watch?v=cpdoJ7wjiJY&list=PLbKJc0NMPDrBwlTzcBYbwJZDKIwyYRODG&index=5)

# Add Danger locally
- Follow this [link](https://blog.bitrise.io/post/danger-danger-uh-that-is-using-danger-with-bitrise) to install and run Danger
- Make sure you run below command in your project folder to setup `Danger` loally. It will create `Danger` file in the folder.

		bundle exec danger init
- To run `Danger CI` locally first we need to add `DANGER_GITHUB_API_TOKEN` in out Envirnment variable using the below command:

		export DANGER_GITHUB_API_TOKEN=GENERATED_API_KEY_FROM_GITHUB
- To run `Danger CI` locally run below command, it will print warnins, failurs in your console:

		bundle exec danger pr LINK_OF_YOUR_PR


# Add Danger in Bitrise