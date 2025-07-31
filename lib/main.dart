import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/app_states.dart';
import 'package:shop_app/shared/cubit/shop_cubit.dart';
import 'modules/onbording/onboarding_screen.dart';
import 'network/local/cache_helper.dart';
import 'network/remote/dio_helper.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget? widget;
  bool onBoarding = CacheHelper.getData(key: 'onBoarding') ?? false;
  token = CacheHelper.getData(key: 'token');

  if(onBoarding != null)
    {
      if(token != null) widget = ShopLayout();
      else widget = LoginScreen();
    }
  else{
    widget = OnBoardingScreen();
  }

  runApp(MyApp(startWidget: widget,));
}

class MyApp extends StatelessWidget {
  final Widget startWidget ;
  const MyApp({Key? key, required this.startWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()),
        BlocProvider(create: (context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData()),
      ],
      child: BlocBuilder<AppCubit, AppStates>(
        builder: (context, state){
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: startWidget );
        },
      ),
    );
  }
}
