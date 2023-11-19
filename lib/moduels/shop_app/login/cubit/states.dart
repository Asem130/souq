import 'package:revation/models/login_model.dart';

abstract class ShopStates { }
class InitialState extends ShopStates { }
class LodingState extends ShopStates { }
class SuccsessState extends ShopStates {
late final LoginModel loginModel;
SuccsessState(this.loginModel);

}
class ErrorState extends ShopStates {
late String error;
ErrorState(this.error);
}
class SuffixChange extends ShopStates{ }