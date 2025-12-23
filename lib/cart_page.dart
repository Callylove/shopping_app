import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/cart_provider.dart';


class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>().cart;

    return Scaffold(
      appBar: AppBar(
        title:  Text(
          'Cart',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [

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
                     showDialog(

                         context: context,
                         builder: (context)  {
                       return  AlertDialog(

                         title: Text('Delete Product', style: Theme.of(context).textTheme.titleMedium),
                         content: const Text('Are you sure you want to remove this product on your cart?'),
                         actions: [
                           TextButton(onPressed: () {
                             Navigator.of(context).pop();
                           }, child: Text('No', style: TextStyle(color: Colors.blue),)),
                           TextButton(onPressed: () {
                             context.read<CartProvider>().removeProduct(cartItem);
                             Navigator.of(context).pop();
                             ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text('Product removed successfullly!')));
                           }, child: Text('Yes', style: TextStyle(color: Colors.red),))
                         ],
                       );
                     });
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

