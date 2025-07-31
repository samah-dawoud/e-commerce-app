import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/shop_cubit.dart';
import 'package:shop_app/shared/cubit/shop_states.dart';
import '../../shared/component/components.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        var cartItems = cubit.homeModel?.data?.products
            .where((product) => cubit.cart[product.id] == true)
            .toList();

        double total = 0.0;
        if (cartItems != null) {
          total = cartItems.fold(0.0, (sum, item) => sum + (item.price ?? 0));
        }

        return Scaffold(
          body: state is ShopLoadingGetCartsState
              ? const Center(child: CircularProgressIndicator())
              : cartItems == null || cartItems.isEmpty
                  ? const Center(
                      child: Text(
                        'Your cart is empty',
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) =>
                          buildListProduct(cartItems[index], context),
                      separatorBuilder: (context, index) => SizedBox(height: 5),
                      itemCount: cartItems.length,
                    ),
          bottomNavigationBar: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${total.toStringAsFixed(2)}', // Format the total to 2 decimal places
                  style: const TextStyle(fontSize: 18, color: Colors.red),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
