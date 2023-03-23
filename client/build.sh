#!/bin/sh
# echo "API_URL=$API_URL" > .env
cat .env
flutter pub get
flutter config --enable-web
flutter build web