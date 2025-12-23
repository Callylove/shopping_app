import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/cart_provider.dart';


class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    print( Provider.of<CartProvider>(context).cart);
    final cart = Provider.of<CartProvider>(context).cart;

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Cart',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final cartItem = cart[index];

                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                    AssetImage(cartItem['imageUrl'].toString()),
                    radius: 30,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      Provider.of<CartProvider>(context, listen: false).removeProduct(cartItem);
                    },
                    icon: const Icon(Icons.delete, color: Colors.red),
                  ),
                  title: Text(
                    cartItem['title'].toString(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  subtitle: Text('Size: ${cartItem['sizes']}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

