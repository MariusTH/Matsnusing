#!/bin/sh
flutter pub get
flutter config --enable-web
flutter build web --dart-define=API_URL=$API_URL