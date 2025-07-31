import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import '../../../network/end_points.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{

  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
}){

    emit(ShopRegisterLoadingState());

    DioHelper.postData(
        url: REGISTER,
        data: {
          'email':email,
          'name':name,
          'phone':phone,
          'password':password,
        }
    ).then((value){
      print(value?.data);
      loginModel = ShopLoginModel.fromJson(value?.data);

      emit(ShopRegisterSuccessState(loginModel!));
    }).catchError((error){
      emit(ShopRegisterErrorState(error.toString()));
    });

  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility(){
    isPassword= !isPassword;

    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ShopChangePasswordVisibilityState());


  }



}