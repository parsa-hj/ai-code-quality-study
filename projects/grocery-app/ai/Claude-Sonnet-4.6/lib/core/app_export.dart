// ─── Flutter ──────────────────────────────────────────────────────────────────
export 'package:flutter/material.dart';
export 'package:flutter/services.dart';
export 'package:get/get.dart';

// ─── Constants ────────────────────────────────────────────────────────────────
export 'package:grocery_app/core/constants/app_colors.dart';
export 'package:grocery_app/core/constants/app_strings.dart';
export 'package:grocery_app/core/constants/app_sizes.dart';
export 'package:grocery_app/core/constants/app_images.dart';
export 'package:grocery_app/core/constants/app_constants.dart';

// ─── Errors ───────────────────────────────────────────────────────────────────
export 'package:grocery_app/core/errors/app_error.dart';
export 'package:grocery_app/core/errors/exceptions.dart';

// ─── Network ──────────────────────────────────────────────────────────────────
export 'package:grocery_app/core/network/network_info.dart';

// ─── Services ─────────────────────────────────────────────────────────────────
export 'package:grocery_app/core/services/storage_service.dart';
export 'package:grocery_app/core/services/auth_service.dart';

// ─── Utils ────────────────────────────────────────────────────────────────────
export 'package:grocery_app/core/utils/validators.dart';
export 'package:grocery_app/core/utils/helpers.dart';
export 'package:grocery_app/core/utils/extensions.dart';

// ─── Routes ───────────────────────────────────────────────────────────────────
export 'package:grocery_app/routes/app_routes.dart';

// ─── Theme ────────────────────────────────────────────────────────────────────
export 'package:grocery_app/theme/app_theme.dart';
export 'package:grocery_app/theme/app_decoration.dart';

// ─── Models ───────────────────────────────────────────────────────────────────
export 'package:grocery_app/data/models/user_model.dart';
export 'package:grocery_app/data/models/product_model.dart';
export 'package:grocery_app/data/models/category_model.dart';
export 'package:grocery_app/data/models/cart_item_model.dart';
export 'package:grocery_app/data/models/order_model.dart';
export 'package:grocery_app/data/models/address_model.dart';
export 'package:grocery_app/data/models/banner_model.dart';
export 'package:grocery_app/data/models/review_model.dart';
export 'package:grocery_app/data/models/promo_code_model.dart';

// ─── Repositories ─────────────────────────────────────────────────────────────
export 'package:grocery_app/data/repositories/auth_repository.dart';
export 'package:grocery_app/data/repositories/product_repository.dart';
export 'package:grocery_app/data/repositories/order_repository.dart';

// ─── Controllers ──────────────────────────────────────────────────────────────
export 'package:grocery_app/presentation/controllers/cart_controller.dart';
export 'package:grocery_app/presentation/controllers/wishlist_controller.dart';
