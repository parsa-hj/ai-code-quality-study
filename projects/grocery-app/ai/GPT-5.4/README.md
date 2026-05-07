# FreshCart Flutter Grocery App

FreshCart is a modern grocery shopping application built with Flutter, GetX, and a mock data layer. The app is designed for Android, iOS, and Web with a modular clean architecture and reusable UI components.

## Features

- Authentication flows: login, signup, forgot password, and social login placeholders
- Home experience with search, promo banners, categories, popular items, recommendations, and discounts
- Product details with gallery, variants, quantity selector, favorites, and reviews
- Cart with quantity updates, promo code UI, and price breakdown
- Checkout with address selection, delivery options, payment methods, and order summary
- Order success, order history, tracking, and order detail views
- Profile management with saved addresses, payment methods, notification settings, theme toggle, and logout
- Material Design 3 theming with light and dark mode support
- Responsive layouts for mobile, tablet, desktop, and web
- Shared widget library, mock repositories, and scalable folder structure

## Stack

- Flutter 3.x
- Dart 2.17+
- GetX for routing and state management
- shared_preferences for local storage
- connectivity_plus for network awareness scaffolding
- cached_network_image for remote image loading and caching

## Project Structure

```text
lib/
├── main.dart
├── core/
│   ├── constants/
│   ├── errors/
│   ├── network/
│   ├── services/
│   ├── utils/
│   └── app_export.dart
├── data/
│   ├── api_client/
│   ├── models/
│   ├── repositories/
│   └── datasource/
├── localization/
├── presentation/
│   ├── controllers/
│   ├── screens/
│   ├── widgets/
│   └── bindings/
├── routes/
├── theme/
└── widgets/
```

## Getting Started

1. Install Flutter 3.x and confirm the setup with `flutter doctor`.
2. Open the project folder in your IDE.
3. Run `flutter pub get` inside this directory.
4. Launch the app with `flutter run`.

## Notes

- The app uses a local mock API client and dummy JSON data instead of a real backend.
- Social login buttons are intentionally placeholders.
- Network image URLs are pulled from remote demo sources, so an active connection helps the demo look complete.
- Cart items and favorites are persisted locally with shared preferences.

## Suggested Next Steps

- Replace the mock repositories with real API and authentication integrations.
- Add widget tests and golden tests for core flows.
- Introduce localization files for additional languages.
- Add real asset branding, icons, and product photography.
