import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/component/components.dart';
import 'package:shop_app/shared/cubit/shop_cubit.dart';
import 'package:shop_app/shared/cubit/shop_states.dart';
import '../details/category_detail_screen.dart';
import '../details/product_details_screen.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopSuccessChangeFavoritesState){
          if(!state.model.status!){
            showToast(
                text: '${state.model.message}',
                state: ToastStates.ERROR
            );
          }
        }
        if(state is ShopSuccessChangeCartsState){
          if(!state.model.status!){
            showToast(
                text: '${state.model.message}',
                state: ToastStates.ERROR
            );
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null ,
            builder: (context) =>
                productsBuilder(ShopCubit.get(context).homeModel, ShopCubit.get(context).categoriesModel, context),
            fallback: (context) => const Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget productsBuilder(HomeModel? model, CategoriesModel? categoriesModel, context) {
    if (model?.data?.banners.isEmpty ?? true) {
      return const Center(child: Text('No banners available'));
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model?.data?.banners
                .map((e) => Image(
              image: NetworkImage('${e.image}'),
              width: double.infinity,
              fit: BoxFit.cover,
            ))
                .toList(),
            options: CarouselOptions(
              height: 200.0,
              initialPage: 0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        buildCategoryItem(categoriesModel!.data!.data![index], context),
                    separatorBuilder: (context, index) => const SizedBox(width: 10.0),
                    itemCount: categoriesModel!.data!.data!.length,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20, bottom: 5, left: 17, right: 17),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Explore New Products',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              childAspectRatio: 1 / 1.42,
              children: List.generate(
                  model?.data!.products.length ?? 0,
                      (index) =>
                      buildGridProduct(context, model?.data!.products[index])),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoryItem(DataModel model, context) => GestureDetector(
    onTap: (){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CategoryDetailScreen(model.id!),// Pass the category ID
        ),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: Colors.grey.shade400,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              height: 40,
              width: 40,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 3,
            ),
            Container(
              child: Text(
                '${model.name}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    ),
  );

  Widget buildGridProduct(context, ProductModel? model) => Padding(
    padding: const EdgeInsets.all(10),
    child: GestureDetector(
      onTap: () {
        ShopCubit.get(context).getProductDetails(model!.id!);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(model.id!),
          ),
        );
      },
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
                    image: NetworkImage('${model?.image}'),
                    width: double.infinity,
                    height: 120.0,
                  ),
                ),
                if (model?.discount != 0)
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
                    '${model?.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14.0, height: 1.3),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${model?.price.round()}',
                        style: const TextStyle(fontSize: 11.0, color: Colors.red),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      if (model?.discount != 0)
                        Text(
                          '${model?.oldPrice.round()}',
                          style: const TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      const Spacer(),
                      SizedBox(
                        width: 25,
                        height: 28,
                        child: IconButton(
                          onPressed: () {
                            ShopCubit.get(context).changeCarts(model!.id);
                          },
                          padding: EdgeInsets.zero,
                          alignment: Alignment.center,
                          icon: Icon(
                            ShopCubit.get(context).cart[model?.id ?? ''] == true
                                ? Icons.shopping_cart
                                : Icons.shopping_cart_outlined,
                            color: ShopCubit.get(context).cart[model?.id ?? ''] == true
                                ? Colors.green
                                : Colors.grey,
                            size: 21,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: 25,
                        height: 28,
                        child: IconButton(
                          onPressed: () {
                            ShopCubit.get(context).changeFavourites(model!.id);
                          },
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: Icon(
                            ShopCubit.get(context).favourites[model?.id ?? ''] == true
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                            color: ShopCubit.get(context).favourites[model?.id ?? ''] == true
                                ? Colors.red
                                : Colors.grey,
                            size: 22,
                          ),
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
    ),
  );
}
