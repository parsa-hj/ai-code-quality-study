# AI Prompts

## Task Manager
### Base Prompt
Build a modular task manager REST API with authentication using NODE JS and MongoDB. Ensure it follows a RESTFul API design architecture.

## Grocery App
### Base Prompt
Build a modern cross-platform grocery shopping application using Flutter.

Tech Stack
Flutter 3.x
Dart 2.17+
State management: GetX
Local storage: shared_preferences
Network handling: connectivity_plus
Image caching: cached_network_image
Material Design 3
Clean architecture with modular structure
Responsive for Android, iOS, and Web
Goal

Create a polished grocery ecommerce app similar to Instacart / Blinkit / BigBasket with:

modern UI
smooth animations
reusable widgets
scalable architecture
production-ready folder structure
Required Features
Authentication
Login
Signup
Forgot password
Social login placeholders
Home Screen
Search bar
Promotional banners
Categories section
Popular products
Recommended products
Discount section
Product Features
Product details screen
Product gallery
Product variants
Quantity selector
Add to cart
Wishlist/Favorites
Ratings and reviews
Cart
Update quantities
Remove items
Promo code UI
Price breakdown
Checkout button
Checkout
Address management
Delivery options
Payment method selection
Order summary
Order success screen
Orders
Order history
Order tracking UI
Order detail page
Profile
User profile
Saved addresses
Payment methods
Notifications settings
Logout
UI Requirements
Use clean modern grocery ecommerce design
Smooth transitions and micro animations
Rounded cards
Modern typography
Consistent spacing system
Skeleton loading states
Empty states
Error states
Dark mode support
Architecture

Use this exact folder structure:

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
Requirements
Use reusable widgets everywhere
Use GetX for routing and state management
Create mock APIs and dummy JSON data
Include proper model classes
Include loading/error handling
Separate UI from business logic
Follow SOLID principles
Use null safety
Add comments where useful
Ensure code is clean and formatted
Avoid massive widget files
Deliverables

Generate:

Full Flutter project
pubspec.yaml
Theme system
Reusable components
Mock data layer
Responsive layouts
Route management
Sample assets placeholders
README.md with setup instructions