# weather_app

Flutter app that displays the weather for current location or given city.

## App Download link

[Download the app](https://drive.google)

## Description

This is a Flutter app that displays the weather for the current location or a given city. The app uses the [Weather Api](
https://www.weatherapi.com/) to get the weather data.

## Assets

The `assets` directory houses images, fonts, and any other files you want to
include with your application.

The `assets/images` directory contains [resolution-aware
images](https://flutter.dev/to/resolution-aware-images).

The `assets/icons` directory contains the weather icons used in the app.

## Features

- Get the weather for the current location
- Get the weather for a given city
- Get the weather for a given city by searching for it
- Weather forcast for the next days
- Weather details for the current day
- Weather details for the next days
- Weather details for the next hours
- Sunrise and sunset times
- Wind speed and Uv index

## Chalanges I faced and how I solved them

- Api implmentation with provider: I had to implement the api calls using the provider package, which was a little bit challenging for me. because I had to learn how to use the provider package and how to implement it with the api calls.

- Ui design: The provided design was a little bit complex, specially the bottom part of the screen. I had to make a png image of the bottom part and use it as a Container Background images.

- Weather icons: I had to find the weather icons and make a switch case to display the icons based on the weather condition.


## Installation

1. Clone the repository

```bash
git clone git@github.com:mostafejur21/weather_app.git && cd weather_app
```

2. Install dependencies

```bash
flutter pub get
```

3. Run the app

```bash
flutter run
```

## Used packages

- [provider](https://pub.dev/packages/provider) : State management package
- [http](https://pub.dev/packages/http) : A composable, multi-platform, Future-based API for HTTP requests
- [geolocator](https://pub.dev/packages/geolocator) : A Flutter geolocation plugin which provides easy access to platform specific location services
- [intl](https://pub.dev/packages/intl) : Internationalization and localization facilities
- [flutter_screenutil](https://pub.dev/packages/flutter_screenutil) : A flutter plugin for adapting screen and font size
- [hive](https://pub.dev/packages/hive) : A lightweight and blazing fast key-value database
- [hive_flutter](https://pub.dev/packages/hive_flutter) : Hive database for flutter

## Project structure

```
weather_app/
├── assets/
│   ├── icons/
│   ├── images/
|--lib
├── models/
│   ├── weather_models.dart
├── config/
|   ├── constant.dart
├── providers/
│   ├── weather_provider.dart
├── views/
│   ├── home_screen.dart
├── services
│   ├── location_services.dart
│   ├── storage_services.dart
│   ├── weather_services.dart
├── widgets/
│   ├── current_weather.dart
│   ├── home_contaier.dart
│   ├── search_bar.dart
│   ├── weather_condition.dart
│   ├── weather_forcast.dart
│   ├── weather_location.dart
│   ├── weather_overview.dart
|--main.dart
```