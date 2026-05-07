  class Product {
    final int id;
    final String name;

    const Product(this.id, this.name);

    factory Product.fromJson(List<dynamic> json) {
      if (json.isEmpty) return null;
      return Product(json[0]['id'], json[0]['name']);
    }

    List<Product> toJson() => [Product(id, name)];
  }