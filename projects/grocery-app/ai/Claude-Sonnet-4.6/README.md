# GroceryGo 🛒

A modern, feature-rich grocery shopping application built with Flutter — inspired by Instacart, Blinkit, and BigBasket.

## Features

- **Authentication** — Login, Signup, Forgot Password, Social login placeholders
- **Home** — Promotional banners, categories, popular/recommended products, flash deals
- **Product Details** — Gallery, variants, quantity selector, add to cart, wishlist, ratings & reviews
- **Cart** — Quantity management, promo codes, price breakdown, checkout
- **Checkout** — Address management, delivery options, payment selection, order summary
- **Orders** — Order history, tracking UI, order detail
- **Profile** — User info, saved addresses, payment methods, notifications, dark mode
- **Search** — Real-time search with history
- **Wishlist** — Save and manage favorite products
- **Dark Mode** — Full dark theme support

## Tech Stack

| Layer            | Technology               |
| ---------------- | ------------------------ |
| Framework        | Flutter 3.x              |
| Language         | Dart 2.17+ (null-safe)   |
| State Management | GetX                     |
| Navigation       | GetX routing             |
| Local Storage    | shared_preferences       |
| Network          | connectivity_plus + http |
| Images           | cached_network_image     |
| UI               | Material Design 3        |

## Architecture

Clean architecture with modular structure:

```
lib/
├── main.dart
├── core/
│   ├── constants/      # Colors, strings, sizes, images, app constants
│   ├── errors/         # Custom error types and exceptions
│   ├── network/        # Network connectivity checker
│   ├── services/       # StorageService, AuthService
│   ├── utils/          # Validators, helpers, extensions
│   └── app_export.dart # Barrel export file
├── data/
│   ├── api_client/     # HTTP client wrapper
│   ├── datasource/     # Mock data source
│   ├── models/         # Data models (User, Product, Order, etc.)
│   └── repositories/   # Repository implementations
├── localization/       # i18n support
├── presentation/
│   ├── bindings/       # GetX dependency injection
│   ├── controllers/    # GetX controllers (business logic)
│   ├── screens/        # App screens/pages
│   └── widgets/        # Screen-specific reusable widgets
├── routes/             # Route names and page definitions
├── theme/              # Material 3 theme configuration
└── widgets/            # Global reusable widgets
```

## Getting Started

### Prerequisites

- Flutter SDK 3.x
- Dart SDK 2.17+
- Android Studio / VS Code with Flutter extension

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/your-org/grocery-go.git
   cd grocery-go
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the app**

   ```bash
   # Debug mode
   flutter run

   # Release mode
   flutter run --release

   # Web
   flutter run -d chrome

   # Specific device
   flutter run -d <device-id>
   ```

4. **Build**

   ```bash
   # Android APK
   flutter build apk --release

   # iOS
   flutter build ios --release

   # Web
   flutter build web --release
   ```

### Asset Setup

The app uses network images from picsum.photos for mock data. For production:

- Replace mock image URLs in `lib/data/datasource/mock_data.dart`
- Add actual assets to `assets/images/`, `assets/icons/`, and `assets/animations/`

## Project Structure Details

### Controllers

| Controller           | Responsibility                              |
| -------------------- | ------------------------------------------- |
| `AuthController`     | Login, signup, logout, session              |
| `HomeController`     | Banners, categories, product lists          |
| `ProductController`  | Product detail, variants, reviews           |
| `CartController`     | Cart items, quantities, promo codes         |
| `CheckoutController` | Address, delivery, payment, order placement |
| `OrderController`    | Order history, tracking, detail             |
| `ProfileController`  | User profile, settings                      |
| `SearchController`   | Search query, results, history              |
| `WishlistController` | Wishlist items management                   |

### Screens

| Screen            | Path                 |
| ----------------- | -------------------- |
| Splash            | `/splash`            |
| Onboarding        | `/onboarding`        |
| Login             | `/login`             |
| Signup            | `/signup`            |
| Forgot Password   | `/forgot-password`   |
| Main (Bottom Nav) | `/main`              |
| Product Detail    | `/product-detail`    |
| Cart              | `/cart`              |
| Checkout          | `/checkout`          |
| Order Success     | `/order-success`     |
| Orders            | `/orders`            |
| Order Detail      | `/order-detail`      |
| Order Tracking    | `/order-tracking`    |
| Search            | `/search`            |
| Category Products | `/category-products` |
| Wishlist          | `/wishlist`          |
| Addresses         | `/addresses`         |
| Payment Methods   | `/payment-methods`   |
| Notifications     | `/notifications`     |

## Design System

- **Primary Color**: `#2ECC71` (Fresh Green)
- **Accent Color**: `#FF6B35` (Vibrant Orange)
- **Typography**: Poppins (via Google Fonts)
- **Border Radius**: 8–24px system
- **Spacing**: 4px base grid system

## Mock Data

The app includes comprehensive mock data:

- 25 products across 8 categories
- 3 promotional banners
- 5 order records
- User profile with addresses and payment methods
- Promo codes: `FRESH10`, `SAVE20`, `NEWUSER`

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License.
