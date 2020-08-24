# circleci-dart-demo

Demo repository using Dart lang by Google. Cherry-picks `number_guesser` and `number_thinker` code from [Write HTTP clients & servers](https://dart.dev/tutorials/server/httpserver) tutorial.

## Prerequisites
1. Make sure [Dart is installed and configured](https://dart.dev/get-dart) on your system.
1. Install the `webdev` Dart package globally with `pub global activate webdev`.

## Running Locally
1. Clone this project.
1. Run `pub get` to download dependencies.
1. `pub run bin/circleci_dart_demo.dart` to run the number thinker server.
1. `webdev serve` in another terminal at the project root to serve the basic webpage at https://localhost:8080. Basic dropdown and button to send guess API requests to the server.

## Testing
1. Run `pub run test` to test the `circleci_dart_demo` and `number_guesser` server executables.

## Building
1. `webdev build` compiles the web client (just an `index.html`).
1. `dart2native` compiles the server client to machine code and spits out an executable in `bin`.

## CircleCI
The CircleCI config does the following:

1. It runs the tests on a Docker container.
1. Then it uses a multi-stage Dockerfile to produce a tiny image with the final executable.
1. It also compiles native executables on macOS, Windows, and a Linux VM.

