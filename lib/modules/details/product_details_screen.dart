import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/shop_cubit.dart';
import 'package:shop_app/shared/cubit/shop_states.dart';
import 'package:shop_app/styles/colors.dart';

class ProductDetailsScreen extends StatelessWidget {
  final int productId;

  ProductDetailsScreen(this.productId);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var product = ShopCubit.get(context).productDetailModel?.data;

        if (state is ShopLoadingProductDetailsState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (product == null) {
          return const Center(child: Text('No product details found.'));
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(product.name ?? 'Product Details' , style: const TextStyle(
              fontSize: 20
            ),),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: 300,
                        height: 300,
                        child: Image.network(product.image ?? '')
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(product.name ?? '',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold , color: defaultColor)),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Price:'),
                          const SizedBox(
                            width: 5,
                          ),
                          Text('${product.price}', style: TextStyle(color: Colors.red),),
                        ],
                      ),
                    ),
                  ),
              
                  const SizedBox(height: 20),
                  
                  Text(product.description ?? ''),

                  const SizedBox(
                    height: 20,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          ShopCubit.get(context).changeCarts(productId);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: defaultColor, // Text color
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        ),
                        child: const Text(
                          'Add to Cart',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      const SizedBox(width: 10),

                      ElevatedButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavourites(productId);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: defaultColor, // Text color
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        ),
                        child: const Text(
                          'Add to Favorites',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
