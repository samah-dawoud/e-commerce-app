import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../modules/details/product_details_screen.dart';
import '../cubit/shop_cubit.dart';


Widget defaultFormfield( {
  required TextEditingController controller,
  required TextInputType type,
  void Function(String)? onSubmit,
  void Function(String)? onChanged,
  void Function()? onTap,
  bool isPassword = false,
  required String? Function(String?) validate,
  required String label,
  IconData? prefix,
  IconData? suffix,
  void Function()? suffixPressed,
  bool isClickable = true,
  Color borderColor = Colors.blue,
  Color labeledColor = Colors.blue,
  TextStyle? textStyle,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      onTap: onTap,
      enabled: isClickable,
      obscureText: isPassword,
      validator: validate,
      style: textStyle,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: labeledColor),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: borderColor),
        ),
        suffixIcon: suffix != null
            ? IconButton(onPressed: suffixPressed, icon: Icon(suffix))
            : null,
        prefixIcon: Icon(prefix ,color:Colors.indigo),
      ),
    );


void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),);

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (route){
      return false;
    }
);

void showToast(
{
  required String text,
  required ToastStates state

}
    ) => Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStates {
  SUCCESS, ERROR , WARNING
}

Color chooseToastColor(ToastStates state){
  Color color;
  switch(state)
      {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;

  }
  return color;
}


Widget buildListProduct(model, context, {bool isOldPrice = true}) => Padding(
  padding: const EdgeInsets.all(10.0),
  child: GestureDetector(
    onTap: () {
      ShopCubit.get(context).getProductDetails(model.id);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(model.id),
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
      width: 100,
      height: 120,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image(
                    image: NetworkImage('${model?.image}'),
                    width: 80.0,
                    height: 80.0,
                  ),
                ),
                if (model?.discount != 0 && isOldPrice)
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.white,
                      ),
                    ),
                  )
              ],
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model?.name ?? 'Unknown'}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        model?.price?.toString() ?? '0',
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      if (model?.discount != 0)
                        Text(
                          model?.oldPrice?.toString() ?? '0',
                          style: const TextStyle(
                            fontSize: 11.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      if (model?.id != null) // Ensure id is not null
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
  ),
);
