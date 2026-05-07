  import 'package:flutter/material.dart';
  import 'package:get_x/get_x.dart';

  class ProductScreen extends StatelessWidget {
    final Product product;

    const ProductScreen({Key? key, required this.product}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(product.name),
        ),
        body: Column(
          children: [
            Image.asset('assets/product_image.png'),
            Text(product.name),
          ],
        ),
      );
    }
  }