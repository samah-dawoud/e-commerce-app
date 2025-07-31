import 'package:flutter_bloc/flutter_bloc.dart';
import '../../network/local/cache_helper.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());

  static AppCubit get(context) => BlocProvider.of(context);
  bool isDark = false;

  void changeAppMode([bool? fromShared]){
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value){
        emit(AppChangeModeState());
      });
    }


  }
}