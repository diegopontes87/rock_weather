# Rock Weather

## Getting Started

Welcome.

This Flutter Project has the goal to deliver a hibrid mobile app (Android and IOS),
consuming the Weather [API](https://openweathermap.org/api) for 4 specfic cities.

- São Paulo
- Melbourne
- Silverstone
- Monte Carlo

The app contains 2 screens:

1 - A list of cities with their current weathers and a search bar;
2 - A forecast for one specific city from the previous screen.

The chosen architecture for this project was the Clean Architecture and folder the structure is like this:

rock_weather
├lib
│ ├── core
│ ├── dependencies
│ ├── design
│ ├── env
│ ├── shared
│ └── main.dart
└test

### Core:

- Presentation: Layer responsible for holding pages and state managers files
- Domain: Layer responsible for the use cases and repositories contracts files
- Data: Layer responsible for the repositories contracts implementations and the access to local and remotes services.

### Dependencies:

- Dependency Injection files.

### Design:

- Files related to the app design: colors, general widgets, etc.

### Env:

- Files related to the external parameters

### Shared

- Folders and files that provide structure for the rest of the application. Utils, errors, adapters, etc.

## Run the app

To run the application, first you will need to run build_runner to generate important files:

```
dart run build_runner build --delete-conflicting-outputs
```

IMPORTANT:
Create a **.weather_env.json** into the **/env** folder. In the file you will need to add the following json:

```
{
    "baseUrl": "https://api.openweathermap.org/data/2.5",
    "weatherApiKey":"YOUR_API_KEY"
}
```

## Tests

The core folder was the only one tested.

Here is the code to generate the test report for this project.

```
flutter test --coverage && lcov --remove coverage/lcov.info \
 'lib/core/data/weather/models/*' \
 'lib/core/domain/weather/entities/*' \
 'lib/shared/*' \
 'lib/env/*' \
 -o coverage/lcov.info && genhtml coverage/lcov.info \
 -o coverage && open coverage/index.html
```
