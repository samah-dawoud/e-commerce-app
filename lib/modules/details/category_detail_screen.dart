import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/shop_cubit.dart';
import 'package:shop_app/shared/cubit/shop_states.dart';
import '../../models/category_detail_model.dart';


class CategoryDetailScreen extends StatelessWidget {
  final int categoryId;

  CategoryDetailScreen(this.categoryId);

  Widget buildGridProduct(BuildContext context, Product model) => Padding(
    padding: const EdgeInsets.all(10),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: Colors.grey.shade400,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Image(
                  image: NetworkImage('${model.image}'),
                  width: double.infinity,
                  height: 120.0,
                ),
              ),
              if (model.discount != 0)
                Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: const Text('DISCOUNT',
                      style: TextStyle(fontSize: 10.0, color: Colors.white)),
                )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14.0, height: 1.3),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${model.price?.round()}',
                      style: const TextStyle(fontSize: 11.0, color: Colors.red),
                    ),
                    const SizedBox(width: 4),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice?.round()}',
                        style: const TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),

                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()..getCategoryDetails(categoryId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Category Details'),
        ),
        body: BlocBuilder<ShopCubit, ShopStates>(
          builder: (context, state) {
            if (state is ShopLoadingCategoryDetailsState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ShopSuccessCategoryDetailsState) {
              final categoryDetail = state.categoryDetailModel;

              if (categoryDetail?.status == false) {
                return Center(child: Text(categoryDetail!.message!));
              }

              if (categoryDetail!.data!.products == null || categoryDetail.data!.products!.isEmpty) {
                return Center(child: Text('No products found.'));
              }

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1 / 1.4,
                ),
                itemCount: categoryDetail.data!.products!.length,
                itemBuilder: (context, index) => buildGridProduct(context, categoryDetail.data!.products![index]),
              );
            } else {
              return Center(child: Text('An error occurred.'));
            }
          },
        ),
      ),
    );
  }
}
