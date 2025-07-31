import 'package:shop_app/models/change_favourites_model.dart';
import 'package:shop_app/models/login_model.dart';
import '../../models/category_detail_model.dart';
import '../../models/change_carst_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}

class ShopSuccessHomeDataState extends ShopStates{}

class ShopErrorHomeDataState extends ShopStates{
  final error;

  ShopErrorHomeDataState(this.error);
}

class ShopSuccessCategoriesState extends ShopStates{}

class ShopErrorCategoriesState extends ShopStates{
  final error;

  ShopErrorCategoriesState(this.error);
}

class ShopSuccessChangeFavoritesState extends ShopStates{
  final ChangeFavouritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopChangeFavoritesState extends ShopStates{}

class ShopErrorChangeFavoritesState extends ShopStates{
  final error;

  ShopErrorChangeFavoritesState(this.error);
}

class ShopSuccessChangeCartsState extends ShopStates{
  final ChangeCartsModel model;

  ShopSuccessChangeCartsState(this.model);
}

class ShopChangeCartsState extends ShopStates{}

class ShopErrorChangeCartsState extends ShopStates{
  final error;

  ShopErrorChangeCartsState(this.error);
}

class ShopLoadingGetFavoritesState extends ShopStates{}

class ShopSuccessGetFavoritesState extends ShopStates{}

class ShopErrorGetFavoritesState extends ShopStates{
  final error;

  ShopErrorGetFavoritesState(this.error);
}

class ShopLoadingGetCartsState extends ShopStates{}

class ShopSuccessGetCartsState extends ShopStates{}

class ShopErrorGetCartsState extends ShopStates{
  final error;

  ShopErrorGetCartsState(this.error);
}

class ShopLoadingUserDataState extends ShopStates{}

class ShopSuccessUserDataState extends ShopStates{
  final ShopLoginModel loginModel;

  ShopSuccessUserDataState(this.loginModel);
}

class ShopErrorUserDataState extends ShopStates{
  final error;

  ShopErrorUserDataState(this.error);
}

class ShopLoadingUpdateState extends ShopStates{}

class ShopSuccessUpdateState extends ShopStates{}

class ShopErrorUpdateState extends ShopStates{
  final error;

  ShopErrorUpdateState(this.error);
}

class ShopLoadingProductDetailsState extends ShopStates {}

class ShopSuccessProductDetailsState extends ShopStates {}

class ShopErrorProductDetailsState extends ShopStates {
  final error;
  ShopErrorProductDetailsState(this.error);
}

class ShopLoadingCategoryDetailsState extends ShopStates {}

class ShopSuccessCategoryDetailsState extends ShopStates {
  final CategoryDetailModel categoryDetailModel;

  ShopSuccessCategoryDetailsState(this.categoryDetailModel);
}

class ShopErrorCategoryDetailsState extends ShopStates {
  ShopErrorCategoryDetailsState(String string);
}


