# Kiddocare

A Flutter application for finding and exploring kindergartens.

## Features

- Browse kindergartens in a grid layout
- Infinite scroll pagination for loading more kindergartens
- View detailed information about each kindergarten
- Loading states and error handling
- Responsive design with 2-column grid

## Project Structure

- `lib/screens/` - Main application screens
  - `listing_screen.dart` - Shows the grid of kindergartens
  - `detail_screen.dart` - Shows detailed kindergarten information

- `lib/providers/` - State management
  - `kindergarten_provider.dart` - Manages kindergarten data and pagination

- `lib/models/` - Data models
  - `kindergarten.dart` - Kindergarten data structure

- `lib/services/` - API and backend services
  - `api_service.dart` - Handles API requests

- `lib/widgets/` - Reusable UI components
  - `kindergarten_card.dart` - Card widget for displaying kindergarten preview
  - `loading.dart` - Loading indicators
  - `no_data.dart` - Empty state widget

## Getting Started

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the application

## Dependencies

- provider: For state management
- flutter: SDK version (add your Flutter version)
