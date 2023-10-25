# Firebase

## 2 ways of authenticating:
	- FIREBASE_TOKEN
	- GOOGLE_APPLICATION_CREDENTIALS


### FIREBASE_TOKEN
- Install firebase CLI
- Run `firebase login:ci` to generate firebase token
- Add this token in Github Actions/Bitrise secret variable
- Use it in Github Actions/Bitrise workflow file as Env variable


```
    - name: Build App and Distribute to Firebase
      run: bundle exec fastlane buildStagingAndUploadToFirebase
      env:
        FIREBASE_TOKEN: ${{ secrets.FIREBASE_TOKEN }}



```

### GOOGLE_APPLICATION_CREDENTIALS
- For authenticating firebase for using in Github actions or Bitrise we can follow these instructions from [here](https://firebase.google.com/docs/admin/setup):
```
To generate a private key file for your service account:

In the Firebase console, open Settings > Service Accounts.

Click Generate New Private Key, then confirm by clicking Generate Key.

Securely store the JSON file containing the key.
```


- After getting the json file we can convert its content to base64 using openssl:

`openssl base64 -in <infile> -out <outfile>`

- Then we can add this base64 string to Github Actions or Bitrise secret variable and use it to authenticate. Here is an example of Github Actions workflow:



```
    - name: Set Up Google Service Account
      id: firebase_service_account
      uses: timheuer/base64-to-file@v1.2
      with:
        fileName: 'firebase_service_account.json'
        encodedString: ${{ secrets.FIREBASE_GOOGLE_APPLICATION_CREDENTIALS_BASE64 }}


```
- Use output of this step when uploading ipa to firebase

```
    - name: Build App and Distribute to Firebase
      run: bundle exec fastlane buildStagingAndUploadToFirebase
      env:
        GOOGLE_APPLICATION_CREDENTIALS: ${{ steps.firebase_service_account.outputs.filePath }}



```