# #1 Setting up the initial repository from iOS Template
- Added branch rule
- Update **.git/hooks/pre-commit** to prevent direct commit in main, develop branch
    - Change file name to **pre-commit.sample** to **pre-commit**
    - Make it executable by running: **chmod +x pre-commit**
- Run ios template command: **sh make.sh --bundle-id com.example.weathertoday --bundle-id-staging com.example.weathertoday --project-name WeatherToday**


# #3 Need to remove all CI/CD related codes and files from the project


# Debug Bitrise build
- Need to install Bitrise CLI using following command:

	brew install bitrise
- To run Bitrise build:
	- Go to project and checkout desired branch in loacl pc
	- Download `bitrise.yml` file from Bitrise app's workflow page and paste it inside the repository
	- Run following command to:

	bitrise run WORK_FLOW_NAME

- If error occurs like this: `You don't have write permissions for the /Library/Ruby/Gems/2.3.0 directory.` check [here](https://stackoverflow.com/a/53949737/4245112).
- [Use repository's yml file instead of bitrise's given one](https://www.youtube.com/watch?v=cpdoJ7wjiJY&list=PLbKJc0NMPDrBwlTzcBYbwJZDKIwyYRODG&index=5)