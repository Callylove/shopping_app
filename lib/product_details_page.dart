import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/cart_provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String, Object> product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int selectedSize = 0;
  void onTab () {
    if (selectedSize != 0) {
      Provider.of<CartProvider>(context, listen: false).addProduct( {
        'id': widget.product['id'],
        'company': widget.product['company'],
        'title': widget.product['title'],
        'price': widget.product['price'],
        'sizes': selectedSize,
        'imageUrl': widget.product['imageUrl']
      });
      ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text('Product added successfullly!')));
    }else {
      ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text('Please select a size!')));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),

          Text(
            widget.product['title'] as String,
            style: Theme.of(context).textTheme.titleLarge,
          ),

          // 🔥 Flexible image space
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                widget.product['imageUrl'] as String,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // 🔥 Bottom section
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(245, 247, 249, 1),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '\$${widget.product['price']}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                      (widget.product['sizes'] as List<int>).length,
                      itemBuilder: (context, index) {
                        final size =
                        (widget.product['sizes'] as List<int>)[index];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ChoiceChip(
                            label: Text(size.toString()),
                            selected: size == selectedSize,
                            onSelected: (_) {
                              setState(() {
                                selectedSize = size;
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      onPressed: onTab,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        'Add To Cart',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
