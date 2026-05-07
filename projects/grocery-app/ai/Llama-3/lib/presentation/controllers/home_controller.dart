  import 'package:flutter/material.dart';
  import 'package:get_x/get_x.dart';
  import 'package:grocery_app/data/models/product.dart';

  class HomeController extends Controller {
    final ProductRepository _productRepository = ProductRepository();

    @override
    void onInit() async {
      super.onInit();
      final products = await _productRepository.fetchProducts();
      setState(() {
        _products = products;
      });
    }

    List<Product> get _products => _controller.products;

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Home Screen'),
        ),
        body: ListView.builder(
          itemCount: _products.length,
          itemBuilder: (context, index) {
            final product = _products[index];
            return ListTile(title: Text(product.name));
          },
        ),
      );
    }
  }