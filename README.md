# circleci-dart-demo [![CircleCI](https://circleci.com/gh/CircleCI-Public/circleci-dart-demo.svg?style=shield)](https://app.circleci.com/pipelines/github/CircleCI-Public)

Demo repository using Dart lang by Google. Cherry-picks `number_guesser` and `number_thinker` code from [Write HTTP clients & servers](https://dart.dev/tutorials/server/httpserver) tutorial.

Visit the [Dart language guide for CircleCI](https://circleci.com/docs/2.0/language-dart/) here.

## Running Locally

### Prerequisites
1. Make sure [Dart is installed and configured](https://dart.dev/get-dart) on your system.
1. Install the `webdev` Dart package globally with `pub global activate webdev`.

### Setup
1. Clone this project.
1. Run `pub get` to download dependencies.
1. `pub run bin/server.dart` to run the number thinker server. It listens at https://localhost:8080
1. `webdev serve web:8181` in another terminal at the project root to serve the basic webpage at https://localhost:8181. It's just a basic webpage with dropdown and button to send guess API requests to the server.

## Testing
1. Run `pub run test` to test the `server` and `number_guesser`.

## Building
1. `webdev build` compiles the web client (just an `index.html`).
1. `dart2native` compiles the server client to machine code and spits out an executable in `bin`.

## CircleCI
The CircleCI config does the following:

1. It runs the tests on a Docker container.
    - This job uses the `google/dart` Docker image (CircleCI doesn't currently have a native Dart docker convenience image).
    - The tests uses the [junitreporter](https://pub.dev/packages/junitreport) package to produce JUnit XML output for CircleCI's [test metadata feature](https://circleci.com/docs/2.0/collect-test-data/), which in turn supports things like test summary and insights data/metrics.
1. After tests run, it builds executables for deployment:
    - One job uses Google's recommended `dart-runtime` image to build a production container. There's a section that pushes to DockerHub, but that's been commented out since we don't want to unnecessarily spam our repo with example images. It's there as an example.
    - The other three jobs compile native executables on macOS, Windows, and Linux VMs.
1. All jobs use dependency caching. The jobs cache according to the `pubspec.lock` and the `arch` of the system.
    - `~/.pub-cache` and `.dart_tool` folders are cached. `~/AppData/Local/Pub/Cache` if Windows.
    - This demo project doesn't download enough dependencies to show any signficant performance benefit, but it's shown as an example. Larger projects that download many hundreds of MB of dependencies should see greater performance and speed gains.
    - For Dart projects that have it, you'll probably also want to cache the `.packages` folder in the project directory.
1. If you fork this project and want to push to DockerHub, this project assumes [a context](https://circleci.com/docs/2.0/contexts/) called `dart-docker` with the following variables & keys:

KEY           | VALUE
--------------|-----------------------------------
DOCKER_TAG    | The tag/repository for your image
DOCKER_LOGIN  | Your Docker login
DOCKER_PWD    | Your Docker password

See the config and modify as needed for your use case.

For more resources, see below:
- [Getting Started](https://circleci.com/docs/2.0/getting-started/#section=getting-started)
- [Migrating to CircleCI](https://circleci.com/docs/2.0/migration-intro/#section=getting-started)
- [Deploying on CircleCI](https://circleci.com/docs/2.0/deployment-integrations/#section=deployment)
- [Using Contexts](https://circleci.com/docs/2.0/contexts/)
- [Configuration Reference](https://circleci.com/docs/2.0/configuration-reference/#section=configuration)
