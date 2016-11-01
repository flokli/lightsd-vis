# lightsd-vis

## Visualization for lightsd

Configure lightsd to provide a websocket monitor.

Set the Websocket URI in `src/app.coffee` to the correct one.

### Install requirements
Install requirements by running `npm install`.

#### Building the code
If you want to build to code to a distributable version, use `npm run build`.
This will output a distributable version inside the `public/` directory.

#### Developing
Use the `npm start` command to run a development webserver at a local port.
It will automatically detect changes and trigger rebuilds if necessary.
