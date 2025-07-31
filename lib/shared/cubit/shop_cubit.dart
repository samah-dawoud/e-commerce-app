import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/favourites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/favourite/favourites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/setting_screen.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/shared/cubit/shop_states.dart';
import '../../models/category_detail_model.dart';
import '../../models/change_carst_model.dart';
import '../../models/change_favourites_model.dart';
import '../../models/product_details_model.dart';
import '../../modules/cart/cart_screen.dart';
import '../../network/end_points.dart';
import '../component/constants.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  HomeModel? homeModel;
  CategoriesModel? categoriesModel;
  FavouritesModel? favouritesModel;
  ShopLoginModel? userModel;
  ProductDetailModel? productDetailModel;
  ChangeFavouritesModel? changeFavouritesModel;
  ChangeCartsModel? changeCartsModel;
  Map<int?, bool?> favourites = {};
  Map<int?, bool?> cart = {};

  List<Widget> bottomScreens = [
    const ProductsScreen(),
    CartScreen(),
    const FavouritesScreen(),
    SettingScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value?.data);
      homeModel?.data?.products.forEach((element) {
        favourites[element.id] = element.inFavorites;
        cart[element.id] = element.inCart;
      });
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      emit(ShopErrorHomeDataState(error));
    });
  }

  void getCategories() {
    DioHelper.getData(url: GET_CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value?.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      emit(ShopErrorCategoriesState(error));
    });
  }

  void changeFavourites(int? productId) {
    favourites[productId] = !favourites[productId]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
      url: FAVORITES,
      data: {'product_id': productId},
      token: token,
    ).then((value) {
      changeFavouritesModel = ChangeFavouritesModel.fromJson(value?.data);
      if (!changeFavouritesModel!.status!) {
        favourites[productId] = !favourites[productId]!;
      } else {
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavouritesModel!));
    }).catchError((error) {
      favourites[productId] = !favourites[productId]!;
      emit(ShopErrorChangeFavoritesState(error));
    });
  }

  void changeCarts(int? productId) {
    cart[productId] = !cart[productId]!;
    emit(ShopChangeCartsState());
    DioHelper.postData(
      url: CARTS,
      data: {'product_id': productId},
      token: token,
    ).then((value) {
      changeCartsModel = ChangeCartsModel.fromJson(value?.data);
      if (!changeCartsModel!.status!) {
        cart[productId] = !cart[productId]!;
      }
      emit(ShopSuccessChangeCartsState(changeCartsModel!));
    }).catchError((error) {
      cart[productId] = !cart[productId]!;
      emit(ShopErrorChangeCartsState(error));
    });
  }

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favouritesModel = FavouritesModel.fromJson(value?.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      emit(ShopErrorGetFavoritesState(error));
    });
  }

  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      userModel = ShopLoginModel.fromJson(value?.data);
      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error) {
      emit(ShopErrorUserDataState(error));
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {"name": name, "email": email, "phone": phone},
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value?.data);
      emit(ShopSuccessUpdateState());
    }).catchError((error) {
      emit(ShopErrorUpdateState(error));
    });
  }

  void getProductDetails(int productId) {
    emit(ShopLoadingProductDetailsState());
    DioHelper.getData(url: 'products/$productId', token: token).then((value) {
      productDetailModel = ProductDetailModel.fromJson(value?.data);
      emit(ShopSuccessProductDetailsState());
    }).catchError((error) {
      emit(ShopErrorProductDetailsState(error));
    });
  }

  CategoryDetailModel? categoryDetailModel;

  void getCategoryDetails(int categoryId) {
    emit(ShopLoadingCategoryDetailsState());
    DioHelper.getData(url: 'categories/$categoryId').then((value) {
      categoryDetailModel = CategoryDetailModel.fromJson(value?.data);
      emit(ShopSuccessCategoryDetailsState(categoryDetailModel!));
    }).catchError((error) {
      emit(ShopErrorCategoryDetailsState(error.toString()));
      print('Error fetching category details: $error');
    });
  }


}
