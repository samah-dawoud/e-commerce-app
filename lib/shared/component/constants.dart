import 'package:path/path.dart';
import '../../modules/login/login_screen.dart';
import '../../network/local/cache_helper.dart';
import 'components.dart';

void logOut(context){
  CacheHelper.removeData(key: "token").then((value) {
    if (value!) {
      navigateAndFinish(context, LoginScreen());
    }
  });
}

void printFullText(String? text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text!).forEach((match) => print(match.group(0)));
}

String? token = '';