const String mockBannersJson = '''
[
  {
    "id": "b1",
    "title": "Breakfast essentials",
    "subtitle": "Fresh breads, eggs, milk and more in 10 minutes.",
    "imageUrl": "https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=1200&q=80",
    "cta": "Shop now"
  },
  {
    "id": "b2",
    "title": "Weekend fruit festival",
    "subtitle": "Up to 25% off on handpicked seasonal produce.",
    "imageUrl": "https://images.unsplash.com/photo-1488459716781-31db52582fe9?auto=format&fit=crop&w=1200&q=80",
    "cta": "Explore deals"
  },
  {
    "id": "b3",
    "title": "Organic pantry refill",
    "subtitle": "Curated staples from trusted local farms.",
    "imageUrl": "https://images.unsplash.com/photo-1573246123716-6b1782bfc499?auto=format&fit=crop&w=1200&q=80",
    "cta": "Browse pantry"
  }
]
''';

const String mockCategoriesJson = '''
[
  {"id": "c1", "name": "Vegetables", "icon": "eco", "colorHex": "#E6F4EA"},
  {"id": "c2", "name": "Fruits", "icon": "apple", "colorHex": "#FFF2E2"},
  {"id": "c3", "name": "Dairy", "icon": "water_drop", "colorHex": "#E8F1FF"},
  {"id": "c4", "name": "Bakery", "icon": "bakery_dining", "colorHex": "#FBE9E7"},
  {"id": "c5", "name": "Snacks", "icon": "cookie", "colorHex": "#FFF5CC"},
  {"id": "c6", "name": "Beverages", "icon": "local_cafe", "colorHex": "#F1E8FF"}
]
''';

const String mockProductsJson = '''
[
  {
    "id": "p1",
    "name": "Avocado",
    "categoryId": "c2",
    "imageUrl": "https://images.unsplash.com/photo-1523049673857-eb18f1d7b578?auto=format&fit=crop&w=900&q=80",
    "gallery": [
      "https://images.unsplash.com/photo-1523049673857-eb18f1d7b578?auto=format&fit=crop&w=900&q=80",
      "https://images.unsplash.com/photo-1601039641847-7857b994d704?auto=format&fit=crop&w=900&q=80"
    ],
    "price": 2.49,
    "originalPrice": 3.19,
    "unit": "each",
    "description": "Creamy Hass avocados picked for perfect ripeness.",
    "variants": ["1 each", "Pack of 2", "Pack of 4"],
    "rating": 4.8,
    "reviewCount": 214,
    "isPopular": true,
    "isRecommended": true,
    "discountTag": "Save 20%",
    "reviews": [
      {"id": "r1", "author": "Nina", "rating": 5, "comment": "Perfectly ripe and creamy.", "date": "Apr 22"},
      {"id": "r2", "author": "David", "rating": 4.5, "comment": "Fresh quality and quick delivery.", "date": "Apr 18"}
    ]
  },
  {
    "id": "p2",
    "name": "Baby Spinach",
    "categoryId": "c1",
    "imageUrl": "https://images.unsplash.com/photo-1576045057995-568f588f82fb?auto=format&fit=crop&w=900&q=80",
    "gallery": [
      "https://images.unsplash.com/photo-1576045057995-568f588f82fb?auto=format&fit=crop&w=900&q=80",
      "https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&w=900&q=80"
    ],
    "price": 3.99,
    "originalPrice": 4.79,
    "unit": "200 g",
    "description": "Tender spinach leaves ideal for salads and smoothies.",
    "variants": ["200 g", "400 g"],
    "rating": 4.6,
    "reviewCount": 126,
    "isPopular": true,
    "isRecommended": false,
    "discountTag": "Fresh pick",
    "reviews": [
      {"id": "r3", "author": "Priya", "rating": 4.5, "comment": "Really fresh and clean.", "date": "Apr 20"}
    ]
  },
  {
    "id": "p3",
    "name": "Greek Yogurt",
    "categoryId": "c3",
    "imageUrl": "https://images.unsplash.com/photo-1488477181946-6428a0291777?auto=format&fit=crop&w=900&q=80",
    "gallery": [
      "https://images.unsplash.com/photo-1488477181946-6428a0291777?auto=format&fit=crop&w=900&q=80",
      "https://images.unsplash.com/photo-1559561853-08451507cbe7?auto=format&fit=crop&w=900&q=80"
    ],
    "price": 5.49,
    "originalPrice": 5.49,
    "unit": "500 g",
    "description": "Protein-rich yogurt with a silky texture.",
    "variants": ["500 g", "1 kg"],
    "rating": 4.9,
    "reviewCount": 301,
    "isPopular": false,
    "isRecommended": true,
    "discountTag": "High protein",
    "reviews": [
      {"id": "r4", "author": "Mark", "rating": 5, "comment": "Best yogurt for breakfast bowls.", "date": "Apr 12"}
    ]
  },
  {
    "id": "p4",
    "name": "Sourdough Loaf",
    "categoryId": "c4",
    "imageUrl": "https://images.unsplash.com/photo-1509440159596-0249088772ff?auto=format&fit=crop&w=900&q=80",
    "gallery": [
      "https://images.unsplash.com/photo-1509440159596-0249088772ff?auto=format&fit=crop&w=900&q=80",
      "https://images.unsplash.com/photo-1549931319-a545dcf3bc73?auto=format&fit=crop&w=900&q=80"
    ],
    "price": 4.25,
    "originalPrice": 4.89,
    "unit": "1 loaf",
    "description": "Stone-baked sourdough with a crisp crust and airy crumb.",
    "variants": ["1 loaf", "2 loaves"],
    "rating": 4.7,
    "reviewCount": 156,
    "isPopular": true,
    "isRecommended": true,
    "discountTag": "Baker's deal",
    "reviews": [
      {"id": "r5", "author": "Alina", "rating": 4.8, "comment": "Fantastic texture and flavor.", "date": "Apr 25"}
    ]
  },
  {
    "id": "p5",
    "name": "Mixed Nuts",
    "categoryId": "c5",
    "imageUrl": "https://images.unsplash.com/photo-1599599810769-bcde5a160d32?auto=format&fit=crop&w=900&q=80",
    "gallery": [
      "https://images.unsplash.com/photo-1599599810769-bcde5a160d32?auto=format&fit=crop&w=900&q=80",
      "https://images.unsplash.com/photo-1515543237350-b3eea1ec8082?auto=format&fit=crop&w=900&q=80"
    ],
    "price": 7.99,
    "originalPrice": 9.29,
    "unit": "250 g",
    "description": "Roasted almonds, cashews, and pistachios with sea salt.",
    "variants": ["250 g", "500 g"],
    "rating": 4.5,
    "reviewCount": 89,
    "isPopular": false,
    "isRecommended": true,
    "discountTag": "Snack smart",
    "reviews": [
      {"id": "r6", "author": "Ian", "rating": 4.5, "comment": "Great mix and not too salty.", "date": "Apr 14"}
    ]
  },
  {
    "id": "p6",
    "name": "Cold Brew Coffee",
    "categoryId": "c6",
    "imageUrl": "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?auto=format&fit=crop&w=900&q=80",
    "gallery": [
      "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?auto=format&fit=crop&w=900&q=80",
      "https://images.unsplash.com/photo-1447933601403-0c6688de566e?auto=format&fit=crop&w=900&q=80"
    ],
    "price": 3.75,
    "originalPrice": 4.50,
    "unit": "330 ml",
    "description": "Smooth single-origin cold brew with chocolate notes.",
    "variants": ["330 ml", "6-pack"],
    "rating": 4.4,
    "reviewCount": 74,
    "isPopular": true,
    "isRecommended": false,
    "discountTag": "Cafe favorite",
    "reviews": [
      {"id": "r7", "author": "Sara", "rating": 4.2, "comment": "Balanced flavor and convenient can size.", "date": "Apr 21"}
    ]
  }
]
''';

const String mockAddressesJson = '''
[
  {
    "id": "a1",
    "label": "Home",
    "addressLine": "42 Maple Residency, Downtown",
    "city": "Boston, MA",
    "instructions": "Leave at front desk if unavailable.",
    "isDefault": true
  },
  {
    "id": "a2",
    "label": "Office",
    "addressLine": "9 Beacon Street, Floor 5",
    "city": "Boston, MA",
    "instructions": "Call on arrival.",
    "isDefault": false
  }
]
''';

const String mockPaymentsJson = '''
[
  {
    "id": "pm1",
    "title": "Visa ending 4242",
    "subtitle": "Expires 08/28",
    "type": "card",
    "isDefault": true
  },
  {
    "id": "pm2",
    "title": "Apple Pay",
    "subtitle": "Fast checkout",
    "type": "wallet",
    "isDefault": false
  },
  {
    "id": "pm3",
    "title": "Cash on Delivery",
    "subtitle": "Pay when you receive",
    "type": "cash",
    "isDefault": false
  }
]
''';

const String mockOrdersJson = '''
[
  {
    "id": "o1001",
    "items": [
      {
        "productId": "p1",
        "name": "Avocado",
        "imageUrl": "https://images.unsplash.com/photo-1523049673857-eb18f1d7b578?auto=format&fit=crop&w=900&q=80",
        "variant": "Pack of 2",
        "unitPrice": 4.49,
        "quantity": 1
      },
      {
        "productId": "p4",
        "name": "Sourdough Loaf",
        "imageUrl": "https://images.unsplash.com/photo-1509440159596-0249088772ff?auto=format&fit=crop&w=900&q=80",
        "variant": "1 loaf",
        "unitPrice": 4.25,
        "quantity": 2
      }
    ],
    "status": "On the way",
    "total": 12.99,
    "eta": "12 mins",
    "deliveryAddress": "42 Maple Residency, Downtown",
    "createdAt": "Today, 09:45 AM"
  },
  {
    "id": "o1000",
    "items": [
      {
        "productId": "p3",
        "name": "Greek Yogurt",
        "imageUrl": "https://images.unsplash.com/photo-1488477181946-6428a0291777?auto=format&fit=crop&w=900&q=80",
        "variant": "500 g",
        "unitPrice": 5.49,
        "quantity": 2
      }
    ],
    "status": "Delivered",
    "total": 10.98,
    "eta": "Delivered",
    "deliveryAddress": "9 Beacon Street, Floor 5",
    "createdAt": "May 01, 06:20 PM"
  }
]
''';

const String mockProfileJson = '''
{
  "name": "Alex Johnson",
  "email": "alex.johnson@example.com",
  "phone": "+1 555 014 7788",
  "avatarUrl": "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80"
}
''';
