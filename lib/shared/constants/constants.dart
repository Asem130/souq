import '../../moduels/shop_app/login/login_screen.dart';
import '../componantes/componantes.dart';
import '../network/remote/shared_preference/cache_helper.dart';

void SingOut(context)
{
  CacheHelper.removeData(key: 'token').then((value){
    if (value){
      navigateAndFinish(context, ShopLogin());
    }
  });
}

String? token ;