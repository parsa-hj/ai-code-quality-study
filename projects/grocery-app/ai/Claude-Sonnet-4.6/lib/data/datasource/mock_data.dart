import 'package:flutter/material.dart';
import 'package:grocery_app/data/models/address_model.dart';
import 'package:grocery_app/data/models/banner_model.dart';
import 'package:grocery_app/data/models/category_model.dart';
import 'package:grocery_app/data/models/order_model.dart';
import 'package:grocery_app/data/models/product_model.dart';
import 'package:grocery_app/data/models/promo_code_model.dart';
import 'package:grocery_app/data/models/review_model.dart';
import 'package:grocery_app/data/models/user_model.dart';

/// Static mock data used throughout the app.
/// In production this would be replaced with real API calls.
class MockData {
  MockData._();

  // ─── Demo User ────────────────────────────────────────────────────────────

  static final UserModel demoUser = UserModel(
    id: 'user_001',
    name: 'Alex Johnson',
    email: 'demo@grocerygo.com',
    phone: '+1 555-234-5678',
    avatarUrl: 'https://picsum.photos/seed/user001/200/200',
    createdAt: DateTime(2024, 3, 15),
  );

  // ─── Banners ──────────────────────────────────────────────────────────────

  static final List<BannerModel> banners = [
    BannerModel(
      id: 'b1',
      imageUrl:
          'https://images.unsplash.com/photo-1543168256-418811576931?w=800&q=80',
      title: 'Fresh Organic Produce',
      subtitle: 'Up to 30% off this week',
      actionLabel: 'Shop Now',
      actionRoute: '/category-products',
      actionArgument: 'cat_fruits',
    ),
    BannerModel(
      id: 'b2',
      imageUrl:
          'https://images.unsplash.com/photo-1606787366850-de6330128bfc?w=800&q=80',
      title: 'Free Express Delivery',
      subtitle: 'On orders over \$50',
      actionLabel: 'Order Now',
      actionRoute: '/main',
    ),
    BannerModel(
      id: 'b3',
      imageUrl:
          'https://images.unsplash.com/photo-1534483509719-3feaee7c30da?w=800&q=80',
      title: 'New Arrivals',
      subtitle: 'Explore our organic collection',
      actionLabel: 'Explore',
      actionRoute: '/search',
    ),
  ];

  // ─── Categories ───────────────────────────────────────────────────────────

  static final List<CategoryModel> categories = [
    CategoryModel(
      id: 'cat_fruits',
      name: 'Fruits',
      imageUrl:
          'https://images.unsplash.com/photo-1619566636858-adf3ef46400b?w=200&q=80',
      color: const Color(0xFFFFE4B5),
      productCount: 24,
    ),
    CategoryModel(
      id: 'cat_vegetables',
      name: 'Vegetables',
      imageUrl:
          'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=200&q=80',
      color: const Color(0xFFD5F5E3),
      productCount: 32,
    ),
    CategoryModel(
      id: 'cat_dairy',
      name: 'Dairy',
      imageUrl:
          'https://images.unsplash.com/photo-1563636619-e9143da7973b?w=200&q=80',
      color: const Color(0xFFE3F2FD),
      productCount: 18,
    ),
    CategoryModel(
      id: 'cat_meat',
      name: 'Meat',
      imageUrl:
          'https://images.unsplash.com/photo-1602470520998-f4a52199a3d6?w=200&q=80',
      color: const Color(0xFFFFEBEE),
      productCount: 15,
    ),
    CategoryModel(
      id: 'cat_bakery',
      name: 'Bakery',
      imageUrl:
          'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=200&q=80',
      color: const Color(0xFFFFF3E0),
      productCount: 20,
    ),
    CategoryModel(
      id: 'cat_beverages',
      name: 'Beverages',
      imageUrl:
          'https://images.unsplash.com/photo-1544145945-f90425340c7e?w=200&q=80',
      color: const Color(0xFFF3E5F5),
      productCount: 28,
    ),
    CategoryModel(
      id: 'cat_snacks',
      name: 'Snacks',
      imageUrl:
          'https://images.unsplash.com/photo-1621939514649-280e2ee25f60?w=200&q=80',
      color: const Color(0xFFFFF8E1),
      productCount: 40,
    ),
    CategoryModel(
      id: 'cat_pantry',
      name: 'Pantry',
      imageUrl:
          'https://images.unsplash.com/photo-1584568694244-14fbdf83bd30?w=200&q=80',
      color: const Color(0xFFE8F5E9),
      productCount: 55,
    ),
  ];

  // ─── Products ─────────────────────────────────────────────────────────────

  static final List<ProductModel> products = [
    // --- Fruits ---
    ProductModel(
      id: 'p001',
      name: 'Red Apples',
      description:
          'Fresh, crispy red apples sourced from local orchards. Perfect for snacking or baking. Rich in fiber, vitamins, and antioxidants.',
      price: 2.99,
      categoryId: 'cat_fruits',
      categoryName: 'Fruits',
      images: [
        'https://images.unsplash.com/photo-1567306226416-28f0efdc88ce?w=400&q=80',
        'https://images.unsplash.com/photo-1568702846914-96b305d2aaeb?w=400&q=80',
      ],
      rating: 4.6,
      reviewCount: 128,
      unit: 'kg',
      isPopular: true,
      isRecommended: true,
      isOrganic: true,
      variants: [
        ProductVariant(id: 'v1', label: '500g', extraCost: -1.50),
        ProductVariant(id: 'v2', label: '1 kg'),
        ProductVariant(id: 'v3', label: '2 kg', extraCost: 2.99),
      ],
      tags: ['fresh', 'organic', 'fruit'],
    ),
    ProductModel(
      id: 'p002',
      name: 'Banana Bunch',
      description:
          'A bunch of ripe, sweet bananas. Great source of potassium and natural energy. Ideal for smoothies, baking, or eating on the go.',
      price: 1.49,
      categoryId: 'cat_fruits',
      categoryName: 'Fruits',
      images: [
        'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=400&q=80',
        'https://images.unsplash.com/photo-1528825871115-3581a5387919?w=400&q=80',
      ],
      rating: 4.8,
      reviewCount: 256,
      unit: 'bunch',
      isPopular: true,
      isFlashDeal: true,
      discountPercent: 15,
      originalPrice: 1.75,
      tags: ['fresh', 'tropical', 'fruit'],
    ),
    ProductModel(
      id: 'p003',
      name: 'Navel Oranges',
      description:
          'Sweet and juicy navel oranges, packed with Vitamin C. Perfect for fresh juice or snacking. Seedless and easy to peel.',
      price: 3.99,
      categoryId: 'cat_fruits',
      categoryName: 'Fruits',
      images: [
        'https://images.unsplash.com/photo-1547514701-42782101795e?w=400&q=80',
      ],
      rating: 4.5,
      reviewCount: 94,
      unit: 'kg',
      isRecommended: true,
      variants: [
        ProductVariant(id: 'v1', label: '4-pack', extraCost: -1.0),
        ProductVariant(id: 'v2', label: '1 kg'),
        ProductVariant(id: 'v3', label: '2 kg', extraCost: 3.50),
      ],
      tags: ['fresh', 'citrus', 'vitamin c'],
    ),
    ProductModel(
      id: 'p004',
      name: 'Seedless Grapes',
      description:
          'Plump, sweet seedless green grapes. Perfect for snacking, salads, or cheeseboards. Hand-picked and carefully sorted for quality.',
      price: 4.99,
      categoryId: 'cat_fruits',
      categoryName: 'Fruits',
      images: [
        'https://images.unsplash.com/photo-1537640538966-79f369143f8f?w=400&q=80',
      ],
      rating: 4.7,
      reviewCount: 87,
      unit: 'bag',
      isFlashDeal: true,
      discountPercent: 20,
      originalPrice: 6.25,
      tags: ['fresh', 'snack', 'fruit'],
    ),
    ProductModel(
      id: 'p005',
      name: 'Fresh Strawberries',
      description:
          'Sweet, ripe strawberries bursting with flavor. Freshly picked and perfect for desserts, smoothies, or eating straight from the punnet.',
      price: 3.49,
      categoryId: 'cat_fruits',
      categoryName: 'Fruits',
      images: [
        'https://images.unsplash.com/photo-1464965911861-746a04b4bca6?w=400&q=80',
      ],
      rating: 4.9,
      reviewCount: 312,
      unit: 'punnet',
      isPopular: true,
      isOrganic: true,
      tags: ['fresh', 'berry', 'dessert'],
    ),
    // --- Vegetables ---
    ProductModel(
      id: 'p006',
      name: 'Baby Carrots',
      description:
          'Pre-washed, ready-to-eat baby carrots. Crunchy and sweet, perfect for snacking, dipping, or adding to stews and stir-fries.',
      price: 2.49,
      categoryId: 'cat_vegetables',
      categoryName: 'Vegetables',
      images: [
        'https://images.unsplash.com/photo-1445282768818-728615cc910a?w=400&q=80',
      ],
      rating: 4.4,
      reviewCount: 76,
      unit: 'bag',
      isPopular: true,
      isOrganic: true,
      tags: ['organic', 'healthy', 'snack'],
    ),
    ProductModel(
      id: 'p007',
      name: 'Fresh Spinach',
      description:
          'Tender, nutrient-rich baby spinach leaves. Washed and ready to use in salads, smoothies, or cooked dishes. Rich in iron and vitamins.',
      price: 3.29,
      categoryId: 'cat_vegetables',
      categoryName: 'Vegetables',
      images: [
        'https://images.unsplash.com/photo-1576045057995-568f588f82fb?w=400&q=80',
      ],
      rating: 4.6,
      reviewCount: 54,
      unit: 'bag',
      isRecommended: true,
      isOrganic: true,
      tags: ['leafy', 'organic', 'iron-rich'],
    ),
    ProductModel(
      id: 'p008',
      name: 'Cherry Tomatoes',
      description:
          'Sweet, vibrant cherry tomatoes on the vine. Perfect for salads, pasta, or snacking. Grown without pesticides for maximum flavor.',
      price: 3.99,
      categoryId: 'cat_vegetables',
      categoryName: 'Vegetables',
      images: [
        'https://images.unsplash.com/photo-1546470427-227c8b0e0f4b?w=400&q=80',
      ],
      rating: 4.8,
      reviewCount: 143,
      unit: 'pint',
      isPopular: true,
      isFlashDeal: true,
      discountPercent: 10,
      originalPrice: 4.44,
      tags: ['fresh', 'salad', 'organic'],
    ),
    ProductModel(
      id: 'p009',
      name: 'Broccoli Crown',
      description:
          'Fresh broccoli crown with dense, dark green florets. Excellent source of Vitamin C, fiber, and folate. Versatile for steaming, roasting, or stir-frying.',
      price: 2.79,
      categoryId: 'cat_vegetables',
      categoryName: 'Vegetables',
      images: [
        'https://images.unsplash.com/photo-1459411621453-7b03977f4bfc?w=400&q=80',
      ],
      rating: 4.5,
      reviewCount: 68,
      unit: 'each',
      isRecommended: true,
      tags: ['healthy', 'green', 'superfood'],
    ),
    ProductModel(
      id: 'p010',
      name: 'Russet Potatoes',
      description:
          'Hearty russet potatoes, ideal for baking, mashing, or frying. High starch content makes them fluffy on the inside and crispy on the outside.',
      price: 4.99,
      categoryId: 'cat_vegetables',
      categoryName: 'Vegetables',
      images: [
        'https://images.unsplash.com/photo-1518977676601-b53f82aba655?w=400&q=80',
      ],
      rating: 4.3,
      reviewCount: 112,
      unit: '5 lb bag',
      isPopular: true,
      tags: ['starchy', 'versatile', 'comfort food'],
    ),
    // --- Dairy ---
    ProductModel(
      id: 'p011',
      name: 'Whole Milk',
      description:
          'Fresh whole milk from grass-fed cows. Rich and creamy with a full-bodied flavor. Excellent source of calcium, protein, and essential vitamins.',
      price: 3.49,
      categoryId: 'cat_dairy',
      categoryName: 'Dairy',
      images: [
        'https://images.unsplash.com/photo-1563636619-e9143da7973b?w=400&q=80',
      ],
      rating: 4.7,
      reviewCount: 203,
      unit: 'gallon',
      isPopular: true,
      variants: [
        ProductVariant(id: 'v1', label: 'Half gallon', extraCost: -1.75),
        ProductVariant(id: 'v2', label: '1 gallon'),
      ],
      tags: ['dairy', 'calcium', 'protein'],
    ),
    ProductModel(
      id: 'p012',
      name: 'Sharp Cheddar',
      description:
          'Aged sharp cheddar cheese with a bold, tangy flavor. Perfect for sandwiches, burgers, mac & cheese, or a cheese board. Made from real aged cheese.',
      price: 5.99,
      categoryId: 'cat_dairy',
      categoryName: 'Dairy',
      images: [
        'https://images.unsplash.com/photo-1588710929865-a7e643a4f0ab?w=400&q=80',
      ],
      rating: 4.8,
      reviewCount: 167,
      unit: 'block',
      isRecommended: true,
      variants: [
        ProductVariant(id: 'v1', label: 'Mild'),
        ProductVariant(id: 'v2', label: 'Sharp'),
        ProductVariant(id: 'v3', label: 'Extra Sharp', extraCost: 0.50),
      ],
      tags: ['cheese', 'aged', 'dairy'],
    ),
    ProductModel(
      id: 'p013',
      name: 'Greek Yogurt',
      description:
          'Thick, creamy Greek yogurt with twice the protein of regular yogurt. Made with live active cultures. Great plain or with granola and fruit.',
      price: 5.49,
      categoryId: 'cat_dairy',
      categoryName: 'Dairy',
      images: [
        'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=400&q=80',
      ],
      rating: 4.9,
      reviewCount: 289,
      unit: '32 oz',
      isPopular: true,
      isFlashDeal: true,
      discountPercent: 15,
      originalPrice: 6.46,
      variants: [
        ProductVariant(id: 'v1', label: 'Plain'),
        ProductVariant(id: 'v2', label: 'Vanilla'),
        ProductVariant(id: 'v3', label: 'Honey'),
      ],
      tags: ['protein', 'probiotic', 'healthy'],
    ),
    // --- Bakery ---
    ProductModel(
      id: 'p014',
      name: 'Sourdough Bread',
      description:
          'Artisan sourdough bread with a crispy crust and chewy interior. Made with a 24-hour fermented starter for superior flavor and digestibility.',
      price: 4.99,
      categoryId: 'cat_bakery',
      categoryName: 'Bakery',
      images: [
        'https://images.unsplash.com/photo-1549931319-a545dcf3bc73?w=400&q=80',
      ],
      rating: 4.9,
      reviewCount: 341,
      unit: 'loaf',
      isPopular: true,
      isRecommended: true,
      tags: ['artisan', 'fermented', 'fresh-baked'],
    ),
    ProductModel(
      id: 'p015',
      name: 'Blueberry Muffins',
      description:
          'Freshly baked blueberry muffins bursting with juicy blueberries. Soft, moist texture with a golden brown top. Baked daily in our in-store bakery.',
      price: 5.99,
      categoryId: 'cat_bakery',
      categoryName: 'Bakery',
      images: [
        'https://images.unsplash.com/photo-1607958996333-41aef7caefaa?w=400&q=80',
      ],
      rating: 4.7,
      reviewCount: 156,
      unit: '6-pack',
      isFlashDeal: true,
      discountPercent: 20,
      originalPrice: 7.49,
      tags: ['baked', 'sweet', 'breakfast'],
    ),
    // --- Meat ---
    ProductModel(
      id: 'p016',
      name: 'Chicken Breast',
      description:
          'Boneless, skinless chicken breasts. Lean, high-protein and versatile. Ideal for grilling, baking, stir-frying, or meal prep. Antibiotic-free.',
      price: 7.99,
      categoryId: 'cat_meat',
      categoryName: 'Meat',
      images: [
        'https://images.unsplash.com/photo-1604503468506-a8da13d11d36?w=400&q=80',
      ],
      rating: 4.5,
      reviewCount: 198,
      unit: 'lb',
      isPopular: true,
      variants: [
        ProductVariant(id: 'v1', label: '1 lb'),
        ProductVariant(id: 'v2', label: '2 lb', extraCost: 7.99),
        ProductVariant(id: 'v3', label: '3 lb', extraCost: 15.98),
      ],
      tags: ['lean', 'protein', 'antibiotic-free'],
    ),
    ProductModel(
      id: 'p017',
      name: 'Atlantic Salmon',
      description:
          'Fresh Atlantic salmon fillets, rich in Omega-3 fatty acids. Wild-caught and sustainably sourced. Perfect for grilling, baking, or pan-searing.',
      price: 12.99,
      categoryId: 'cat_meat',
      categoryName: 'Meat',
      images: [
        'https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=400&q=80',
      ],
      rating: 4.8,
      reviewCount: 124,
      unit: 'lb',
      isRecommended: true,
      isFlashDeal: true,
      discountPercent: 10,
      originalPrice: 14.44,
      tags: ['seafood', 'omega-3', 'wild-caught'],
    ),
    // --- Beverages ---
    ProductModel(
      id: 'p018',
      name: 'Orange Juice',
      description:
          'Fresh-squeezed orange juice with no added sugar or preservatives. 100% pure juice for a natural vitamin C boost every morning.',
      price: 4.99,
      categoryId: 'cat_beverages',
      categoryName: 'Beverages',
      images: [
        'https://images.unsplash.com/photo-1621506289937-a8e4df240d0b?w=400&q=80',
      ],
      rating: 4.6,
      reviewCount: 219,
      unit: '64 oz',
      isPopular: true,
      tags: ['juice', 'vitamin c', 'no-sugar-added'],
    ),
    ProductModel(
      id: 'p019',
      name: 'Sparkling Water',
      description:
          'Naturally carbonated sparkling mineral water from a pristine mountain spring. Zero calories, zero sweeteners. Available in multiple refreshing flavors.',
      price: 7.99,
      categoryId: 'cat_beverages',
      categoryName: 'Beverages',
      images: [
        'https://images.unsplash.com/photo-1606168094336-48f8b6b2d27a?w=400&q=80',
      ],
      rating: 4.4,
      reviewCount: 87,
      unit: '12-pack',
      isRecommended: true,
      variants: [
        ProductVariant(id: 'v1', label: 'Plain'),
        ProductVariant(id: 'v2', label: 'Lemon'),
        ProductVariant(id: 'v3', label: 'Berry'),
        ProductVariant(id: 'v4', label: 'Lime'),
      ],
      tags: ['hydration', 'zero-calorie', 'sparkling'],
    ),
    // --- Snacks ---
    ProductModel(
      id: 'p020',
      name: 'Mixed Trail Mix',
      description:
          'A satisfying blend of roasted almonds, cashews, dried cranberries, dark chocolate chips, and pumpkin seeds. The perfect on-the-go snack.',
      price: 6.49,
      categoryId: 'cat_snacks',
      categoryName: 'Snacks',
      images: [
        'https://images.unsplash.com/photo-1608686206067-9f63c2e79d07?w=400&q=80',
      ],
      rating: 4.7,
      reviewCount: 168,
      unit: 'bag',
      isPopular: true,
      isOrganic: true,
      tags: ['nuts', 'energy', 'portable'],
    ),
    ProductModel(
      id: 'p021',
      name: 'Sea Salt Potato Chips',
      description:
          'Kettle-cooked potato chips seasoned with just the right amount of sea salt. Thick-cut for an extra satisfying crunch with every bite.',
      price: 3.99,
      categoryId: 'cat_snacks',
      categoryName: 'Snacks',
      images: [
        'https://images.unsplash.com/photo-1585670931069-e8acdb54bd2e?w=400&q=80',
      ],
      rating: 4.3,
      reviewCount: 204,
      unit: 'bag',
      isFlashDeal: true,
      discountPercent: 25,
      originalPrice: 5.32,
      tags: ['salty', 'crunchy', 'party'],
    ),
    // --- Pantry ---
    ProductModel(
      id: 'p022',
      name: 'Jasmine Rice',
      description:
          'Fragrant, long-grain jasmine rice from Thailand. Fluffy texture with a delicate floral aroma. Perfect for Asian dishes, curries, or everyday meals.',
      price: 5.99,
      categoryId: 'cat_pantry',
      categoryName: 'Pantry',
      images: [
        'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=400&q=80',
      ],
      rating: 4.8,
      reviewCount: 376,
      unit: '5 lb bag',
      isPopular: true,
      variants: [
        ProductVariant(id: 'v1', label: '2 lb', extraCost: -2.40),
        ProductVariant(id: 'v2', label: '5 lb'),
        ProductVariant(id: 'v3', label: '10 lb', extraCost: 5.99),
      ],
      tags: ['grain', 'staple', 'gluten-free'],
    ),
    ProductModel(
      id: 'p023',
      name: 'Extra Virgin Olive Oil',
      description:
          'Cold-pressed extra virgin olive oil from Italian olives. Rich, fruity flavor with a peppery finish. Ideal for dressings, sautéing, and finishing dishes.',
      price: 9.99,
      categoryId: 'cat_pantry',
      categoryName: 'Pantry',
      images: [
        'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=400&q=80',
      ],
      rating: 4.9,
      reviewCount: 441,
      unit: '500 ml',
      isRecommended: true,
      isOrganic: true,
      variants: [
        ProductVariant(id: 'v1', label: '250 ml', extraCost: -5.0),
        ProductVariant(id: 'v2', label: '500 ml'),
        ProductVariant(id: 'v3', label: '1 L', extraCost: 9.99),
      ],
      tags: ['healthy fat', 'Italian', 'cold-pressed'],
    ),
    ProductModel(
      id: 'p024',
      name: 'Penne Pasta',
      description:
          'Classic Italian penne pasta made from durum wheat semolina. Perfect for holding chunky sauces. Al dente in just 11 minutes. A pantry essential.',
      price: 1.99,
      categoryId: 'cat_pantry',
      categoryName: 'Pantry',
      images: [
        'https://images.unsplash.com/photo-1551892374-ecf8754cf8b0?w=400&q=80',
      ],
      rating: 4.5,
      reviewCount: 287,
      unit: '1 lb box',
      isPopular: true,
      variants: [
        ProductVariant(id: 'v1', label: 'Penne'),
        ProductVariant(id: 'v2', label: 'Spaghetti'),
        ProductVariant(id: 'v3', label: 'Fusilli'),
        ProductVariant(id: 'v4', label: 'Rigatoni'),
      ],
      tags: ['pasta', 'Italian', 'quick-cook'],
    ),
    ProductModel(
      id: 'p025',
      name: 'Avocado',
      description:
          'Perfectly ripe Hass avocados with buttery, creamy flesh. Rich in healthy monounsaturated fats. Great for guacamole, toast, or sliced on salads.',
      price: 1.49,
      categoryId: 'cat_fruits',
      categoryName: 'Fruits',
      images: [
        'https://images.unsplash.com/photo-1523049673857-eb18f1d7b578?w=400&q=80',
        'https://images.unsplash.com/photo-1588421357574-87938a86fa28?w=400&q=80',
      ],
      rating: 4.8,
      reviewCount: 512,
      unit: 'each',
      isPopular: true,
      isRecommended: true,
      variants: [
        ProductVariant(id: 'v1', label: '1 avocado'),
        ProductVariant(id: 'v2', label: '4-pack', extraCost: 4.47),
        ProductVariant(id: 'v3', label: '6-pack', extraCost: 7.46),
      ],
      tags: ['healthy fat', 'superfood', 'keto-friendly'],
    ),
  ];

  // ─── Reviews ──────────────────────────────────────────────────────────────

  static final List<ReviewModel> reviews = [
    ReviewModel(
      id: 'r001',
      userId: 'user_002',
      userName: 'Sarah M.',
      userAvatarUrl: 'https://picsum.photos/seed/sarah/50/50',
      productId: 'p001',
      rating: 5.0,
      comment:
          'These apples are incredible! Crispy, sweet, and arrived perfectly fresh. Will definitely order again.',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      helpfulCount: 12,
    ),
    ReviewModel(
      id: 'r002',
      userId: 'user_003',
      userName: 'James K.',
      userAvatarUrl: 'https://picsum.photos/seed/james/50/50',
      productId: 'p001',
      rating: 4.0,
      comment: 'Good quality apples. One of the five was a bit soft but the rest were great.',
      createdAt: DateTime.now().subtract(const Duration(days: 12)),
      helpfulCount: 4,
    ),
    ReviewModel(
      id: 'r003',
      userId: 'user_004',
      userName: 'Emma L.',
      userAvatarUrl: 'https://picsum.photos/seed/emma/50/50',
      productId: 'p025',
      rating: 5.0,
      comment: 'Perfect ripeness! The avocados were ready to eat the same day. Great for avocado toast.',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      helpfulCount: 8,
    ),
    ReviewModel(
      id: 'r004',
      userId: 'user_005',
      userName: 'Mike R.',
      userAvatarUrl: 'https://picsum.photos/seed/mike/50/50',
      productId: 'p013',
      rating: 5.0,
      comment: 'Best Greek yogurt I\'ve had. Super thick and creamy, with amazing protein content.',
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      helpfulCount: 15,
    ),
    ReviewModel(
      id: 'r005',
      userId: 'user_006',
      userName: 'Priya S.',
      userAvatarUrl: 'https://picsum.photos/seed/priya/50/50',
      productId: 'p023',
      rating: 5.0,
      comment:
          'This olive oil has a beautiful fruity aroma and mild peppery finish. Quality you can taste!',
      createdAt: DateTime.now().subtract(const Duration(days: 14)),
      helpfulCount: 22,
    ),
  ];

  // ─── Addresses ────────────────────────────────────────────────────────────

  static final List<AddressModel> addresses = [
    AddressModel(
      id: 'addr_001',
      label: 'Home',
      recipientName: 'Alex Johnson',
      phone: '+1 555-234-5678',
      addressLine1: '123 Maple Street',
      addressLine2: 'Apt 4B',
      city: 'San Francisco',
      state: 'CA',
      postalCode: '94105',
      isDefault: true,
    ),
    AddressModel(
      id: 'addr_002',
      label: 'Work',
      recipientName: 'Alex Johnson',
      phone: '+1 555-234-5678',
      addressLine1: '500 Market Street',
      addressLine2: 'Suite 1200',
      city: 'San Francisco',
      state: 'CA',
      postalCode: '94105',
    ),
  ];

  // ─── Orders ───────────────────────────────────────────────────────────────

  static final List<OrderModel> orders = [
    OrderModel(
      id: 'ORD-2025-0001',
      userId: 'user_001',
      items: [
        OrderItem(
          productId: 'p001',
          productName: 'Red Apples',
          productImage:
              'https://images.unsplash.com/photo-1567306226416-28f0efdc88ce?w=400&q=80',
          price: 2.99,
          quantity: 2,
          variantLabel: '1 kg',
        ),
        OrderItem(
          productId: 'p025',
          productName: 'Avocado',
          productImage:
              'https://images.unsplash.com/photo-1523049673857-eb18f1d7b578?w=400&q=80',
          price: 1.49,
          quantity: 4,
        ),
        OrderItem(
          productId: 'p013',
          productName: 'Greek Yogurt',
          productImage:
              'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=400&q=80',
          price: 4.67,
          quantity: 1,
          variantLabel: 'Plain',
        ),
      ],
      deliveryAddress: addresses[0],
      subtotal: 17.60,
      discountAmount: 1.76,
      deliveryFee: 0.0,
      total: 15.84,
      status: OrderStatus.delivered,
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      estimatedDelivery: DateTime.now().subtract(const Duration(days: 5)),
      promoCode: 'FRESH10',
      paymentMethod: 'Visa •••• 4242',
      deliveryOption: DeliveryOption.standard,
      trackingEvents: [
        OrderTrackingEvent(
          title: 'Order Placed',
          description: 'Your order has been received and confirmed.',
          timestamp: DateTime.now().subtract(const Duration(days: 7)),
        ),
        OrderTrackingEvent(
          title: 'Processing',
          description: 'We are preparing your items.',
          timestamp: DateTime.now().subtract(const Duration(days: 6, hours: 20)),
        ),
        OrderTrackingEvent(
          title: 'Shipped',
          description: 'Your order is on its way.',
          timestamp: DateTime.now().subtract(const Duration(days: 6)),
        ),
        OrderTrackingEvent(
          title: 'Delivered',
          description: 'Package delivered to your door.',
          timestamp: DateTime.now().subtract(const Duration(days: 5)),
        ),
      ],
    ),
    OrderModel(
      id: 'ORD-2025-0002',
      userId: 'user_001',
      items: [
        OrderItem(
          productId: 'p014',
          productName: 'Sourdough Bread',
          productImage:
              'https://images.unsplash.com/photo-1549931319-a545dcf3bc73?w=400&q=80',
          price: 4.99,
          quantity: 1,
        ),
        OrderItem(
          productId: 'p012',
          productName: 'Sharp Cheddar',
          productImage:
              'https://images.unsplash.com/photo-1588710929865-a7e643a4f0ab?w=400&q=80',
          price: 5.99,
          quantity: 1,
          variantLabel: 'Sharp',
        ),
        OrderItem(
          productId: 'p017',
          productName: 'Atlantic Salmon',
          productImage:
              'https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=400&q=80',
          price: 11.69,
          quantity: 2,
        ),
      ],
      deliveryAddress: addresses[1],
      subtotal: 34.36,
      deliveryFee: 4.99,
      total: 39.35,
      status: OrderStatus.outForDelivery,
      createdAt: DateTime.now().subtract(const Duration(hours: 18)),
      estimatedDelivery: DateTime.now().add(const Duration(hours: 2)),
      paymentMethod: 'Cash on Delivery',
      deliveryOption: DeliveryOption.express,
      trackingEvents: [
        OrderTrackingEvent(
          title: 'Order Placed',
          description: 'Your order has been received and confirmed.',
          timestamp: DateTime.now().subtract(const Duration(hours: 18)),
        ),
        OrderTrackingEvent(
          title: 'Processing',
          description: 'We are preparing your items.',
          timestamp: DateTime.now().subtract(const Duration(hours: 16)),
        ),
        OrderTrackingEvent(
          title: 'Out for Delivery',
          description: 'Your order is on its way. ETA: 2 hours.',
          timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        ),
        OrderTrackingEvent(
          title: 'Delivered',
          description: 'Package delivered to your door.',
          timestamp: DateTime.now(),
          isCompleted: false,
        ),
      ],
    ),
    OrderModel(
      id: 'ORD-2025-0003',
      userId: 'user_001',
      items: [
        OrderItem(
          productId: 'p002',
          productName: 'Banana Bunch',
          productImage:
              'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=400&q=80',
          price: 1.27,
          quantity: 3,
        ),
        OrderItem(
          productId: 'p022',
          productName: 'Jasmine Rice',
          productImage:
              'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=400&q=80',
          price: 5.99,
          quantity: 2,
          variantLabel: '5 lb',
        ),
        OrderItem(
          productId: 'p018',
          productName: 'Orange Juice',
          productImage:
              'https://images.unsplash.com/photo-1621506289937-a8e4df240d0b?w=400&q=80',
          price: 4.99,
          quantity: 2,
        ),
      ],
      deliveryAddress: addresses[0],
      subtotal: 21.77,
      discountAmount: 4.35,
      deliveryFee: 0.0,
      total: 17.42,
      status: OrderStatus.processing,
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      estimatedDelivery: DateTime.now().add(const Duration(days: 2)),
      promoCode: 'SAVE20',
      paymentMethod: 'Mastercard •••• 8765',
      deliveryOption: DeliveryOption.standard,
      trackingEvents: [
        OrderTrackingEvent(
          title: 'Order Placed',
          description: 'Your order has been received.',
          timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        ),
        OrderTrackingEvent(
          title: 'Processing',
          description: 'We are preparing your items.',
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        ),
        OrderTrackingEvent(
          title: 'Shipped',
          description: 'Your order is on its way.',
          timestamp: DateTime.now(),
          isCompleted: false,
        ),
        OrderTrackingEvent(
          title: 'Delivered',
          description: 'Package delivered to your door.',
          timestamp: DateTime.now().add(const Duration(days: 2)),
          isCompleted: false,
        ),
      ],
    ),
  ];

  // ─── Promo Codes ──────────────────────────────────────────────────────────

  static final List<PromoCodeModel> promoCodes = [
    PromoCodeModel(
      code: 'FRESH10',
      description: '10% off your order',
      discountPercent: 10,
      minimumOrderAmount: 20.0,
      expiresAt: DateTime.now().add(const Duration(days: 30)),
    ),
    PromoCodeModel(
      code: 'SAVE20',
      description: '20% off orders over \$30',
      discountPercent: 20,
      maxDiscountAmount: 15.0,
      minimumOrderAmount: 30.0,
      expiresAt: DateTime.now().add(const Duration(days: 15)),
    ),
    PromoCodeModel(
      code: 'NEWUSER',
      description: '15% off your first order',
      discountPercent: 15,
      maxDiscountAmount: 10.0,
      expiresAt: DateTime.now().add(const Duration(days: 60)),
    ),
  ];

  // ─── Helpers ──────────────────────────────────────────────────────────────

  static List<ProductModel> getProductsByCategory(String categoryId) =>
      products.where((p) => p.categoryId == categoryId).toList();

  static List<ProductModel> getPopularProducts() =>
      products.where((p) => p.isPopular).toList();

  static List<ProductModel> getRecommendedProducts() =>
      products.where((p) => p.isRecommended).toList();

  static List<ProductModel> getFlashDeals() =>
      products.where((p) => p.isFlashDeal).toList();

  static List<ProductModel> searchProducts(String query) {
    final q = query.toLowerCase();
    return products
        .where((p) =>
            p.name.toLowerCase().contains(q) ||
            p.categoryName.toLowerCase().contains(q) ||
            p.tags.any((t) => t.toLowerCase().contains(q)))
        .toList();
  }

  static List<ReviewModel> getReviewsForProduct(String productId) =>
      reviews.where((r) => r.productId == productId).toList();

  static PromoCodeModel? findPromoCode(String code) {
    try {
      return promoCodes.firstWhere(
        (p) => p.code.toUpperCase() == code.toUpperCase() && p.isValid,
      );
    } catch (_) {
      return null;
    }
  }
}
