# Quiz App

A Flutter-based quiz application with a Golang backend.

## Project Overview

This Quiz App is a mobile application built using Flutter for the frontend and Golang for the backend. It provides an interactive platform for users to take quizzes on various topics.

## Features

- Interactive quiz interface
- Multiple choice questions
- Score tracking
- User Naming
- Leaderboard 

## Tech Stack

### Frontend
- Flutter
- Dart
- Dependencies:
  - http: For making API requests
  - provider: For state management
  - shared_preferences: For local data storage
  - flutter_secure_storage: For secure storage of sensitive data
  - cached_network_image: For efficient image loading
  - audioplayers: For sound effects
  - lottie: For animations
  - flutter_staggered_animations: For staggered animations

### Backend
- Golang
- Dependencies:
  - gin-gonic/gin: Web framework
  - gin-contrib/cors: For handling CORS

## Getting Started

1. Clone the repository
2. Set up the Flutter environment
3. Install dependencies:
   ```
   flutter pub get
   ```
4. Run the app:
   ```
   flutter run
   ```

## Project Structure

- `lib/`: Contains the main Flutter application code
- `quiz_backend/`: Contains the Golang backend code
- `assets/`: Stores images, sounds, and animations used in the app

## Configuration

- Frontend configuration can be found in `pubspec.yaml`
- Backend configuration can be found in `quiz_backend/go.mod`

## Development

To start developing:

1. Open the project in your preferred IDE (e.g., VS Code, Android Studio)
2. Make sure you have Flutter and Dart plugins installed
3. Run the app in debug mode to see live changes

## Building for Production

To build the app for production:

```
flutter build apk  # For Android
flutter build ios  # For iOS
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open source and available under the [MIT License](LICENSE).
