# SAC Workshop Frontend

This is a very simple React App (bootstrapped with [Create React App](https://github.com/facebook/create-react-app)) meant to
be used with the backend created in https://github.com/superluminar-io/sac-workshop.

## Available Scripts

In the project directory, you can run:

### `npm start`

Runs the app in the development mode.<br>
Open [http://localhost:3000](http://localhost:3000) to view it in the browser.

The page will reload if you make edits.<br>
You will also see any lint errors in the console.

### `npm test`

Launches the test runner in the interactive watch mode.<br>
See the section about [running tests](https://facebook.github.io/create-react-app/docs/running-tests) for more information.

### `make deploy`

**Attention**: You have to provide a prefix via the PREFIX environment variable, in order to create a universally unique bucket.

`make deploy` will then:

- create a S3 Bucket on the first run
- build the app
- upload the static files to the S3 Bucket
- output the URL where the App can be reached
