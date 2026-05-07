/// All string constants used throughout the GroceryGo app.
class AppStrings {
  AppStrings._();

  static const String appName = 'GroceryGo';
  static const String appTagline = 'Fresh groceries, delivered fast';

  // ─── Auth ─────────────────────────────────────────────────────────────────
  static const String login = 'Login';
  static const String signup = 'Sign Up';
  static const String forgotPassword = 'Forgot Password';
  static const String email = 'Email address';
  static const String password = 'Password';
  static const String confirmPassword = 'Confirm Password';
  static const String fullName = 'Full Name';
  static const String phoneNumber = 'Phone Number';
  static const String rememberMe = 'Remember me';
  static const String orContinueWith = 'Or continue with';
  static const String dontHaveAccount = "Don't have an account? ";
  static const String alreadyHaveAccount = 'Already have an account? ';
  static const String continueWithGoogle = 'Continue with Google';
  static const String continueWithApple = 'Continue with Apple';
  static const String continueWithFacebook = 'Continue with Facebook';
  static const String resetPassword = 'Reset Password';
  static const String sendResetLink = 'Send Reset Link';
  static const String checkEmail = 'Check your email';
  static const String resetEmailSent =
      "We've sent a password reset link to your email address.";
  static const String welcomeBack = 'Welcome back!';
  static const String createAccount = 'Create an account';
  static const String loginSubtitle = 'Login to continue shopping';
  static const String signupSubtitle = 'Fill in the details below to get started';

  // ─── Navigation ───────────────────────────────────────────────────────────
  static const String home = 'Home';
  static const String categories = 'Categories';
  static const String cart = 'Cart';
  static const String orders = 'Orders';
  static const String profile = 'Profile';

  // ─── Home ─────────────────────────────────────────────────────────────────
  static const String searchProducts = 'Search products...';
  static const String featured = 'Featured';
  static const String popular = 'Popular';
  static const String recommended = 'Recommended';
  static const String flashDeals = 'Flash Deals';
  static const String seeAll = 'See All';
  static const String goodMorning = 'Good Morning';
  static const String goodAfternoon = 'Good Afternoon';
  static const String goodEvening = 'Good Evening';
  static const String deliverTo = 'Deliver to';
  static const String allCategories = 'All Categories';

  // ─── Product ──────────────────────────────────────────────────────────────
  static const String addToCart = 'Add to Cart';
  static const String buyNow = 'Buy Now';
  static const String addToWishlist = 'Add to Wishlist';
  static const String removeFromWishlist = 'Remove from Wishlist';
  static const String productDetails = 'Product Details';
  static const String description = 'Description';
  static const String reviews = 'Reviews';
  static const String noReviews = 'No reviews yet';
  static const String inStock = 'In Stock';
  static const String outOfStock = 'Out of Stock';
  static const String selectVariant = 'Select Variant';
  static const String quantity = 'Quantity';
  static const String similarProducts = 'You may also like';
  static const String writeReview = 'Write a Review';

  // ─── Cart ─────────────────────────────────────────────────────────────────
  static const String myCart = 'My Cart';
  static const String cartEmpty = 'Your cart is empty';
  static const String cartEmptyDesc =
      "Looks like you haven't added any items to your cart yet.";
  static const String startShopping = 'Start Shopping';
  static const String promoCode = 'Promo Code';
  static const String applyCode = 'Apply';
  static const String enterPromoCode = 'Enter promo code';
  static const String subtotal = 'Subtotal';
  static const String discount = 'Discount';
  static const String deliveryFee = 'Delivery Fee';
  static const String total = 'Total';
  static const String proceedToCheckout = 'Proceed to Checkout';
  static const String free = 'FREE';
  static const String removeItem = 'Remove Item';
  static const String itemRemoved = 'Item removed from cart';
  static const String invalidPromoCode = 'Invalid promo code';
  static const String promoApplied = 'Promo code applied!';

  // ─── Checkout ─────────────────────────────────────────────────────────────
  static const String checkout = 'Checkout';
  static const String deliveryAddress = 'Delivery Address';
  static const String addAddress = 'Add New Address';
  static const String changeAddress = 'Change';
  static const String deliveryOptions = 'Delivery Options';
  static const String standardDelivery = 'Standard Delivery';
  static const String expressDelivery = 'Express Delivery';
  static const String scheduledDelivery = 'Scheduled Delivery';
  static const String paymentMethod = 'Payment Method';
  static const String addPaymentMethod = 'Add Payment Method';
  static const String orderSummary = 'Order Summary';
  static const String placeOrder = 'Place Order';
  static const String creditCard = 'Credit / Debit Card';
  static const String cashOnDelivery = 'Cash on Delivery';
  static const String digitalWallet = 'Digital Wallet';
  static const String days13 = '1–3 business days';
  static const String sameDay = 'Same day (before 8 PM)';
  static const String chooseTime = 'Choose a time slot';

  // ─── Order Success ────────────────────────────────────────────────────────
  static const String orderPlaced = 'Order Placed!';
  static const String orderPlacedDesc =
      "Your order has been placed successfully. We'll notify you when it's on the way!";
  static const String trackOrder = 'Track Order';
  static const String continueShopping = 'Continue Shopping';

  // ─── Orders ───────────────────────────────────────────────────────────────
  static const String myOrders = 'My Orders';
  static const String orderHistory = 'Order History';
  static const String noOrders = 'No orders yet';
  static const String noOrdersDesc =
      'Your order history will appear here once you start shopping.';
  static const String orderDetails = 'Order Details';
  static const String orderTracking = 'Track Order';
  static const String orderId = 'Order ID';
  static const String orderDate = 'Order Date';
  static const String orderStatus = 'Status';
  static const String items = 'items';
  static const String item = 'item';
  static const String reorder = 'Reorder';

  // ─── Order Status ─────────────────────────────────────────────────────────
  static const String pending = 'Pending';
  static const String confirmed = 'Confirmed';
  static const String processing = 'Processing';
  static const String shipped = 'Shipped';
  static const String outForDelivery = 'Out for Delivery';
  static const String delivered = 'Delivered';
  static const String cancelled = 'Cancelled';

  // ─── Profile ──────────────────────────────────────────────────────────────
  static const String myProfile = 'My Profile';
  static const String editProfile = 'Edit Profile';
  static const String savedAddresses = 'Saved Addresses';
  static const String paymentMethods = 'Payment Methods';
  static const String notifications = 'Notifications';
  static const String settings = 'Settings';
  static const String darkMode = 'Dark Mode';
  static const String language = 'Language';
  static const String helpSupport = 'Help & Support';
  static const String privacyPolicy = 'Privacy Policy';
  static const String termsConditions = 'Terms & Conditions';
  static const String logout = 'Logout';
  static const String logoutConfirm = 'Are you sure you want to logout?';
  static const String deleteAccount = 'Delete Account';
  static const String appVersion = 'App Version';

  // ─── Notifications ────────────────────────────────────────────────────────
  static const String notificationSettings = 'Notification Settings';
  static const String orderUpdates = 'Order Updates';
  static const String orderUpdatesDesc = 'Get notified about your order status';
  static const String promotions = 'Promotions & Offers';
  static const String promotionsDesc = 'Receive exclusive deals and offers';
  static const String reminders = 'Reminders';
  static const String remindersDesc = 'Shopping list and cart reminders';
  static const String pushNotifications = 'Push Notifications';
  static const String emailNotifications = 'Email Notifications';
  static const String smsNotifications = 'SMS Notifications';

  // ─── Wishlist ─────────────────────────────────────────────────────────────
  static const String wishlist = 'Wishlist';
  static const String wishlistEmpty = 'Your wishlist is empty';
  static const String wishlistEmptyDesc =
      'Save items you love to your wishlist and shop them later.';
  static const String addedToWishlist = 'Added to wishlist';
  static const String removedFromWishlist = 'Removed from wishlist';

  // ─── Search ───────────────────────────────────────────────────────────────
  static const String search = 'Search';
  static const String searchHistory = 'Recent Searches';
  static const String popularSearches = 'Popular Searches';
  static const String noResults = 'No results found';
  static const String noResultsDesc =
      'Try different keywords or browse our categories.';
  static const String clearAll = 'Clear All';

  // ─── Validation Errors ────────────────────────────────────────────────────
  static const String emailRequired = 'Email is required';
  static const String emailInvalid = 'Please enter a valid email address';
  static const String passwordRequired = 'Password is required';
  static const String passwordTooShort = 'Password must be at least 6 characters';
  static const String passwordsNotMatch = 'Passwords do not match';
  static const String nameRequired = 'Name is required';
  static const String phoneRequired = 'Phone number is required';
  static const String phoneInvalid = 'Please enter a valid phone number';
  static const String somethingWrong = 'Something went wrong. Please try again.';
  static const String networkError =
      'No internet connection. Please check your network.';
  static const String sessionExpired = 'Session expired. Please login again.';
  static const String addressRequired = 'Please add a delivery address';
  static const String paymentRequired = 'Please select a payment method';

  // ─── Success Messages ─────────────────────────────────────────────────────
  static const String loginSuccess = 'Welcome back!';
  static const String signupSuccess = 'Account created successfully!';
  static const String profileUpdated = 'Profile updated successfully!';
  static const String addressAdded = 'Address added successfully!';
  static const String addressDeleted = 'Address deleted';
  static const String addressUpdated = 'Address updated!';

  // ─── Onboarding ───────────────────────────────────────────────────────────
  static const String onboarding1Title = 'Fresh & Quality Products';
  static const String onboarding1Desc =
      'Shop from thousands of fresh, quality products delivered straight to your door.';
  static const String onboarding2Title = 'Fast Delivery';
  static const String onboarding2Desc =
      'Get your groceries delivered in as fast as 30 minutes with our express delivery.';
  static const String onboarding3Title = 'Easy Payments';
  static const String onboarding3Desc =
      'Multiple payment options for your convenience — cards, wallets, and cash on delivery.';
  static const String getStarted = 'Get Started';
  static const String next = 'Next';
  static const String skip = 'Skip';

  // ─── General ──────────────────────────────────────────────────────────────
  static const String cancel = 'Cancel';
  static const String confirm = 'Confirm';
  static const String save = 'Save';
  static const String delete = 'Delete';
  static const String edit = 'Edit';
  static const String add = 'Add';
  static const String done = 'Done';
  static const String loading = 'Loading...';
  static const String retry = 'Retry';
  static const String ok = 'OK';
  static const String close = 'Close';
  static const String yes = 'Yes';
  static const String no = 'No';
  static const String update = 'Update';
  static const String apply = 'Apply';
  static const String remove = 'Remove';
  static const String swipeToDelete = 'Swipe left to remove';

  // ─── Additional strings ────────────────────────────────────────────────────
  // Auth
  static const String welcomeBack = 'Welcome back! 👋';
  static const String loginSubtitle = 'Sign in to your account to continue';
  static const String createAccount = 'Create Account';
  static const String fullName = 'Full Name';
  static const String phone = 'Phone Number';
  static const String phoneOptional = 'Phone Number (Optional)';
  static const String confirmPassword = 'Confirm Password';
  static const String sendResetLink = 'Send Reset Link';
  static const String forgotPasswordTitle = 'Forgot Password?';
  static const String forgotPasswordSubtitle =
      'Enter your email and we\'ll send you a link to reset your password.';
  static const String rememberMe = 'Remember me';
  static const String dontHaveAccount = "Don't have an account?";
  static const String alreadyHaveAccount = 'Already have an account?';

  // Home
  static const String seeAll = 'See All';
  static const String flashDeals = '⚡ Flash Deals';
  static const String popularProducts = 'Popular Products';
  static const String recommended = 'Recommended for You';
  static const String youMayAlsoLike = 'You may also like';

  // Product detail
  static const String selectVariant = 'Select Variant';
  static const String description = 'Description';
  static const String reviews = 'Customer Reviews';
  static const String addToCart = 'Add to Cart';
  static const String outOfStock = 'Out of Stock';

  // Cart
  static const String myCart = 'My Cart';
  static const String clearCart = 'Clear Cart';
  static const String clearCartConfirm = 'Are you sure you want to clear your cart?';
  static const String clear = 'Clear';
  static const String emptyCart = 'Your cart is empty';
  static const String emptyCartSubtitle = 'Add items from the store to get started.';
  static const String subtotal = 'Subtotal';
  static const String delivery = 'Delivery';
  static const String total = 'Total';
  static const String proceedToCheckout = 'Proceed to Checkout';
  static const String free = 'FREE';

  // Checkout
  static const String checkout = 'Checkout';
  static const String deliveryAddress = 'Delivery Address';
  static const String deliveryOption = 'Delivery Option';
  static const String paymentMethod = 'Payment Method';
  static const String promoCode = 'Promo Code';
  static const String enterPromoCode = 'Enter promo code';
  static const String invalidPromoCode = 'Invalid or expired promo code';
  static const String discount = 'Discount';
  static const String orderPlacedSubtitle =
      'Your order has been placed successfully! We\'ll notify you when it\'s on the way.';
  static const String orderNumber = 'Order';

  // Orders
  static const String orderDetail = 'Order Detail';
  static const String trackingTimeline = 'Tracking';
  static const String startShopping2 = 'Shop Now';

  // Profile
  static const String profile = 'Profile';
  static const String myAddresses = 'My Addresses';
  static const String saveChanges = 'Save Changes';
  static const String logoutConfirm2 = 'Are you sure you want to logout?';

  // Addresses
  static const String addressLine1 = 'Address Line 1';
  static const String city = 'City';
  static const String state = 'State';
  static const String postalCode = 'Postal Code';
  static const String saveAddress = 'Save Address';
  static const String noAddresses = 'No saved addresses';
  static const String setAsDefault = 'Set as Default';

  // Notifications
  static const String pushNotificationsTitle = 'Push Notifications';
  static const String contactNotifications = 'Contact Notifications';
  static const String promotionsLabel = 'Promotions & Offers';
  static const String remindersLabel = 'Reminders';
  static const String emailNotificationsLabel = 'Email Notifications';
  static const String emailNotificationsDesc = 'Receive order confirmations and offers via email';
  static const String smsNotificationsLabel = 'SMS Notifications';
  static const String smsNotificationsDesc = 'Receive order updates via SMS';

  // Wishlist
  static const String emptyWishlist = 'Your wishlist is empty';
  static const String emptyWishlistSubtitle = 'Save items you love to shop later.';
  static const String discoverProducts = 'Discover Products';

  // Search
  static const String searchHint = 'Search groceries...';
  static const String recentSearches = 'Recent Searches';
  static const String noResultsFor = 'No results for';

  // Category
  static const String noProducts = 'No products in this category';

  // General extra
  static const String addAddress = 'Add Address';
  static const String items2 = 'Items';
}

