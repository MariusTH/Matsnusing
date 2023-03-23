#!/bin/sh
# echo "API_URL=$API_URL" > .env
cat .env
flutter pub get
flutter config --enable-web
echo $API_URL
echo $TEST_ERT
flutter build web --dart-define=SOME_VAR=$API_URL