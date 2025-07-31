import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/component/components.dart';
import '../../shared/cubit/shop_cubit.dart';
import '../../shared/cubit/shop_states.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state){},
      builder: (context, state){
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          builder: (context) => ListView.separated(
              itemBuilder: (context, index) => buildListProduct(ShopCubit.get(context).favouritesModel!.data!.data![index].product, context),
              separatorBuilder: (context, index) => const SizedBox(),
              itemCount: ShopCubit.get(context).favouritesModel!.data!.data!.length
          ),
          fallback: (BuildContext context) => const Center(child: CircularProgressIndicator()),
        );
      } ,
    );
  }


}
